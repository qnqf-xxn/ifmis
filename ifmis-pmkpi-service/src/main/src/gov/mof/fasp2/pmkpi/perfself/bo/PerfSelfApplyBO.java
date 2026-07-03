package gov.mof.fasp2.pmkpi.perfself.bo;

import com.jspsmart.upload.File;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportErrorDTO;
import gov.mof.fasp2.buscore.ca.user.util.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.table.dto.DicTableDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.datacommon.workflow.dto.WorkflowBranchDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfcommon.expdoc.IExpDocABO;
import gov.mof.fasp2.pmkpi.perfcommon.impexp.IImpExpABO;
import gov.mof.fasp2.pmkpi.perfcommon.impexp.ImpExpAComponet;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfApplyDAO;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfTaskManageDAO;
import gov.mof.fasp2.pmkpi.perfself.tab.SelfDescDAO;
import gov.mof.fasp2.pmkpi.perfself.tab.SelfIndexDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

public class PerfSelfApplyBO extends PmkpiBO implements IImpExpABO, IExpDocABO {
    private PerfSelfApplyDAO perfSelfApplyDAO;

    public void setPerfSelfApplyDAO(PerfSelfApplyDAO perfSelfApplyDAO) {
        this.perfSelfApplyDAO = perfSelfApplyDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        //页面类型
        List queryConfig = (List) sqlmap.get("queryConfig");
        Map<String, String> queryParam = new HashMap<String, String>();
        if (queryConfig != null && queryConfig.size() > 0) {
            queryParam = (Map<String, String>) queryConfig.get(0);
        }
        String wheresql = (String) sqlmap.get("querySql");
        String isleaf = (String) sqlmap.get("isleaf");
        String agency = (String) sqlmap.get("agency");
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String workflow = (String) sqlmap.get("workflow");
        String tabcode = (String) sqlmap.get("tabcode");
        String bustype = (String) sqlmap.get("bustype");
        String MINAMOUNT = queryParam.get("c1");
        String MAXAMOUNT = queryParam.get("c2");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        //资金条件  ((C2 like '%20%'))
        if (wheresql != null && !wheresql.isEmpty() && wheresql.contains("((C2")) {
            String cutsql = wheresql.substring(wheresql.indexOf("((C2"), wheresql.lastIndexOf("%'))") + 4);
            wheresql = wheresql.replace(cutsql, "BUDGETAMOUNT <=" + MAXAMOUNT + " ");
        }
        //资金条件  ((C1 like '%20%'))
        if (wheresql != null && !wheresql.isEmpty() && wheresql.contains("((C1")) {
            String cutsql = wheresql.substring(wheresql.indexOf("((C1"), wheresql.lastIndexOf("%'))") + 4);
            wheresql = wheresql.replace(cutsql, "BUDGETAMOUNT >=" + MINAMOUNT + " ");
        }
        StringBuffer sql = new StringBuffer("select * from ");
        if (PerfUtil.getIsHbei()) {
            //河北环境不用code    yearflag  1-总体   0-年度
            tablecode += "_HB";
        }
        sql.append(tablecode).append(" t ");
        sql.append(" where t.bustype='").append(bustype).append("'");
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            sql.append(" and (").append(tablesql).append(")");
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            sql.append(" and (").append(tabfilter).append(")");
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            sql.append(" and ( ").append(wfsql);
            if (tabcode != null && !tabcode.isEmpty() && "waitaudit".equals(tabcode)){
                sql.append(" or wfstatus is null ");
            }
            sql.append(" )");
        }
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, perfSelfApplyDAO.PMKPI_TABLE_T_AGENCY));
        sql.append(datarule);
        if(PerfUtil.getIsNINGXIA() && !"dept".equals(bustype)){
            sql.append(" and t.is_sue = '1' "); // 宁夏模式 加抽评已下发条件
        }
        return sql.toString();
    }


    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = PerfSelfTaskManageDAO.PERF_TABLE_SELFEVALTASK;
        String busguid = (String) params.get("busguid");
        String bustype = (String) params.get("bustype");
        String wfstatus = (String) datas.get(0).get("wfstatus");
        if("cancelsendaudit".equals(actioncode) && !StringUtil.isEmpty(wfstatus) && "011".equals(wfstatus)){
            Map remap = new HashMap();
            remap.put("msg", "请使用正确的审核菜单进行取消终审！");
            throw new PerfAppException("", (String) remap.get("msg"), remap);
        }else if("sendaudit".equals(actioncode)){
            List<WorkflowBranchDTO> workflowBranchList= PerfServiceFactory.getIWorkflowService().queryWorkflowBranchsByWfStatus(workflow,wfstatus);
            if(workflowBranchList.size()>0){
                for (WorkflowBranchDTO workflowBranch : workflowBranchList) {
                    if(workflowBranch.getAction().equals("audit") && workflowBranch.getWfstatus().equals("011")){
                        Map remap = new HashMap();
                        remap.put("msg", "请使用正确的审核菜单进行终审！");
                        throw new PerfAppException("", (String) remap.get("msg"), remap);
                    }
                }
            }
        }
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        //送审删除对应的暂存数据
//        if (!StringUtil.isEmpty(actioncode) && "sendaudit".equals(actioncode) && datas != null && datas.size() > 0) {
//            List<String> guids = new ArrayList<String>();
//            for (Map<String, Object> m : datas){
//                String guid = (String) m.get("guid");
//                guids.add(guid);
//            }
//            String delsql = " mainguid in('" + guids.stream().collect(Collectors.joining(",")).replace(",","','") + "')";
//            Map delparams = new HashMap();
//            delparams.put("delsql",delsql);
//            PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
//            perfMidsaveBO.delData(delparams);
//        }
        //处理规范表数据
        PerfSelfAuditBO perfSelfAuditBO = (PerfSelfAuditBO) PerfServiceFactory.getBean("pmkpi.perfSelf.PerfSelfAuditBOTX");
        perfSelfAuditBO.updateTabelDatas(datas, actioncode, bustype);
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * <p>左侧树-整合菜单首次进入页面</p >
     *
     * @param
     * @author hw
     * @date 2021/7/17 16:06
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String lefttabtype = (String) params.get("lefttabtype");
        String tablecode = (String) params.get("tablecode");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        datarule += " and bustype='" + lefttabtype + "'";
        return perfSelfApplyDAO.getLeftTree(tablecode, datarule);
    }

    public Map<String, Object> findByProjGuid(HashMap<String, Object> params) {
        String projguid = (String) params.get("projguid");
        List list = perfSelfApplyDAO.queryForList("select * from V_PERF_T_SELFEVALTASK where projguid ='" + projguid + "'");
        Map map = new HashMap();
        if (list.size() > 0) {
            map = (Map) list.get(0);
        }
        return map;
    }

    /**
     * <p>导出-获取模板数据</p >
     *
     * @param
     * @author hw
     * @date 2022/5/17 11:06
     */
    @Override
    public List<Map<String, Object>> genExpData(Map param, Map templateMap) throws PerfAppException {
        logger.info("---绩效自评导出模板 start ---");
        logger.info("---templateMap: " + templateMap.toString());
        //选择列表数据guid集合
        List<String> guids = (List<String>) param.get("guids");
        Map subMap = new HashMap();
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        String expType = (String) templateMap.get("exptype");
        String expfilename;
        for (String guid : guids) {
            expfilename = (String) templateMap.get("expfilename");
            subMap = this.getExpReport(param, guid);
            Map<String, Object> mainMap = (Map<String, Object>) subMap.get(guid);
            expfilename = this.getExpfilename(mainMap, expfilename);
            subMap.put("expfilename", expfilename + "." + expType);
            list.add(subMap);
        }
        logger.info("---绩效自评导出模板 end ---");
        return list;
    }

    @Override
    public List busImpDatas(Map paras, String filename, List<? extends Map> datalist) throws AppException {
        return null;
    }

    @Override
    public Map busImpConfirmDatasSave(Map paras, ArrayList datalist) throws AppException {
        return null;
    }

    @Override
    public List busExpDatas(Map paras) throws AppException {
        return null;
    }

    @Override
    public List imp(File file, Map paras) throws Exception {
        return null;
    }

    @Override
    public List impreport(File file, Map paras) throws Exception {
        return null;
    }

    @Override
    public List impData(List datas, Map paras) throws AppException {
        if (datas.size() > 0) {
            return this.impreportDatas((Map<Integer, Object>) datas.get(0), paras);
        }
        return null;
    }

    /**
     * 报告导入
     * @param datas --
     * @param paras --
     * @return --
     */
    private List impreportDatas(Map<Integer,Object> datas, Map paras) throws AppException {
        List cols = (List) paras.get("reporttablecolsconfig");//导入列模板配置
        String impType = (String) paras.get("impServicetype");//导入类型，合肥、安徽
        String mainguid = (String) paras.get("mainguid");
        String agencyguid = (String) paras.get("agencyguid");
        //工作流状态
        String wfstatus = (String) paras.get("wfstatus");
        //工作流id
        String workflow = (String) paras.get("workflow");
        String lefttabtype = (String) paras.get("lefttabtype");
        String wheresql = " guid='" + mainguid + "'";
        String pro_code = "";
        String proguid = "";
        String name = "";
        Map<String, Object> allData = new HashMap<>();
        List<Map<String, Object>> mainDatas = this.getDatas(PerfSelfTaskManageDAO.PERF_TABLE_SELFEVALTASK, wheresql, null);
        if (mainDatas.size() > 0) {
            pro_code = (String) mainDatas.get(0).get("pro_code");
            proguid = (String) mainDatas.get(0).get("projguid");
            name = (String) mainDatas.get(0).get("name");
        }
        if ("program".equals(lefttabtype)){
            try{
                String proname = "";
                if ("hfimp".equals(impType)) {
                    proname = ((List<String>) datas.get(3)).get(1);
                } else {
                    proname = ((List<String>) datas.get(5)).get(1);
                }
                if (!proname.equals(name)) {
                    throw new AppException("ERROR", "选择数据的项目名称和导入的不一致，请检查！");
                }
            } catch (Exception e) {
                throw new AppException("ERROR", "选择数据的项目名称和导入的不一致，请检查！");
            }
        } else if ("dept".equals(lefttabtype)){
            try{
                String agencyname = "";
                if ("hfimp".equals(impType)) {
                    if (((List<String>) datas.get(3)).get(1).contains("-")) {
                        agencyname = ((List<String>) datas.get(3)).get(1).split("-")[1];
                    } else {
                        agencyname = ((List<String>) datas.get(3)).get(1);
                    }
                } else {
                    agencyname = ((List<String>) datas.get(2)).get(1).split("-")[1];
                }
                if (!agencyname.equals(name)) {
                    throw new AppException("ERROR", "选择数据的单位/部门名称和导入的不一致，请检查！");
                }
            } catch (Exception e) {
                throw new AppException("ERROR", "选择数据的单位/部门名称和导入的不一致，请检查！");
            }
        }
        if ("program".equals(lefttabtype)){
            allData = this.getImpreportProgramData(cols, datas, mainguid, pro_code, proguid, lefttabtype, agencyguid, impType);

        } else if ("dept".equals(lefttabtype)){
            allData = this.getImpreportDeptData(cols, datas, mainguid, pro_code, proguid, lefttabtype, agencyguid);
        }
        if (allData.containsKey("errorList")){
            return (List) allData.get("errorList");
        }
        return this.setImpreportDatas(mainguid, lefttabtype, allData, paras, wfstatus, workflow, mainDatas);
    }

    /**
     * 获取项目导入报告数据
     * @param cols
     * @param datas
     * @return
     */
    private Map<String, Object> getImpreportProgramData(List cols, Map<Integer, Object> datas, String mainguid, String procode, String proguid, String lefttabtype, String agencyguid, String impType) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        List<Map<String, Object>> bgtList = new ArrayList<>();//导入预算执行率数据集合
        List<Map<String, Object>> descList = new ArrayList<>();//自评信息数据急和
        List<Map<String, Object>> indexList = new ArrayList<>();//导入指标数据集合
        List<Map<String, Object>> indexs = new ArrayList<>();//最终处理入库的指标数据
        Map<String, Object> dataMap = null;
        float bgtget = 0;
        int size = 0;
        String findexname = "";
        String sindexname = "";
        int indexRowNum = 0;
        for (Object obj : cols) {
            Map<String, Object> col = (Map<String, Object>) obj;
            Integer rownum = Integer.parseInt(col.get("num") + "");//行数
            Integer rowendnum = !StringUtil.isNullOrEmpty(col.get("endnum") + "") ? Integer.parseInt(col.get("endnum") + "") : 0;//结束行数
            String datatype = (String) col.get("datatype");
            for (Integer i : datas.keySet()) {
                List<String> impData = (List) datas.get(i);
                if ("hfimp".equals(impType)) {
                    if ("bgtget".equals(datatype) && rownum == i) {//预算执行率
                        dataMap = this.setImpData(col, impData);
                        if (!dataMap.isEmpty()) {
                            dataMap.put("pro_code", procode);
                            dataMap.put("name", "一般公共预算");
                            bgtList.add(dataMap);
                        }
                        break;
                    }
                } else {
                    if(rowendnum == 0){
                        rowendnum = rownum + 2;
                    }
                    if ("bgtget".equals(datatype) && rownum <= i && i <= (rowendnum)) {//预算执行率
                        dataMap = this.setImpData(col, impData);
                        if (!dataMap.isEmpty()) {
                            dataMap.put("pro_code", procode);
                            bgtList.add(dataMap);
                        }
                        if (i == (rowendnum)) {
                            break;
                        }
                    }
                }
                if("desc".equals(datatype) && rownum == i){//部门整体预算执行情况
                    dataMap = this.setImpData(col, impData);
                    if (!dataMap.isEmpty()) {
                        dataMap.put("agencyguid", agencyguid);
                        dataMap.put("mainguid", mainguid);
//                        dataMap.remove("yeargoal");//保存不处理
                        this.setInitData(dataMap);
                        descList.add(dataMap);
                    }
                    break;
                } else  if ("index".equals(datatype) && rownum <= i && i <= datas.size()-1) {//指标不包含最后一行数据
                    if (rownum == i) {
                        indexRowNum = i;
                        size = impData.size();
                    }
                    dataMap = new HashMap<>();
                    int j = 0;
                    if (size == impData.size()) {
                        findexname = impData.get(0);
                        sindexname = impData.get(1);
                    } else if (size == (impData.size()+1)) {
                        sindexname = impData.get(0);
                    }
                    for (String key : col.keySet()){
                        String value = col.get(key) + "";
                        String s = "";
                        if (("c" + (j+1)).equals(key) && !value.isEmpty() && !"null".equals(value)) {
                            if (size == impData.size() + 2) {
                                impData.add(0, sindexname);
                                impData.add(0, findexname);
                            } else if (size == impData.size() + 1) {
                                impData.add(0, findexname);
                            }
                            String str = impData.get(j).trim();
                            if ("@@@".equals(str)) {
                                str = null;
                            }
                            dataMap.put(value, str);
                            j++;
                        }
                    }
                    indexList.add(dataMap);
                }
            }
        }

        if (indexList.size() > 0) {
            Map<String, Object> indexMap = this.setImpIndexDatas(indexList, mainguid, lefttabtype, proguid, procode, agencyguid, indexRowNum);
            if (indexMap.containsKey("errorList")){
                return indexMap;
            } else {
                indexs = (List<Map<String, Object>>) indexMap.get("datas");
            }
        }
        if (bgtList.size() > 0) {
            bgtget = this.setImpBgtDatas(bgtList, mainguid, lefttabtype, agencyguid);
        }
        backMap.put("v_perf_t_selfperfindex", indexs);
        backMap.put("v_perf_t_selfprofund", bgtList);
        backMap.put("v_perf_t_selfperfdesc", descList);
        backMap.put("bgtget", bgtget);
        return backMap;
    }

    /**
     * 部门整体
     * @param cols
     * @param datas
     * @return
     */
    private Map<String, Object> getImpreportDeptData(List cols, Map<Integer, Object> datas, String mainguid, String procode, String proguid, String lefttabtype, String agencyguid) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        List<Map<String, Object>> bgtList = new ArrayList<>();//导入预算执行率数据集合
        List<Map<String, Object>> descList = new ArrayList<>();//自评信息数据集合
        Map<String, Object> descMap = new HashMap<>();//自评信息数据
        List<Map<String, Object>> indexList = new ArrayList<>();//导入指标数据集合
        List<Map<String, Object>> indexs = new ArrayList<>();//最终处理入库的指标数据
        float bgtget = 0;//预算执行率
        Map<String, Object> dataMap = null;
        int size = 0;
        String findexname = "";
        String sindexname = "";
        int indexRowNum = 0;
        Integer rown = 0;//记录行数
        for (Object obj : cols) {
            Map<String, Object> col = (Map<String, Object>) obj;
            if (rown == 0) {
                Integer rownum = Integer.parseInt(col.get("num") + "");//行数
                rown = rownum;
            }
            String datatype = (String) col.get("datatype");
            for (Integer i : datas.keySet()) {
                List<String> impData = (List) datas.get(i);
                if ("bgtget".equals(datatype) && rown <= i) {//预算执行率
                    rown++;
                    if (impData.contains("年初设定目标") || impData.contains("年度总体目标")) {
                        break;
                    }
                    if (!impData.contains("金额合计")) {
                        dataMap = this.setImpData(col, impData);
                        if (!dataMap.isEmpty()) {
                            dataMap.put("pro_code", procode);
                            bgtList.add(dataMap);
                        }
                    }
                } else if(("desc1".equals(datatype) || "desc2".equals(datatype)) && rown == i){//部门整体目标完成情况
                    if (impData.size() > 0) {
                        dataMap = this.setImpData(col, impData);
                        if (!dataMap.isEmpty()) {
                            dataMap.put("agencyguid", agencyguid);
                            dataMap.put("mainguid", mainguid);
                            this.setInitData(dataMap);
                            descMap.putAll(dataMap);
                        }
                        if (i == rown) {
                            rown = rown + 1;
                            break;
                        }
                    } else {
                        rown++;
                    }
                } else  if ("index".equals(datatype) && (rown + 1) <= i && i <= datas.size()-1) {//指标不包含最后一行数据
                    if ((rown + 1) == i) {
                        indexRowNum = i;
                        size = impData.size();
                    }
                    dataMap = new HashMap<>();
                    int j = 0;
                    if (size == impData.size()) {
                        findexname = impData.get(0);
                        sindexname = impData.get(1);
                    } else if (size == (impData.size()+1)) {
                        sindexname = impData.get(0);
                    }
                    for (String key : col.keySet()){
                        String value = col.get(key) + "";
                        if (("c" + (j + 1)).equals(key) && !value.isEmpty() && !"null".equals(value)) {
                            if (size == impData.size() + 2) {
                                impData.add(0, sindexname);
                                impData.add(0, findexname);
                            } else if (size == impData.size() + 1) {
                                impData.add(0, findexname);
                            }
                            String str = impData.get(j).trim();
                            if ("@@@".equals(str)) {
                                str = null;
                            }
                            dataMap.put(value, str);
                            j++;
                        }
                    }
                    indexList.add(dataMap);
                }
            }
        }
        if (indexList.size() > 0) {
            Map<String, Object> indexMap = this.setImpIndexDatas(indexList, mainguid, lefttabtype, proguid, procode, agencyguid, indexRowNum);
            if (indexMap.containsKey("errorList")){
                return indexMap;
            } else {
                indexs = (List<Map<String, Object>>) indexMap.get("datas");
            }
        }
        if (bgtList.size() > 0) {
            bgtget = this.setImpBgtDatas(bgtList, mainguid, lefttabtype, agencyguid);
        }
        if (!descMap.isEmpty()) {
            String deviationanaly = (String) descMap.get("deviationanaly");
            if (!StringUtil.isEmpty(deviationanaly)) {
                descMap.put("deviationanaly", deviationanaly.replace("整改的措施与建议:",""));
            }
            descMap.put("yeargoal", null);
            descList.add(descMap);
        }
        backMap.put("v_perf_t_selfperfindex", indexs);
        backMap.put("v_perf_t_selfprofund", bgtList);
        backMap.put("v_perf_t_selfperfdesc", descList);
        backMap.put("bgtget", bgtget);
        return backMap;
    }

    /**
     * 处理导入数据，和字段对应
     * @param col
     * @param impData
     * @return
     */
    private Map<String, Object> setImpData(Map<String, Object> col, List<String> impData) {
        Map dataMap = new HashMap<>();
        int j = 0;
        for (String key : col.keySet()){
            String value = col.get(key) + "";
            if (("c"+(j+1)).equals(key) && !value.isEmpty() && !"null".equals(value)) {
                String str = impData.get(j).trim();
                if ("@@@".equals(str)) {
                    str = null;
                }
                dataMap.put(value, str);
                j++;
            }
        }
        return dataMap;
    }

    /**
     * 处理导入的预算执行率数据
     * @param bgtList
     * @param mainguid
     * @param lefttabtype
     * @param agencyguid
     * @return
     */
    private float setImpBgtDatas(List<Map<String, Object>> bgtList, String mainguid, String lefttabtype, String agencyguid){
        float bgtget = 0;
        int i = 0;
        BigDecimal sumamt4 = new BigDecimal(0);
        BigDecimal sumamt3 = new BigDecimal(0);
        for (Map<String, Object> bgtMap : bgtList) {
            String name = "其中：本年财政拨款";
            if (name.equals(bgtMap.get("name"))) {
                bgtMap.put("name", "本年财政拨款");
            }
            //预算执行率
            BigDecimal amt4 = bgtMap.get("amt4") == null || "".equals(bgtMap.get("amt4")) ? new BigDecimal("0") : new BigDecimal((bgtMap.get("amt4") +"").replace(",",""));
            BigDecimal amt3 = bgtMap.get("amt3") == null || "".equals(bgtMap.get("amt3")) ? new BigDecimal("0") : new BigDecimal((bgtMap.get("amt3") +"").replace(",",""));
            sumamt4 = PerfUtil.addTwoNum(amt4, sumamt4);
            sumamt3 = PerfUtil.addTwoNum(amt3, sumamt3);
            this.getBgtFund(bgtMap,"imp");
            bgtMap.put("agencyguid", agencyguid);
            bgtMap.put("mainguid", mainguid);
            bgtMap.put("ordernum", ++i);
            bgtMap.put("score", null);
            this.setInitData(bgtMap);
        }
        if (sumamt3 == null || "0".equals(sumamt3.toString()) || sumamt3.floatValue() == 0) {
            bgtget = 0;
        } else {
            bgtget = Float.parseFloat(PerfUtil.rideTwoNum(PerfUtil.delTwoNum(sumamt4, sumamt3, 4), new BigDecimal(100)).toString());
        }
        return bgtget;
    }

    /**
     * 处理导入指标数据
     * @param indexList
     * @param mainguid
     * @param lefttabtype
     * @param proguid
     * @param procode
     * @param agencyguid
     * @return
     */
    private Map<String, Object> setImpIndexDatas(List<Map<String, Object>> indexList, String mainguid, String lefttabtype, String proguid, String procode, String agencyguid, int indexRowNum) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        List<Map<String, Object>> indexs = null;//最终处理入库的指标数据
        String time = PerfUtil.getServerTimeStamp();
        String tablecode = "";
        String querytablecode = "v_perf_t_selfperfindex";
        String type = "";
        String filter = " mainguid='" + mainguid + "'";
        if (lefttabtype != null && "dept".equals(lefttabtype)) {
            type = "DEPT";
            tablecode = "V_BGT_PERF_INDICATOR";
        } else if (lefttabtype != null && "program".equals(lefttabtype)) {
            type = "PM001";
            tablecode = "V_PM_PERF_INDICATOR";
        }
        List<Map<String, Object>> tempList = perfSelfApplyDAO.getTempdatas(type, "imp", null);
        Boolean ishave = true;
        indexs =  perfSelfApplyDAO.findIndexs(querytablecode, filter, null, "imp", tempList);
        if (indexs == null || indexs.size() <= 0) {
            if ("dept".equals(lefttabtype)) {
                filter = " mainguid='" + proguid + "'";
            } else {
                filter = " t.pro_code='" + procode + "' and t.yearflag = '0'";
            }
            indexs = perfSelfApplyDAO.findIndexs(tablecode, filter, null, "imp", tempList);
            for (Map<String, Object> map: indexs) {
                map.put("tindex", map.get("guid"));
                map.put("update_time", time);
                map.put("mainguid", mainguid);
                map.put("guid", this.getCreateguid());
            }
            ishave = false;
        }
        if (indexs.size() > 0) {
            List<Map<String, Object>> selfIndexs = perfSelfApplyDAO.getSelfFrameData(type, "imp");//获取固化指标
            float bgtget = 0;
            float score = 0;
            if (selfIndexs.size() > 0) {
                //查询预算执行率数据
                SelfIndexDAO selfIndexDAO = (SelfIndexDAO) PerfServiceFactory.getBean("pmkpi.perfSelf.SelfIndexDAO");
                Map<String, Object> bgtfundMap = selfIndexDAO.getSource(procode, proguid, mainguid);
                if (!bgtfundMap.isEmpty()) {
                    BigDecimal amt3 = bgtfundMap.get("amt3") == null || "".equals(bgtfundMap.get("amt3")) ? new BigDecimal("0") : new BigDecimal((bgtfundMap.get("amt3") +"").replace(",",""));
                    BigDecimal amt4 = bgtfundMap.get("amt4") == null || "".equals(bgtfundMap.get("amt4")) ? new BigDecimal("0") : new BigDecimal((bgtfundMap.get("amt4") +"").replace(",",""));
                    if (amt3 == null || "0".equals(amt3.toString()) || amt3.floatValue() == 0) {
                        bgtget = 0;
                        score = 0;
                    } else {
                        bgtget = Float.parseFloat(PerfUtil.delTwoNum(amt4, amt3, 4).toString()) * 100;
                        score = (float)(Math.round(bgtget/10 * 100))/100;
                    }
                }
                if (!ishave){ //固化指标也要进行保存.
                    //indexs.addAll(selfIndexs);
                    for (Map<String, Object> temap: selfIndexs) {
                        String levelno = temap.get("levelno") + "";
                        String tempguid = "";
                        if ("3".equals(levelno)){
                            tempguid = temap.get("guid")+"";
                            temap.put("createtime", time);
                            temap.put("creater", PerfUtil.getuserid());
                            temap.put("province", CommonUtil.getProvince());
                            temap.put("year", CommonUtil.getYear());
                            temap.put("update_time", time);
                            temap.put("updatetime", time);
                            temap.put("mainguid", mainguid);
                            temap.put("tindex", tempguid);
                            temap.put("guid", this.getCreateguid());
                            temap.put("status","1");
                            temap.put("kpi_evalstd","1");
                            indexs.add(temap);
                        }
                    }
                }
            }
            tempList.addAll(selfIndexs);
            //导入指标是否和入库指标一致，根据名称做对比
            for (Map<String, Object> index : indexs) {//原始数据
                index.put("agencyguid", agencyguid);
                String tindexname = (String) index.get("name");//三级指标名称
                String f = (String) index.get("findex");
                String s = (String) index.get("sindex");
                String t = (String) index.get("tindex");
                String indexval = (String) index.get("indexval");
                for (Map<String, Object> indexMap : indexList) {//导入数据
                    String sindex = (String) indexMap.get("sindex");
                    if (!StringUtil.isEmpty(sindex)) {
                        sindex = sindex.split("\\(")[0];
                    }
                    String tname = (String) indexMap.get("name");
                    if (!StringUtil.isEmpty(tindexname) && !StringUtil.isEmpty(tname) && tindexname.trim().equals(tname.trim())) {//判断导入三级指标是否存在，存在则导入，不存在则不导入                        //翻译一二级指标名称改为编码
                        String code = "";
                        String superid = "";
                        String datatype = "";
                        for (Map<String, Object> tempMap : tempList) {
                            String levelno = tempMap.get("levelno") + "";
                            String name = (String) tempMap.get("name");
                            if ("2".equals(levelno) && !StringUtil.isEmpty(name)) {
                                if (sindex.trim().equals(name.trim())) {
                                    code = tempMap.get("code") == null ? (String) tempMap.get("guid") : (String) tempMap.get("code");
                                    superid = (String) tempMap.get("superid");
                                    datatype = (String) tempMap.get("datatype");//固话指标标识
                                    indexMap.put("sindex", code);
                                    indexMap.put("findex", superid);
                                    break;
                                }
                            }
                        }
                        if (f.equals(superid) && s.equals(code)) {
                            index.put("pro_code", procode);
                            indexMap.put("indexval", indexval);
                            if (!StringUtil.isEmpty(datatype)) {
                                indexMap.remove("actualweight");
                            }
                            //固化预算执行率数据，取值范围为预算执行情况
                            if (selfIndexs.size() > 0 && "预算执行率".equals(indexMap.get("name"))) {
                                indexMap.put("score", score + "");
                                indexMap.put("actualvalue", bgtget + "");
                            }
                            index.putAll(indexMap);
                            index.put("update_time", time);
                            break;
                        }
                    }
                }
            }
            Map<String, Object> weightMap = new HashMap<>();
            for (Map<String, Object> temp : tempList) {
                String levelno = temp.get("levelno") + "";
                String guid = (String) temp.get("guid");
                if (!"3".equals(levelno)) {
                    weightMap.put(guid, temp);
                }
            }
            //校验指标权重
            List chekerrorList = this.checkImpreportIndex(indexs, weightMap, indexRowNum);
            if (chekerrorList.size() > 0) {
                backMap.put("errorList", chekerrorList);
            }
        }
        backMap.put("datas", indexs);
        return backMap;
    }

    private List setImpreportDatas(String mainguid, String lefttabtype, Map<String, Object> datas, Map paras, String wfstatus, String workflow, List<Map<String, Object>> mainDatas) throws AppException {
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        DicTableDTO dicTableDTO = null;
        List coll = null;
        String wheresql = " mainguid='" + mainguid + "'";
        float bgtget = (float) datas.get("bgtget");
        for (String tablecode : datas.keySet()) {
            if (datas.get(tablecode) instanceof List){
                List<Map<String, Object>> list = (List<Map<String, Object>>) datas.get(tablecode);
                dicTableDTO = dicQueryService.getDicTable(tablecode.toLowerCase());
                if (list.size() > 0) {//有数据进行校验和数据存储操作
                    if (dicTableDTO != null) {
                        coll = (List) dicTableDTO.getListCol();
                        List error = this.checkImpColNullable(list, coll);
                        error.addAll(this.checkImpColLength(list, coll));
                        if (error.size() > 0){
                            return error;
                        }
                    }
                    perfSelfApplyDAO.delDatas(tablecode, wheresql);
                    perfSelfApplyDAO.saveAll(list, tablecode);
                }
            }
        }
        if (StringUtil.isEmpty(wfstatus)){//工作流空，则生成工作流
            this.workflow("createnosave", workflow, "", PerfSelfTaskManageDAO.PERF_TABLE_SELFEVALTASK , mainDatas);
        }
        SelfDescDAO selfDescDAO = (SelfDescDAO) PerfServiceFactory.getBean("pmkpi.perfSelf.SelfDescDAO");
        //更新得分
        selfDescDAO.updateDescScore(mainguid, lefttabtype);
        //项目更新指标完成情况
        selfDescDAO.updateBgtget(bgtget + "", mainguid);
        return null;
    }

    private void setInitData(Map<String, Object> data){
        data.put("guid", this.getCreateguid());
        this.getBasMap(data, "add");
        data.put("is_last_inst",2);//是否终审
    }

    /**
     * 指标校验权重
     * @param indexs
     */
    private List checkImpreportIndex(List<Map<String, Object>> indexs, Map<String, Object> weightMap, int indexRowNum) throws AppException {
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        List backList = new ArrayList();
        boolean isFirst = true;
        ImportErrorDTO dto = null;
        String lasterrormsg = "";
        for (String key : weightMap.keySet()) {
            Map<String, Object> tempMap = (Map<String, Object>) weightMap.get(key);
            String levelno = tempMap.get("levelno") + "";//级次
            String indexname = (String) tempMap.get("name");
            BigDecimal checkweight = tempMap.get("weight") == null || "".equals(tempMap.get("weight")) ? new BigDecimal(0) : new BigDecimal(tempMap.get("weight") + "");//设置权重值
            BigDecimal result = new BigDecimal(0);
            for (Map<String, Object> indexdata: indexs) {
                String indexguid = "";
                BigDecimal actualweight = indexdata.get("actualweight") == null || "".equals(tempMap.get("actualweight"))? new BigDecimal(0) : new BigDecimal(indexdata.get("actualweight") + "");//权重
                BigDecimal score = indexdata.get("score") == null || "".equals(tempMap.get("score"))? new BigDecimal(0) : new BigDecimal(indexdata.get("score") + "");//得分
                if ("1".equals(levelno)) {
                    indexguid = (String) indexdata.get("findex");
                } else if ("2".equals(levelno)) {
                    indexguid = (String) indexdata.get("sindex");
                }
                if(key.equals(indexguid)){
                    result = PerfUtil.addTwoNum(result, actualweight);
                }
                if (isFirst) {
                    String name = (String) indexdata.get("name");
                    String actualvalue = (String) indexdata.get("actualvalue"); //实际完成值
                    String impscore = indexdata.get("score") + "";
                    String kpi_remark = (String) indexdata.get("kpi_remark");
                    if(StringUtil.isEmpty(actualvalue)){
                        lasterrormsg = "三级指标" + name + "：实际完成值不能为空！";
                        dto = new ImportErrorDTO(ImpExpAComponet.FILE_GUIDS.get(), indexRowNum, lasterrormsg);
                        errordao.saveErrorMsg(dto);
                        backList.add(dto);
                    } else {
                        String computesign = (String) indexdata.get("computesign");
                        if ("1".equals(computesign) || "2".equals(computesign) || "3".equals(computesign) || "4".equals(computesign) || "5".equals(computesign)) {
                            if (!actualvalue.matches("-?[0-9]+.?[0-9]*")){
                                lasterrormsg = "三级指标：" + name + " 定量指标只能填写数字！";
                                dto = new ImportErrorDTO(ImpExpAComponet.FILE_GUIDS.get(), indexRowNum, lasterrormsg);
                                errordao.saveErrorMsg(dto);
                                backList.add(dto);
                            }
                        }
                    }
                    if(StringUtil.isEmpty(impscore)){
                        lasterrormsg = "三级指标" + name + "：行得分不能为空！";
                        dto = new ImportErrorDTO(ImpExpAComponet.FILE_GUIDS.get(), indexRowNum, lasterrormsg);
                        errordao.saveErrorMsg(dto);
                        backList.add(dto);
                    }
                    //处理得分必须小于权重
                    if (score.doubleValue() < actualweight.doubleValue() && StringUtil.isEmpty(kpi_remark)) {
                        lasterrormsg = "三级指标" + name + "：评价得分分析不能为空！";
                        dto = new ImportErrorDTO(ImpExpAComponet.FILE_GUIDS.get(), indexRowNum, lasterrormsg);
                        errordao.saveErrorMsg(dto);
                        backList.add(dto);
                    }
                    if (score.doubleValue() > actualweight.doubleValue()) {
                        lasterrormsg = "三级指标：" + name + " 得分应小于等于分值！";
                        dto = new ImportErrorDTO(ImpExpAComponet.FILE_GUIDS.get(), indexRowNum, lasterrormsg);
                        errordao.saveErrorMsg(dto);
                        backList.add(dto);
                    }
                    indexRowNum++;
                }
            }
            isFirst = false;
            //校验分值应等于权重设定值
            if ("1".equals(levelno) || ("2".equals(levelno) && checkweight.doubleValue() != 0)) {
                String datatype = (String) tempMap.get("datatype");
                if(checkweight.doubleValue() != 0 && checkweight.doubleValue() != result.doubleValue()  && StringUtil.isEmpty(datatype)){
                    lasterrormsg = indexname + " 的下级指标分值录入合计应等于上级设置数！";
                    dto = new ImportErrorDTO(ImpExpAComponet.FILE_GUIDS.get(), 0, lasterrormsg);
                    errordao.saveErrorMsg(dto);
                    backList.add(dto);
                }
            }
        }
        return backList;
    }

    /**
     * 预算执行率率数据处理
     * @return
     */
    private String getBgtFund(Map<String, Object> fundMap, String type){
        String bgtwarn = "";
        BigDecimal amt1 = fundMap.get("amt1") == null || "".equals(fundMap.get("amt1")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt1") +"").replace(",",""));
        BigDecimal amt2 = fundMap.get("amt2") == null || "".equals(fundMap.get("amt2")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt2") +"").replace(",",""));
        BigDecimal amt3 = fundMap.get("amt3") == null || "".equals(fundMap.get("amt3")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt3") +"").replace(",",""));
        BigDecimal amt4 = fundMap.get("amt4") == null || "".equals(fundMap.get("amt4")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt4") +"").replace(",",""));
        BigDecimal amt5 = fundMap.get("amt5") == null || "".equals(fundMap.get("amt5")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt5") +"").replace(",",""));
        BigDecimal amt6 = fundMap.get("amt6") == null || "".equals(fundMap.get("amt6")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt6") +"").replace(",",""));
        BigDecimal amt7 = fundMap.get("amt7") == null || "".equals(fundMap.get("amt7")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt7") +"").replace(",",""));
        BigDecimal amt8 = fundMap.get("amt8") == null || "".equals(fundMap.get("amt8")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt8") +"").replace(",",""));
        BigDecimal amt9 = fundMap.get("amt9") == null || "".equals(fundMap.get("amt9")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt9") +"").replace(",",""));
        String bgtget = "0";//预算执行率
        if ("imp".equals(type)) {
            if (amt3 == null || "0".equals(amt3.toString()) || amt3.floatValue() == 0) {
                bgtget = "0";
            } else {
                bgtget = PerfUtil.rideTwoNum(PerfUtil.delTwoNum(amt4, amt3, 4), new BigDecimal(100)).toString();
            }
        }
        BigDecimal b = new BigDecimal(10000);
        if ("exp".equals(type)) {
            fundMap.put("amt1", PerfUtil.delTwoNum(amt1, b,4));
            fundMap.put("amt2", PerfUtil.delTwoNum(amt2, b,4));
            fundMap.put("amt3", PerfUtil.delTwoNum(amt3, b,4));
            fundMap.put("amt4", PerfUtil.delTwoNum(amt4, b,4));
            fundMap.put("amt5", PerfUtil.delTwoNum(amt5, b,4));
            fundMap.put("amt6", PerfUtil.delTwoNum(amt6, b,4));
            fundMap.put("amt7", PerfUtil.delTwoNum(amt7, b,4));
            fundMap.put("amt8", PerfUtil.delTwoNum(amt8, b,4));
            fundMap.put("amt9", PerfUtil.delTwoNum(amt9, b,4));
        } else if ("imp".equals(type)) {
            fundMap.put("bgtget", bgtget + "");
            fundMap.put("amt1", PerfUtil.rideTwoNum(amt1, b));
            fundMap.put("amt2", PerfUtil.rideTwoNum(amt2, b));
            fundMap.put("amt3", PerfUtil.rideTwoNum(amt3, b));
            fundMap.put("amt4", PerfUtil.rideTwoNum(amt4, b));
            fundMap.put("amt5", PerfUtil.rideTwoNum(amt5, b));
            fundMap.put("amt6", PerfUtil.rideTwoNum(amt6, b));
            fundMap.put("amt7", PerfUtil.rideTwoNum(amt7, b));
            fundMap.put("amt8", PerfUtil.rideTwoNum(amt8, b));
            fundMap.put("amt9", PerfUtil.rideTwoNum(amt9, b));
            fundMap.put("ordernum", 1);
            fundMap.put("province", CommonUtil.getProvince());
            fundMap.put("guid", this.getCreateguid());
            fundMap.put("creater", SecureUtil.getCurrentUser().getGuid());
            fundMap.put("year", CommonUtil.getYear());
            fundMap.put("agency_code", fundMap.get("agencyguid"));
            fundMap.put("create_time", PerfUtil.getServerTimeStamp());
            fundMap.put("update_time", PerfUtil.getServerTimeStamp());
            fundMap.put("mof_div_code", SecureUtil.getUserSelectProvince());
            fundMap.put("fiscal_year", CommonUtil.getYear());
            fundMap.put("is_deleted", 2);
        }
        return bgtwarn;
    }

    @Override
    public List parseFile(Map paras, String filename, InputStream is) throws AppException {
        return null;
    }

    @Override
    public List beforeParseFile(Map paras, String filename, InputStream is) throws AppException {
        return null;
    }

    @Override
    public boolean isBusGetCellValue() {
        return false;
    }

    @Override
    public Object getCellValue(Map paras, Map colconfig, HSSFCell cell, String columncode, boolean istrans) throws AppException {
        return null;
    }

    @Override
    public boolean expImpModel(Map paras, HttpServletRequest request, HttpServletResponse response) throws AppException {
        return false;
    }

    @Override
    public void beforeExpImpModel(Map paras, HttpServletRequest request, HttpServletResponse response) throws AppException {

    }

    @Override
    public List beforeExpImpCols(Map paras) throws AppException {
        return null;
    }

    @Override
    public Map transExpDatas(Map paras, List<? extends Map> datalist) throws AppException {
        return null;
    }

    @Override
    public boolean setCellValue(Map paras, Map colconfig, HSSFCell cell, String columncode, boolean istrans, Map rowdata, Map trandata, Map cellstylemap) throws AppException {
        return false;
    }

    @Override
    public void exp(Map paras, HttpServletRequest request, HttpServletResponse response) throws AppException {

    }

    /**
     * <p>导出-取数</p >
     *
     * @param
     * @author hw
     * @date 2022/5/17 11:05
     */
    private Map<String, Object> getExpReport(Map param, String guid) {
        Map<String, Object> backMap = new HashMap<>();
        String expType = (String) param.get("exptype");//导出类型，项目 program、部门整体 dept
        String reporttype = (String) param.get("reporttype");//安徽、合肥
        String viewtype = (String) param.get("viewtype");
        if (StringUtils.isEmpty(expType)) {
            return null;
        }
        String sql = "select m.name as manage_dept_name, a.name as agency_name, s.yeargoal,s.allyeargoal,s.deviationanaly,t.* from perf_v_selfevaltask t left join v_perf_t_selfperfdesc s on t.guid = s.mainguid left join pmkpi_fasp_t_pubagency a on a.guid = t.agencyguid left join pmkpi_fasp_t_pubagency m on m.guid = t.manage_dept_code where t.guid = '" + guid + "'";
        List list = perfSelfApplyDAO.queryForList(sql);
        if (list != null && !list.isEmpty()) {
            Map<String, Object> mainMap = (Map<String, Object>) list.get(0);
            String pro_code = (String) mainMap.get("pro_code");
            String proguid = (String) mainMap.get("projguid");
            String agencyguid = (String) mainMap.get("agencyguid");
            String goaltablecode = "";
            StringBuffer querysql = new StringBuffer("");
            if ("dept".equals(expType)) {
                querysql.append(" t.mainguid = '").append(proguid).append("'");
                goaltablecode = "v_bgt_perf_goal_info";
            } else if("program".equals(expType)){
                querysql.append(" t.pro_code = '").append(pro_code).append("'");
                goaltablecode = "v_pm_perf_goal_info";
                querysql.append(" and t.yearflag = '0'");
            }
            Map<String, Object> goalMap = this.getDataMap(goaltablecode, querysql.toString());
            String year = mainMap.get("year") + "";
            mainMap.put("year", year);
            mainMap.put("yeargoal", goalMap.get("kpi_target"));
            //2025_12 增加专项债券项目相关数据
            if("program".equals(expType)){
                StringBuffer zxzqsql = new StringBuffer("select b.pro_term,t.* from v_perf_project_info b left join pm_debt_info t on b.pro_code = t.pro_code where b.pro_code = ? ");
                List<Map<String, Object>> zxzqMapList = perfSelfApplyDAO.queryForList(zxzqsql.toString(),new String[]{pro_code});
                if(zxzqMapList.size()>0) {
                    Map<String, Object> zxzqMap = zxzqMapList.get(0);
                    mainMap.put("pro_term", !StringUtil.isNullOrEmpty(zxzqMap.get("pro_term")) ? zxzqMap.get("pro_term")+"年" : "");
                    mainMap.put("pro_buid_term", !StringUtil.isNullOrEmpty(zxzqMap.get("pro_buid_term")) ? zxzqMap.get("pro_buid_term")+"年" : "");
                    mainMap.put("pro_oper_term", !StringUtil.isNullOrEmpty(zxzqMap.get("pro_oper_term")) ? zxzqMap.get("pro_oper_term")+"年" : "");
                    mainMap.put("fund_invest_area_code", zxzqMap.get("fund_invest_area_code"));
                    mainMap.put("fund_invest_area_name", zxzqMap.get("fund_invest_area_name"));
                }
            }
            List<Map<String, Object>> mainlist = new ArrayList<>();
            mainlist.add(mainMap);
            backMap = this.getBgtAmtData(guid, pro_code, expType, reporttype, agencyguid); // 1.放入资金数据
            backMap.put("maindata", mainlist); // 2.放入主单信息
            backMap.put(guid, mainMap);
            backMap.put("indexdatas", this.getIndexData(guid, proguid, pro_code, expType, reporttype, viewtype)); // 3.获取指标数据
        }
        return backMap;
    }

    /**
     * <p>导出-获取预算执行情况数据</p >
     *
     * @param
     * @author hw
     * @date 2022/5/17 11:05
     */
    private Map<String, Object> getBgtAmtData(String mainguid, String procode, String expType, String reporttype, String agencyguid) {
        Map<String, Object> backMap = new HashMap<>();
        String sql = " mainguid = '" + mainguid + "'";
        List<Map<String, Object>> bgtfundList = perfSelfApplyDAO.getDatas("v_perf_t_selfprofund", sql, " order by ordernum");
        if ((bgtfundList == null || bgtfundList.isEmpty())) {
            //项目-视图取数 合肥部门从业务表取数
            StringBuffer sqlbufer = new StringBuffer();
            String tablecode = "";
            if ("program".equals(expType)) {
                sqlbufer.append(" PERF_FUNDPAY_VIEW.set_month('12') = '12' and PERF_FUNDPAY_VIEW.set_procode('").append(procode).append("')='").append(procode).append("'");
                tablecode = "v_perf_selfbdgpay_project";
                if ("hfprogram".equals(reporttype)) {
                    tablecode += "_hf";
                }
            } else if ("ahdept".equals(reporttype)){
                sqlbufer.append(" PERF_FUNDPAY_VIEW.set_month('12') = '12' and PERF_FUNDPAY_VIEW.set_agencyguid('").append(agencyguid).append("')='").append(agencyguid).append("'");
                tablecode = "v_perf_selfbdgpay_dept";
            }
            if (!StringUtil.isEmpty(tablecode)) {
                bgtfundList = perfSelfApplyDAO.getDatas(tablecode, sqlbufer.toString(), " order by ordernum");
            }
        }
        if ("program".equals(expType)) { //项目支出
            List data = null;
            for (Map<String, Object> map : bgtfundList) {
                this.getBgtFund(map, "exp");
                data = new ArrayList();
                data.add(map);
                if ("hfprogram".equals(reporttype)) {//合肥控制预算执行率导出，只有一条数据
                    backMap.put("czbgts", data);
                    break;
                } else {
                    String name = (String) map.get("name");
                    if ("本年财政拨款".equals(name)) {
                        backMap.put("bnczbgts", data);
                    } else if ("上年结转资金".equals(name)) {
                        backMap.put("snjzbgts", data);
                    } else if ("其他资金".equals(name)) {
                        backMap.put("qtbgts", data);
                    } else if ("专项债券资金".equals(name)) {
                        backMap.put("zxzqbgts", data);
                    }
                }
            }
        } else if ("dept".equals(expType)) {//部门整体
            for (Map<String, Object> map : bgtfundList) {
                this.getBgtFund(map, "exp");
            }
            backMap.put("bgtdatas", bgtfundList);
        }
        return backMap;
    }

    /**
     * <p>导出-获取指标数据</p >
     *
     * @param
     * @author hw
     * @date 2022/5/17 11:04
     */
    public List<Map<String, Object>> getIndexData(String mainguid, String proguid, String procode, String bustype, String reporttype, String viewtype) {
        String querytablecode = "v_perf_t_selfperfindex";
        String filter = " mainguid = '" + mainguid + "'";
        String type = "", tablecode = "";
        if (bustype != null && "dept".equals(bustype)) {
            type = "DEPT";
            tablecode = "v_bgt_perf_indicator";
        } else if (bustype != null && "program".equals(bustype)) {
            type = "PM001";
            tablecode = "v_pm_perf_indicator";
        }
        // 获取指标模板
        List<Map<String, Object>> tempdatas = perfSelfApplyDAO.getTempdatas(type, viewtype, reporttype);
        // 1.获取固化指标
        List<Map<String, Object>> selfdata = perfSelfApplyDAO.getSelfFrameData(type, viewtype);
        tempdatas.addAll(selfdata.stream().filter(map -> !"3".equals(map.get("levelno") + "")).collect(Collectors.toList()));
        // 从业务表获取自评指标
        List<Map<String, Object>> indexList = perfSelfApplyDAO.findIndexs(querytablecode, filter, reporttype, viewtype, tempdatas);
        if (indexList == null || indexList.isEmpty()) {
            indexList = selfdata.stream().filter(map -> "3".equals(map.get("levelno") + "")).collect(Collectors.toList());
            // 2.获取项目或者部门指标
            if ("dept".equals(bustype)) {
                filter = " mainguid = '" + proguid + "'";
            } else if ("program".equals(bustype)) {
                filter = " pro_code = '" + procode + "' and t.yearflag = '0' ";
            }
            List<Map<String, Object>> indexList1 = perfSelfApplyDAO.findIndexs(tablecode, filter, reporttype,viewtype, tempdatas);
            if (!"hfprogram".equals(reporttype) && !"hfdept".equals(reporttype)) {
                indexList1.forEach(map -> map.put("kpi_remark", ""));
            }
            tempdatas.removeAll(selfdata.stream().filter(map -> !"3".equals(map.get("levelno") + "")).collect(Collectors.toList()));
            indexList1 = this.indexAddTemp(indexList1, tempdatas);
            indexList.addAll(indexList1);
        } else { //固化和通版指标排序
            List<Map<String, Object>> selfframeList = indexList.stream().filter(map -> "selfframe".equals(map.get("datatype"))).collect(Collectors.toList()); // 固化指标
            List<Map<String, Object>> selfindexList = indexList.stream().filter(map1 -> !"selfframe".equals(map1.get("datatype"))).collect(Collectors.toList());
            tempdatas.removeAll(selfdata.stream().filter(map -> !"3".equals(map.get("levelno") + "")).collect(Collectors.toList()));
            selfindexList = this.indexAddTemp(selfindexList, tempdatas);
            indexList = new ArrayList<>();
            indexList.addAll(selfframeList);
            indexList.addAll(selfindexList);
        }
        for (Map<String, Object> map : indexList) {
            //1.指标值处理
            String computesign = map.get("computesignname") == null ? "" : (String) map.get("computesignname");
            String indexval = map.get("indexval") == null ? "" : (String) map.get("indexval");
            String meterunit = map.get("meterunit") == null ? "" : (String) map.get("meterunit");
            String actualvalue = map.get("actualvalue") == null ? "" : (String) map.get("actualvalue");
            //计算符号是"定性"时需要过滤掉
            if("定性".equals(computesign)){
                computesign = "";
            } else if ("query".equals(viewtype)){
                map.put("actualvalue", actualvalue + meterunit);
            }
            map.put("yearvalue", computesign + indexval + meterunit);
            //2.一级二级指标数量
            String findex = (String) map.get("findex");
            String sindex = (String) map.get("sindex");
            List<Map<String, Object>> findexStream = indexList.stream().filter(map1 -> findex.equals(map1.get("findex"))).collect(Collectors.toList());
            List<Map<String, Object>> sindexStream = indexList.stream().filter(map1 -> sindex.equals(map1.get("sindex"))).collect(Collectors.toList());
            map.put("findexnum", findexStream.size());
            map.put("sindexnum", sindexStream.size());
        }
        return indexList;
    }

    /**
     * <p>导出-获取文件名</p >
     *
     * @param
     * @author hw
     * @date 2022/5/16 11:38
     */
    public String getExpfilename(Map<String, Object> mainMap, String expfilename) {
        String agency_name = (String) mainMap.get("agency_name");
        String pro_code = (String) mainMap.get("pro_code");
        String name = (String) mainMap.get("name");
        String agencyguid = (String) mainMap.get("agencyguid");
        if (agency_name != null) {
            expfilename = expfilename.replace("#agency_name#", agency_name);
        } else {
            expfilename = expfilename.replace("#agency_name#", "");
        }
        if (agencyguid != null) {
            expfilename = expfilename.replace("#agencyguid#", agencyguid);
        } else {
            expfilename = expfilename.replace("#agencyguid#", "");
        }
        if (pro_code != null) {
            expfilename = expfilename.replace("#pro_code#", pro_code);
        } else {
            expfilename = expfilename.replace("#pro_code#", "");
        }
        if (name != null) {
            expfilename = expfilename.replace("#name#", name);
        } else {
            expfilename = expfilename.replace("#name#", "");
        }
        if (expfilename.contains("#systime#")) {
            expfilename = expfilename.replace("#systime#", "");
        } else {
            expfilename += "_" + PerfUtil.getServerTimeStamp();
        }
        return expfilename;
    }

    /**
     * <p>指标整合</p >
     * 如果三级指标为空则填补进去二级指标，并按照code排序
     *
     * @param
     * @author hw
     * @date 2022/5/19 19:33
     */
    public List<Map<String, Object>> indexAddTemp(List<Map<String, Object>> indexList, List<Map<String, Object>> tempdatas) {
        for (Map<String, Object> map : indexList) {
            String sindexname = (String) map.get("sindexname");
            tempdatas = tempdatas.stream().filter(map1 -> !sindexname.equals(map1.get("sindexname"))).collect(Collectors.toList());
        }
        if (tempdatas != null && !tempdatas.isEmpty()) {
            indexList.addAll(tempdatas);
            indexList.sort(Comparator.comparing((Map<String, Object> map) -> ((String) map.get("sindex"))));  //正序
        }
        return indexList;
    }

}
