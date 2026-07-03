package gov.mof.fasp2.pmkpi.perfprotrace.report;

import com.jspsmart.upload.File;
import gov.mof.fasp2.buscore.ca.user.util.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.table.dto.DicTableDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.datacommon.workflow.dto.WorkflowBranchDTO;
import gov.mof.fasp2.pmkpi.apiInterface.dto.*;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfcommon.expdoc.IExpDocABO;
import gov.mof.fasp2.pmkpi.perfcommon.impexp.IImpExpABO;
import gov.mof.fasp2.pmkpi.perfprotrace.audit.ProTraceAuditBO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.poi.hssf.usermodel.HSSFCell;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;


public class ProTraceTaskBO extends PmkpiBO implements IImpExpABO, IExpDocABO {
    private ProTraceTaskDAO proTraceTaskDAO;

    @Resource(name = "pmkpi.perfprotrace.report.ProTraceTaskDAO")
    public void setProTraceTaskDAO(ProTraceTaskDAO proTraceTaskDAO) {
        this.proTraceTaskDAO = proTraceTaskDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
//        String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
//        String prolev = (String) sqlmap.get("prolev"); //项目级别：一二三级项目
        String tasktype= (String) sqlmap.get("tasktype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String deptwfststus = (String) sqlmap.get("deptwfststus");
        String jxwfststus = (String) sqlmap.get("jxwfststus");
        if (PerfUtil.getIsHbei() && ProTraceManageDAO.PERF_VIEW_TRACEMANAGE.equals(tablecode)) {
            tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE_HB;
        }
        String columncodes = proTraceTaskDAO.getColumncodes(tablecode, "t");
        if (!StringUtil.isEmpty(columncodes)) {
            columncodes += ",case when depttask='1' and provincetask='2' and wfstatus='" + deptwfststus + "' then '011'";
            if (PerfUtil.getIsGuangXi()) {
                columncodes += " when provincetask='1' and nvl(audittype,0) <> '2' and wfstatus='" + jxwfststus + "' then '011'";
            }
            columncodes += " else wfstatus end wfstatus";
        } else {
            columncodes = "t.*";
        }
        StringBuffer returnsql = new StringBuffer("select ");
        returnsql.append(columncodes).append(" from ");
        returnsql.append(tablecode).append(" t ");
        returnsql.append(" where t.provincetask <> '3' and t.tasktype='").append(tasktype).append("'");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (!StringUtil.isEmpty(wheresql)) {
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (!StringUtil.isEmpty(tablesql)) {
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (!StringUtil.isEmpty(wfsql)) {
            returnsql.append(" and (").append(wfsql);
            if ("waitaudit".equals(tabcode)) {
                returnsql.append(" or wfstatus is null ");
            }
            returnsql.append(") ");
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, proTraceTaskDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        return returnsql.toString();
    }

    /**
     * 查询左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE;
        String tasktype = (String) params.get("tasktype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and t.tasktype = '" + tasktype + "'";
        return proTraceTaskDAO.getLeftTree(tablecode, datarule);
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String bustype = (String) params.get("bustype");
        //审核定义
        String busguid = (String) params.get("busguid");
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
        this.workflow(actioncode, workflow, remark, ProTraceManageDAO.PERF_TABLE_TRACEMANAGE, datas);
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
        ProTraceAuditBO proTraceAuditBO = (ProTraceAuditBO) PerfServiceFactory.getBean("pmkpi.perfprotrace.audit.ProTraceAuditBOTX");
        proTraceAuditBO.updateTracePayTabelDatas(datas, actioncode, bustype);
        return this.auditdefine(datas, busguid, actioncode, null);
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
        try{
            if (datas.size() > 0) {
                String impServicetype = (String) paras.get("impServicetype");
                if ("ordprogram".equals(impServicetype)) {//合肥一般监控
                    return this.impOrdProgramDatas(datas, paras);
                } else if ("impreport".equals(impServicetype)){
                    return this.impreportDatas((Map<Integer, Object>) datas.get(0), paras);
                }
            }
        } catch (AppException e) {
            throw new AppException("ERROR", e.getMessage());
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
        String mainguid = (String) paras.get("mainguid");
        String agencyguid = (String) paras.get("agencyguid");
        //工作流状态
        String wfstatus = (String) paras.get("wfstatus");
        //工作流id
        String workflow = (String) paras.get("workflow");
        String lefttabtype = (String) paras.get("lefttabtype");
        String taskstage = (String) paras.get("taskstage");
        String impreporttype = (String) paras.get("impreporttype");//导入报告类型，安徽、合肥
        String wheresql = " guid='" + mainguid + "'";
        String pro_code = "";
        String proguid = "";
        String name = "";
        Map<String, Object> allData = new HashMap<>();
        List<Map<String, Object>> mainDatas = this.getDatas(ProTraceManageDAO.PERF_TABLE_TRACEMANAGE, wheresql, null);
        if (mainDatas.size() > 0) {
            pro_code = (String) mainDatas.get(0).get("pro_code");
            proguid = (String) mainDatas.get(0).get("proguid");
            name = (String) mainDatas.get(0).get("name");
        }
        if ("protrace".equals(lefttabtype)){
            String proname = ((List<String>) datas.get(5)).get(1);
            if (!proname.equals(name)) {
                throw new AppException("ERROR", "选择数据的项目名称和导入的不一致，请检查！");
            }
        } else if ("depttrace".equals(lefttabtype)){
            String agencyname = "";
            if ("ah".equals(impreporttype)) {
                agencyname = ((List<String>) datas.get(5)).get(2).split("-")[1];
            } else if ("hf".equals(impreporttype)){
                agencyname = ((List<String>) datas.get(5)).get(1).split("-")[1];
            }
            if (!agencyname.equals(name)) {
                throw new AppException("ERROR", "选择数据的单位/部门名称和导入的不一致，请检查！");
            }
        }
        String frametype = "";
        String tablecode = "";
        if (lefttabtype != null && "depttrace".equals(lefttabtype)) {
            frametype = "DEPT";
            tablecode = "V_BGT_PERF_INDICATOR";
        } else if (lefttabtype != null && "protrace".equals(lefttabtype)) {
            frametype = "PM001";
            tablecode = "V_PM_PERF_INDICATOR";
        }
        List<Map<String, Object>> tempList = proTraceTaskDAO.getTempdatas(frametype);
        logger.info("--------------------导入参数cols--------------------:"+cols);
        logger.info("--------------------导入参数datas--------------------:"+datas);
        if ("ah".equals(impreporttype)) {
            allData = this.getImpAHreportData(cols, datas, mainguid, pro_code, proguid, lefttabtype, agencyguid, tablecode, tempList, name);
        } else if ("hf".equals(impreporttype)){
            allData = this.getImpHFreportData(cols, datas, mainguid, pro_code, proguid, lefttabtype, agencyguid, tablecode, tempList, taskstage, name);
        }
        logger.info("--------------------导入参数allData--------------------:"+allData);
        return this.setImpreportDatas(mainguid, lefttabtype, allData, paras, impreporttype, mainDatas, wfstatus, workflow);
    }

    /**
     * 获取安徽导入报告数据
     * @param cols
     * @param datas
     * @return
     */
    private Map<String, Object> getImpAHreportData(List cols, Map<Integer, Object> datas, String mainguid, String procode, String proguid, String lefttabtype, String agencyguid, String tablecode, List<Map<String, Object>> tempList, String mainname) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        List<Map<String, Object>> bgtList = new ArrayList<>();//导入预算执行率数据集合
        List<Map<String, Object>> analysisList = new ArrayList<>();//预算执行情况编辑
        List<Map<String, Object>> indexList = new ArrayList<>();//导入指标数据集合
        List<Map<String, Object>> indexs = new ArrayList<>();//最终处理入库的指标数据
        Map<String, Object> dataMap = null;
        int size = 0;
        String findexname = "";
        String sindexname = "";
        for (Object obj : cols) {
            Map<String, Object> col = (Map<String, Object>) obj;
            Integer rownum = Integer.parseInt(col.get("num") + "");//行数
            Integer rowendnum = !StringUtil.isNullOrEmpty(col.get("endnum") + "") ? Integer.parseInt(col.get("endnum") + "") : 0;//结束行数
            String datatype = (String) col.get("datatype");
            for (Integer i : datas.keySet()) {
                List<String> impData = (List) datas.get(i);
                if(rowendnum == 0){
                    rowendnum = rownum + 1;
                }
                if ("bgtget".equals(datatype) && rownum <= i && i <= (rowendnum)) {//预算执行率
                    dataMap = this.setImpData(col, impData);
                    if (!dataMap.isEmpty()) {
                        if ("depttrace".equals(lefttabtype)) {
                            dataMap.put("agency_name", mainname);
                        } else {
                            dataMap.put("pro_name", mainname);
                        }
                        bgtList.add(dataMap);
                    }
                    if (i == (rowendnum)) {
                        break;
                    }
                } else if("analysis".equals(datatype) && rownum == i){//部门整体预算执行情况
                    dataMap = this.setImpData(col, impData);
                    if (!dataMap.isEmpty()) {
                        dataMap.put("mainguid", mainguid);
                        this.setInitData(dataMap);
                        analysisList.add(dataMap);
                    }
                    break;
                } else  if ("index".equals(datatype) && rownum <= i) {//指标
                    if (rownum == i) {
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
                    int f = 1;
                    for (String key : col.keySet()){
                        String value = col.get(key) + "";
                        String s = "";
                        if (("c" + f).equals(key) && !value.isEmpty() && !"null".equals(value)) {
                            if (size == impData.size() + 2) {
                                impData.add(0, sindexname);
                                impData.add(0, findexname);
                            } else if (size == impData.size() + 1) {
                                impData.add(0, findexname);
                            }
                            String str = impData.get(j).trim();
                            if ("deviationanalysis".equals(value)) {
                                s = ",";
                                for (int n=0; n<5; n++) {
                                    str = impData.get(j).trim();
                                    if (n==0 && "√".equals(str)) {
                                        s += "dviationanalysis3,";
                                    } else if (n==1 && "√".equals(str)) {
                                        s += "dviationanalysis2,";
                                    } else if (n==2 && "√".equals(str)) {
                                        s += "dviationanalysis1,";
                                    } else if (n==3 && "√".equals(str)) {
                                        s += "dviationanalysis4,";
                                    } else if (n==4 && "√".equals(str)) {
                                        s += "dviationanalysis10,";
                                    }
                                    j++;
                                }
                                if (s.length()>1){
                                    s = s.substring(1, s.length()-1);
                                } else {
                                    s = "";
                                }
                                dataMap.put(value, s);
                                f++;
                                continue;
                            }
                            if ("completeanalysis".equals(value)) {
                                s = "";
                                for (int n=0; n<3; n++) {
                                    str = impData.get(j).trim();
                                    if (n==0 && "√".equals(str)) {
                                        s = "completeanalysis1";
                                    } else if (n==1 && "√".equals(str)) {
                                        s = "completeanalysis2";
                                    } else if (n==2 && "√".equals(str)) {
                                        s = "completeanalysis3";
                                    }
                                    j++;
                                }
                                dataMap.put(value, s);
                                f++;
                                continue;
                            }
                            if ("@@@".equals(str)) {
                                str = null;
                            }
                            dataMap.put(value, str);
                            j++;
                            f++;
                        }
                    }
                    //三级指标名称为空，不保存
                    String name = (String) dataMap.get("name");
                    if (!StringUtil.isEmpty(name)) {
                        indexList.add(dataMap);
                    }
                }
            }
        }
        if (bgtList.size() > 0) {
            setImpBgtDatas(bgtList, mainguid, lefttabtype, agencyguid, "ah", null);
        }
        if (indexList.size() > 0) {
            indexs = setImpIndexDatas(indexList, mainguid, lefttabtype, proguid, procode, agencyguid, tablecode, tempList);
        }
        backMap.put("v_perf_t_proindextrace", indexs);
        backMap.put("v_perf_t_probgtfund", bgtList);
        backMap.put("v_perf_t_protraceanalysis", analysisList);
        return backMap;
    }

    /**
     * 获取合肥导入报告数据
     * @param cols
     * @param datas
     * @return
     */
    private Map<String, Object> getImpHFreportData(List cols, Map<Integer, Object> datas, String mainguid, String procode, String proguid, String lefttabtype, String agencyguid, String tablecode, List<Map<String, Object>> tempList, String taskstage, String mainname) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        List<Map<String, Object>> bgtList = new ArrayList<>();//导入预算执行率数据集合
        List<Map<String, Object>> analysisList = new ArrayList<>();//预算执行情况编辑
        List<Map<String, Object>> indexList = new ArrayList<>();//导入指标数据集合
        List<Map<String, Object>> indexs = new ArrayList<>();//最终处理入库的指标数据
        Map<String, Object> dataMap = null;
        int size = 0;
        String findexname = "";
        String sindexname = "";
        for (Object obj : cols) {
            Map<String, Object> col = (Map<String, Object>) obj;
            Integer rownum = Integer.parseInt(col.get("num") + "");//行数
            String datatype = (String) col.get("datatype");
            for (Integer i : datas.keySet()) {
                List<String> impData = (List) datas.get(i);
                if ("bgtget".equals(datatype) && rownum == i) {//预算执行率
                    dataMap = this.setImpData(col, impData);
                    if (!dataMap.isEmpty()) {
                        if ("depttrace".equals(lefttabtype)) {
                            dataMap.put("agency_name", mainname);
                        } else {
                            dataMap.put("pro_name", mainname);
                        }
                        bgtList.add(dataMap);
                    }
                    break;
                } else if("analysis".equals(datatype) && rownum == i){//部门整体预算执行情况
                    dataMap = this.setImpData(col, impData);
                    if (!dataMap.isEmpty()) {
                        dataMap.put("mainguid", mainguid);
                        this.setInitData(dataMap);
                        analysisList.add(dataMap);
                    }
                    break;
                } else  if ("index".equals(datatype) && rownum <= i) {//指标
                    if (rownum == i) {
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
                        if (("c" + (j + 1)).equals(key) && !value.isEmpty() && !"null".equals(value)) {
                            if (size == impData.size() + 2) {
                                impData.add(0, sindexname);
                                impData.add(0, findexname);
                            } else if (size == impData.size() + 1) {
                                impData.add(0, findexname);
                            }
                            String str = impData.get(j).trim();
                            if ("completeanalysis".equals(value)) {
                                s = "";
                                str = impData.get(j).trim().split("-")[0];
                                if ("1".equals(str)) {
                                    s = "completeanalysis1";
                                } else if ("2".equals(str)) {
                                    s = "completeanalysis2";
                                } else if ("3".equals(str)) {
                                    s = "completeanalysis3";
                                }
                                j++;
                                dataMap.put(value, s);
                                continue;
                            }
                            if ("@@@".equals(str)) {
                                str = null;
                            }
                            dataMap.put(value, str);
                            j++;
                        }
                    }
                    //三级指标名称为空，不保存
                    String name = (String) dataMap.get("name");
                    if (!StringUtil.isEmpty(name)) {
                        indexList.add(dataMap);
                    }
                }
            }
        }
        String isexpfunc = "";
        if (bgtList.size() > 0) {
            isexpfunc = setImpBgtDatas(bgtList, mainguid, lefttabtype, agencyguid, "hf", taskstage);
        }
        if (indexList.size() > 0) {
            indexs = setImpIndexDatas(indexList, mainguid, lefttabtype, proguid, procode, agencyguid, tablecode, tempList);
        }
        if (bgtList.size() > 0 && analysisList.size() > 0) {
            for (Map<String, Object> map : analysisList) {
                map.put("isexpfunc", isexpfunc);
            }
        }
        backMap.put("v_perf_t_proindextrace", indexs);
        backMap.put("v_perf_t_probgtfund", bgtList);
        backMap.put("v_perf_t_protraceanalysis", analysisList);
        return backMap;
    }

    /**
     * 处理导入的预算执行率数据
     * @param bgtList
     * @param mainguid
     * @param lefttabtype
     * @param agencyguid
     * @return
     */
    private String setImpBgtDatas(List<Map<String, Object>> bgtList, String mainguid, String lefttabtype, String agencyguid, String type, String taskstage){
        int i = 0;
        String isexpfunc = "";
        for (Map<String, Object> bgtMap : bgtList) {
            if ("ah".equals(type)) {
                String name = "其中：本年一般公共预算拨款";
                if (name.equals(bgtMap.get("name"))) {
                    bgtMap.put("name", "一般公共预算拨款");
                }
            }
            isexpfunc = this.getBgtFund(bgtMap, null, taskstage, "imp", type + lefttabtype);
            bgtMap.put("agencyguid", agencyguid);
            bgtMap.put("mainguid", mainguid);
            bgtMap.put("ordernum", ++i);
            this.setInitData(bgtMap);
        }
        return isexpfunc;
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
     * 处理导入指标数据
     * @param indexList
     * @param mainguid
     * @param lefttabtype
     * @param proguid
     * @param procode
     * @param agencyguid
     * @return
     */
    private List setImpIndexDatas(List<Map<String, Object>> indexList, String mainguid, String lefttabtype, String proguid, String procode, String agencyguid, String tablecode, List<Map<String, Object>> tempList) throws AppException {
        List<Map<String, Object>> indexs = new ArrayList<>();//最终处理入库的指标数据
        String time = PerfUtil.getServerTimeStamp();
        String querytablecode = "V_PERF_T_PROINDEXTRACE";
        String filter = " mainguid='" + mainguid + "'";
        String type = "";
        if ("depttrace".equals(lefttabtype)) {
            type = "DEPT";
        } else if ("protrace".equals(lefttabtype)) {
            type = "PM001";
        }
        indexs =  proTraceTaskDAO.findIndexs(querytablecode, filter, type);
        if (indexs == null || indexs.size() <= 0) {
            if ("depttrace".equals(lefttabtype)) {
                filter = " mainguid='" + proguid + "'";
            } else {
                filter = " t.pro_code='" + procode + "' and t.yearflag = 0";
            }
            indexs = proTraceTaskDAO.findIndexs(tablecode, filter, type);
            for (Map<String, Object> map: indexs) {
                map.put("targetvalue", map.get("indexval"));
                map.put("indexval", "");
                map.put("tindex", map.get("guid"));
                map.put("update_time", time);
                map.put("mainguid", mainguid);
                map.put("is_last_inst", 2);
                map.put("guid", this.getCreateguid());
            }
        }
        if (indexs.size() > 0) {
            //导入指标是否和入库指标一致，根据名称做对比
            for (Map<String, Object> index : indexs) {
                index.put("agencyguid", agencyguid);
                String tindexname = (String) index.get("name");//三级指标名称
                String targetvalue = (String) index.get("targetvalue");
                String f = (String) index.get("findex");
                String s = (String) index.get("sindex");
                for (Map<String, Object> indexMap : indexList) {
                    String sindex = (String) indexMap.get("sindex");
                    String tname = (String) indexMap.get("name");
                    if (tindexname.trim().equals(tname.trim())) {//判断导入三级指标是否存在，存在则导入，不存在则不导入
                        //翻译一二级指标名称改为编码
                        String code = "";
                        String superid = "";
                        for (Map<String, Object> tempMap : tempList) {
                            String levelno = tempMap.get("levelno") + "";
                            String name = (String) tempMap.get("name");
                            code = (String) tempMap.get("code");
                            superid = (String) tempMap.get("superid");
                            if ("2".equals(levelno)) {
                                if (sindex.trim().equals(name.trim())) {
                                    indexMap.put("sindex", code);
                                    indexMap.put("findex", superid);
                                    break;
                                }
                            }
                        }
                        //一二级指标相同的才替换
                        if (f.equals(superid) && s.equals(code)) {
                            indexMap.put("targetvalue", targetvalue);
                            indexMap.put("update_time", time);
                            index.putAll(indexMap);
                        }
                        break;
                    }
                }
            }
        }
        return indexs;
    }

    private List setImpreportDatas(String mainguid, String lefttabtype, Map<String, Object> datas, Map paras, String impreporttype, List<Map<String, Object>> mainDatas, String wfstatus, String workflow) throws AppException {
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        DicTableDTO dicTableDTO = null;
        List coll = null;
        String wheresql = " mainguid='" + mainguid + "'";
        HashMap<String, Object> params = new HashMap<>();
        String taskstage = (String) paras.get("taskstage");
        String bgtwarn = "";
        String goalwarn = "";
        for (String tablecode : datas.keySet()) {
            List<Map<String, Object>> list = (List<Map<String, Object>>) datas.get(tablecode);
            if (list.size() > 0) {//有数据进行校验和数据存储操作
                dicTableDTO = dicQueryService.getDicTable(tablecode.toLowerCase());
                coll = (List) dicTableDTO.getListCol();
                List error = this.checkImpColNullable(list, coll);
                error.addAll(this.checkImpColLength(list, coll));
                if (error.size() > 0){
                    return error;
                }
                //指标进行规制计算
                if ("v_perf_t_proindextrace".equals(tablecode) && "protrace".equals(lefttabtype)) {
                    if ("ah".equals(impreporttype)) {
                        logger.info("--------------------导入参数list，计算预警前--------------------:"+list);
                        this.getIndexWarn(list, mainguid, taskstage);
                    }
                }
                proTraceTaskDAO.delDatas(tablecode, wheresql);
                proTraceTaskDAO.saveAll(list, tablecode);
            }
        }
        if (StringUtil.isEmpty(wfstatus)){//工作流空，则生成工作流
            this.workflow("createnosave", workflow, "", ProTraceManageDAO.PERF_TABLE_TRACEMANAGE , mainDatas);
        }
        //预警规则进行处理
        if ("protrace".equals(lefttabtype)) {
            if ("ah".equals(impreporttype)) {
                params.put("warmtype","bgttracewarn");
            } else if ("hf".equals(impreporttype)){
                return null;
            }
        }  else if ("depttrace".equals(lefttabtype)) {
            if ("ah".equals(impreporttype)) {
                return null;
            } else if ("hf".equals(impreporttype)){
                return null;
            }
        }
        params.put("taskstage", taskstage);
        params.put("mainguid", mainguid);
        bgtwarn = this.getWarn(params);
        //预警规则进行处理
        params.put("warmtype","goalwarn");
        goalwarn = this.getWarn(params);
        String sql = " update " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " t set t.bgtwarn='" + bgtwarn + "', t.goalwarn='" + goalwarn + "'where t.guid='" + mainguid + "'";
        proTraceTaskDAO.update(sql);
        return null;
    }

    /**
     * 处理指标预警规则
     * @param list
     * @param mainguid
     * @param taskstage
     */
    public void getIndexWarn (List<Map<String, Object>> list, String mainguid, String taskstage) {
        HashMap<String, Object> params = new HashMap<>();
        String warmtype = "";
        for (Map<String, Object> indexData : list) {
            String indexval = (String) indexData.get("indexval");//指标值
            String targetvalue = (String) indexData.get("targetvalue");//实际完成值
            String computesign = (String) indexData.get("computesign");
            if ("1".equals(computesign) || "2".equals(computesign)) {
                warmtype = "positiveindex";
            } else if ("3".equals(computesign)) {
                if (!StringUtil.isEmpty(targetvalue) && Float.parseFloat(targetvalue) == 0) {
                    warmtype = "traceindexequalzero";
                } else {
                    warmtype = "positiveindex";
                }
            } else if ("4".equals(computesign)) {
                warmtype = "reverselessindex";
            } else if("5".equals(computesign)){
                warmtype = "reverseindex";
            }else {
                warmtype = "qualitativeindex";
            }
            params.put("warmtype", warmtype);
            params.put("indexval", indexval);
            params.put("targetvalue", targetvalue);
            params.put("taskstage", taskstage);
            params.put("mainguid", mainguid);
            String indexwarn = this.getWarn(params);
            indexData.put("warn", indexwarn);
        }
    }

    /**
     * 合肥一般监控导入
     * @param datas --
     * @param paras --
     * @return --错误信息
     * @throws AppException --
     */
    private List impOrdProgramDatas(List datas, Map paras) throws AppException {
        List cols = (List) paras.get("uitablecolsconfig");
        List dataList = (List) paras.get("list");
        String leftmenuid = (String) paras.get("leftmenuid");
        Map<Integer, Object> data = (Map<Integer, Object>) dataList.get(0);
        //任务阶段
        String taskstage = ((List<String>)data.get(2)).get(0).split("-")[1].split("月")[0];
        //工作流id
        String workflow = (String) paras.get("workflow");
        StringBuffer porcodes = new StringBuffer();
        Map<String, Object> impDates = new HashMap<>();
        for (int i=0; i < datas.size(); i++) {
            Map<String, Object> impdata = (Map<String, Object>) datas.get(i);
            String pro_code = (String) impdata.get("pro_code");
            porcodes.append("'").append(pro_code).append("',");
            impDates.put(pro_code, impdata);
        }
        if (porcodes.length() > 0) {
            porcodes.deleteCharAt(porcodes.length() - 1);
        }
        //查询当前导入项目监控主单数据，根据工作流进行过滤
        String wheresql = " and t.pro_code in("+porcodes.toString()+") and t.depttask='1' ";
        //根据编码查询主单数据
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        Map<String, Object> traceDatas = this.getTraceMainDatas(wheresql + datarule, taskstage);
        if (traceDatas == null || traceDatas.isEmpty()){
            throw new AppException("导入报错", "当前用户没有需要导入的项目数据");
        }
        List<Map<String, Object>> wfDatas = (List<Map<String, Object>>) traceDatas.get("wfDatas");
        //导入字段根据表名进行拆分
        Map<String,Object> tableMap = new HashMap<>();
        List<String> colList = null;
        for (Object obj : cols) {
            colList = new ArrayList<>();
            Map<String, Object> map = (Map<String, Object>) obj;
            String tablecode = (String) map.get("tablecode");
            if (!StringUtil.isEmpty(tablecode) && !tableMap.containsKey(tablecode)){
                for (Object o : cols) {
                    Map<String, Object> m = (Map<String, Object>) o;
                    String t = (String) m.get("tablecode");
                    String columncode = (String) m.get("columncode");
                    if (tablecode.equals(t)) {
                        colList.add(columncode);
                    }
                }
            } else {
                continue;
            }
            if (colList.size() > 0) {
                tableMap.put(tablecode, colList);
            }
        }
        List<Map<String,Object>> allData = new ArrayList<>();//
        List<Map<String,Object>> goalDatas = (List<Map<String, Object>>) traceDatas.get("goalDatas");
        Map<String,Object> goalMap = new HashMap<>();
        for (Map<String,Object> goal : goalDatas) {
            goalMap.put((String) goal.get("mainguid"), goal);
        }
        String delsql = (String) traceDatas.get("delsql");
        //拆分数据
        for (String pro_code : traceDatas.keySet()) {
            Object obj = traceDatas.get(pro_code);
            if (obj instanceof Map) {
                Map<String, Object> mainMap = (Map<String, Object>) traceDatas.get(pro_code);
                Map<String, Object> impMap = (Map<String, Object>) impDates.get(pro_code);
                Map<String, Object> m = null;
                Map<String, Object> dataMap = new HashMap<>();
                for (String str : tableMap.keySet()) {
                    m = new HashMap<>();
                    //对应处理列数据赋值，放值放入到对应列里
                    List<String> clist = (List<String>) tableMap.get(str);
                    for (String s : clist) {
                        m.put(s, impMap.get(s));
                    }
                    m.put("mainguid", mainMap.get("guid"));
                    m.put("agencyguid", impMap.get("agency_code"));
                    m.put("is_last_inst", 2);
                    dataMap.put(str, m);
                    dataMap.put("mainguid", mainMap.get("guid"));
                    dataMap.put("pro_code", pro_code);
                    dataMap.put("pro_name", impMap.get("pro_name"));
                }
                allData.add(dataMap);
            }
        }
        return this.setAllData(taskstage, allData, goalMap, delsql, wfDatas, workflow);
    }

    /**
     * 处理所有的导入数据
     * @param taskstage
     * @param allData
     * @return
     */
    private List setAllData(String taskstage, List<Map<String,Object>> allData, Map<String, Object> goalMap, String delsql, List<Map<String, Object>> wfDatas, String workflow) throws AppException {
        ProTraceTaskDAO dao = (ProTraceTaskDAO) PerfServiceFactory.getBean("pmkpi.perfprotrace.report.ProTraceTaskDAO");
        //调整主单集合
        List<Map<String, Object>> mainList = new ArrayList();
        //预算执行情况集合
        List<Map<String, Object>> bgtList = new ArrayList();
        //编辑区情况
        List<Map<String, Object>> analysisList = new ArrayList();
        //调整目标
        List<Map<String, Object>> adjustGoalList = new ArrayList();
        Map<String, Object> mainMap = null;
        String bgtTablecode = "v_perf_t_probgtfund";
        String analTablecode = "v_perf_t_protraceanalysis";
        String adjgoalTablecode = "v_perf_t_adjustgoal";
        StringBuffer goalMainguid = new StringBuffer();
        for (Map<String,Object> map : allData) {
            mainMap = new HashMap<>();
            String mainguid = (String) map.get("mainguid");
            String pro_code = (String) map.get("pro_code");
            String pro_name = (String) map.get("pro_name");
            String bgtwarn = "";
            String isgoal = "";
            IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
            DicTableDTO dicTableDTO = null;
            List coll = null;
            for (String key : map.keySet()) {
                Object obj = map.get(key);
                if (obj instanceof Map) {
                    Map<String, Object> data = (Map<String, Object>) obj;
                    if (!"v_perf_project_info".equals(key)) {
                        //校验导入数据长度
                        List<Map<String, Object>> list = new ArrayList<>();
                        list.add(data);
                        dicTableDTO = dicQueryService.getDicTable(key.toLowerCase());
                        coll = (List) dicTableDTO.getListCol();
                        List error = this.checkImpColNullable(list, coll);
                        error.addAll(this.checkImpColLength(list, coll));
                        if (error.size() > 0){
                            return error;
                        }
                    }
                    //处理预算执行情况数据
                    if (bgtTablecode.equals(key)) {
                        data.put("pro_name", pro_name);
                        bgtwarn = this.getBgtFund(data, new HashMap<>(), taskstage, "imp", "hefei");
                        bgtList.add(data);
                    } else if (analTablecode.equals(key)) {//处理编辑区数据
                        isgoal = (String) data.get("isgoal");
                        if ("yes".equals(bgtwarn)) {
                            data.put("isexpfunc", "1");
                        } else {
                            data.put("isexpfunc", "0");
                        }
                        this.setInitData(data);
                        analysisList.add(data);
                    } else if (adjgoalTablecode.equals(key)) {//处理调整数据
                        String adjustremark = (String) data.get("adjustremark");
                        if (!StringUtil.isEmpty(adjustremark)) {
                            adjustGoalList.add(this.setGoalData(pro_code, goalMap, data, dao));
                            goalMainguid.append("'").append(mainguid).append("',");
                        }
                    }
                }
            }
            if (!StringUtil.isEmpty(bgtwarn) && !StringUtil.isEmpty(isgoal)) {
                String warn = "";
                mainMap.put("guid", mainguid);
                if ("yes".equals(bgtwarn) && "1".equals(isgoal)){
                    warn = "green";
                } else if ("yes".equals(bgtwarn) && "0".equals(isgoal)){
                    warn = "yellow";
                } else if ("no".equals(bgtwarn) && "1".equals(isgoal)){
                    warn = "red";
                } else if ("no".equals(bgtwarn) && "0".equals(isgoal)){
                    warn = "red";
                }
                mainMap.put("update_time", PerfUtil.getServerTimeStamp());
                mainMap.put("bgtwarn", warn);
                mainList.add(mainMap);
            }
        }
        if (bgtList.size() > 0) {
            dao.delDatas(bgtTablecode, delsql);
            dao.saveAll(bgtList, bgtTablecode);
        }
        if (analysisList.size() > 0) {
            dao.delDatas(analTablecode, delsql);
            dao.saveAll(analysisList, analTablecode);
        }
        if (adjustGoalList.size() > 0) {
            if (goalMainguid.length() > 0) {
                goalMainguid.deleteCharAt(goalMainguid.length() -1);
                delsql = "mainguid in(" + goalMainguid.toString() + ")";
                dao.delDatas(adjgoalTablecode, delsql);
            }
            dao.saveAll(adjustGoalList, adjgoalTablecode);
        }
        if (wfDatas.size() > 0) {
            this.workflow("createnosave", workflow, "", ProTraceManageDAO.PERF_TABLE_TRACEMANAGE , wfDatas);
        }
        if (mainList.size() > 0) {
            List c = new ArrayList();
            c.add("update_time");
            c.add("bgtwarn");
            dao.updateAll(c, mainList, ProTraceManageDAO.PERF_TABLE_TRACEMANAGE);
        }
        return null;
    }

    private void setInitData(Map<String, Object> data) {
        data.put("guid", this.getCreateguid());
        this.getBasMap(data, "add");
        data.put("is_last_inst", 2);
    }

    /**
     * 整理调整目标数据
     * @param goalMap --根据导入的监控数据，查询出来的调整目标数据
     * @param data --导入的目标数据
     * @return
     */
    private Map<String, Object> setGoalData(String pro_code, Map<String, Object> goalMap, Map<String, Object> data, ProTraceTaskDAO dao){
        String mainguid = (String) data.get("mainguid");
        Map<String, Object> goal = (Map<String, Object>) goalMap.get(mainguid);
        //存在直接提换
        if (goal != null && !goal.isEmpty()) {
            data.put("update_time", PerfUtil.getServerTimeStamp());
            data.put("updatetime", PerfUtil.getServerTimeStamp());
            goal.putAll(data);
        } else { //新增
            goal = new HashMap<>();
            String wheresql = " pro_code='" + pro_code + "'  and yearflag='0' ";
            Map<String, Object> goaldata = dao.getDataMap("v_pm_perf_goal_info", wheresql);
            String kpi_target = (String) goaldata.get("kpi_target");
            goal.put("guid", this.getCreateguid());
            goal.put("kpi_target", kpi_target);
            goal.put("pro_code", pro_code);
            goal.put("yearflag", "0");
            goal.put("is_last_inst", 2);
            goal.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
            goal.putAll(data);
            this.getBasMap(goal, "add");
        }
        return goal;
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
     * 获取导出模板数据
     * @param param 业务传递参数
     * @param templateMap 模板信息
     * @return
     * @throws PerfAppException
     */
    @Override
    public List<Map<String, Object>> genExpData(Map param, Map templateMap) {
        String reportType = (String) param.get("reporttype");//导出报告类型，一般监控，项目报告，部门整体报告
        Map<String, Object> backMap = new HashMap<>();
        //选择列表数据guid集合
        List<String> guids = (List<String>) param.get("guids");
        Map subMap = null;
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        String taskstage = "";
        String expType = (String) templateMap.get("exptype");
        String year = CommonUtil.getYear();
        String expfilename = (String) templateMap.get("expfilename");
        if (!reportType.isEmpty() && "ordprogram".equals(reportType)) {//一般监控项目导出
            subMap = this.genBusExpData(param, null);
            taskstage = (String) param.get("taskstage");
            //处理表头动态数据
            List headerList = new ArrayList();
            Map<String, Object> headerMap = new HashMap<>();
            headerMap.put("year", year);
            headerMap.put("taskstage", taskstage);
            headerList.add(headerMap);
            subMap.put("header", headerList);
            if (taskstage != null) {
                expfilename = expfilename.replace("#taskstage#", taskstage);
            } else {
                expfilename = expfilename.replace("#taskstage#", "");
            }
            if (year != null) {
                expfilename = expfilename.replace("#year#", year);
            } else {
                expfilename = expfilename.replace("#year#", "");
            }
            if (expfilename.contains("#systime#")) {
                expfilename = expfilename.replace("#systime#", "");
                subMap.put("expfilename", expfilename + "." + expType);
            } else {
                subMap.put("expfilename", expfilename +"_"+ PerfUtil.getServerTimeStamp() + "." + expType);
            }
            list.add(subMap);
        } else {
            int i = 0;
            for (String guid : guids) {
                i++;
                expfilename = (String) templateMap.get("expfilename");
                subMap = this.genBusExpData(param, guid);
                Map<String, Object> mainMap = (Map<String, Object>) subMap.get(guid);
                String agency_name = (String) mainMap.get("agency_name");
                String pro_code = (String) mainMap.get("pro_code");
                String name = (String) mainMap.get("name");
                String agencyguid = (String) mainMap.get("agencyguid");
                taskstage = (String) subMap.get("taskstage");
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
                if (year != null) {
                    expfilename = expfilename.replace("#year#", year);
                } else {
                    expfilename = expfilename.replace("#year#", "");
                }
                if (taskstage != null) {
                    expfilename = expfilename.replace("#taskstage#", taskstage);
                } else {
                    expfilename = expfilename.replace("#taskstage#", "");
                }
                if (expfilename.contains("#systime#")) {
                    expfilename = expfilename.replace("#systime#", "");
                    subMap.put("expfilename", expfilename + "." + expType);
                } else {
                    subMap.put("expfilename", expfilename +"_"+ PerfUtil.getServerTimeStamp() + i + "." + expType);
                }
                list.add(subMap);
            }
        }
        return list;
    }

    /**
     * 获取导出模板数据.
     * @param param --param
     * @return --
     */
    public Map<String, Object> genBusExpData(Map param, String guid) {
        String reportType = (String) param.get("reporttype");//导出报告类型，一般监控，项目报告，部门整体报告
        Map<String, Object> backMap = new HashMap<>();
        //选择列表数据guid集合
        List<String> guids = (List<String>) param.get("guids");
        //项目编码集合
        Map<String, Object> procodes = (Map<String, Object>) param.get("procodes");
        //项目编码字符串
        List<String> pro_codes = (List<String>) param.get("pro_codes");
        if (!reportType.isEmpty() && "ordprogram".equals(reportType)) {//一般监控项目导入
            backMap = this.getOrdProgram(param, guids, procodes, pro_codes);
        } else {
            backMap = this.getExpReport(param, reportType, guid);
        }
        return backMap;
    }

    /**
     * 导出报告取数
     * @param param
     * @param reportType --报告类型
     * @return
     */
    private Map<String, Object> getExpReport(Map param, String reportType, String guid) {
        Map<String, Object> backMap = new HashMap<>();
        String expType = (String) param.get("exptype");//导出类型，项目、部门整体
        String tablecode = "";
        //查询所有项目
        String wheresql = " guid ='" + guid + "'";
        if (!expType.isEmpty() && expType.contains("protrace")) {
            tablecode = "perf_v_expprotracereport";
        } else {
            tablecode = "perf_v_expdepttracereport";
        }
        Map<String, Object> mainMap = proTraceTaskDAO.getDataMap(tablecode, wheresql);
        if (!mainMap.isEmpty()) {
            String pro_code = (String) mainMap.get("pro_code");
            String taskstage = (String) mainMap.get("taskstage");
            String agencyguid = (String) mainMap.get("agencyguid");
            String proguid = (String) mainMap.get("proguid");
            //2025_12 增加专项债券项目相关数据
            if("protrace".equals(expType)){
                StringBuffer zxzqsql = new StringBuffer("select b.pro_term,t.* from v_perf_project_info b left join pm_debt_info t on b.pro_code = t.pro_code where b.pro_code = ? ");
                List<Map<String, Object>> zxzqMapList = proTraceTaskDAO.queryForList(zxzqsql.toString(),new String[]{pro_code});
                if(zxzqMapList.size()>0) {
                    Map<String, Object> zxzqMap = zxzqMapList.get(0);
                    mainMap.put("pro_term", !StringUtil.isNullOrEmpty(zxzqMap.get("pro_term")) ? zxzqMap.get("pro_term")+"年" : "");
                    mainMap.put("pro_buid_term", !StringUtil.isNullOrEmpty(zxzqMap.get("pro_buid_term")) ? zxzqMap.get("pro_buid_term")+"年" : "");
                    mainMap.put("pro_oper_term", !StringUtil.isNullOrEmpty(zxzqMap.get("pro_oper_term")) ? zxzqMap.get("pro_oper_term")+"年" : "");
                    mainMap.put("fund_invest_area_code", zxzqMap.get("fund_invest_area_code"));
                    mainMap.put("fund_invest_area_name", zxzqMap.get("fund_invest_area_name"));
                }
            }
            List<Map<String , Object>> mainlist = new ArrayList<>();
            mainlist.add(mainMap);
            if (!expType.isEmpty() && expType.contains("protrace")) {
                backMap = this.getBgtAmtData(guid, pro_code, taskstage, expType, null, reportType);
            } else if (!expType.isEmpty() && expType.contains("depttrace")) {
                backMap = this.getBgtAmtData(guid, null, taskstage, expType, agencyguid, reportType);
            }
            backMap.put("maindata", mainlist);
            backMap.put(guid, mainMap);
            backMap.put("indexdatas", this.getIndexData(guid, proguid, pro_code, expType));
            backMap.put("taskstage", mainMap.get("taskstage"));
        }
        return backMap;
    }

    /**
     * 一般监控导出
     * @param param
     * @return
     */
    private Map<String, Object> getOrdProgram(Map param, List<String> guids, Map<String, Object> procodes, List<String> pro_codes ) {
        Map<String, Object> backMap = new HashMap<>();
        String tasksTage = (String) param.get("taskstage");
        //保存所有组合数据数组
        List<Map<String, Object>> dataList = new ArrayList<>();
        //组合数据map
        Map<String, Object> dataMap = null;
        //项目集合
        Map<String, Object> prosMap = new HashMap<>();
        //查询所有项目
        if (pro_codes != null && pro_codes.size() > 0) {
            StringBuffer wheresql = new StringBuffer();
            wheresql.append(proTraceTaskDAO.createInSql("pro_code", pro_codes));
            //项目数据
            List<Map<String, Object>> proList = proTraceTaskDAO.getProgramList(wheresql.toString());
            for (Map<String, Object> promap : proList) {
                String pro_code = (String) promap.get("pro_code");
                prosMap.put(pro_code, promap);
            }
        }
        String pmkpireasontype = "";
        try {
            List<Map<String, Object>> reasontypeList = PerfUtil.getSourceData("PMKPIREASONTYPE", null);
            if (reasontypeList.size() > 0) {
                for (Map<String, Object> map : reasontypeList) {
                    pmkpireasontype += map.get("code") + "-" + map.get("name") + ",";
                }
                pmkpireasontype = pmkpireasontype.substring(0, pmkpireasontype.length() - 1);
            }
        } catch (AppException e) {
            e.printStackTrace();
        }
        //根据监控guid，查询调整目标数据
        //查询目标拼接数据
        int i = 0;
        for (String traceGuid : guids) {
            i++;
            dataMap = new HashMap<>();
            String procode = (String) procodes.get(traceGuid);//项目编码
            Map<String, Object> projectMap = (Map<String, Object>) prosMap.get(procode);
            dataMap.put("num", i);
            dataMap.put("mofdepname", projectMap.get("mofdepname"));
            dataMap.put("agencyname", projectMap.get("agencyname"));
            dataMap.put("prokindname", projectMap.get("prokindname"));
            dataMap.put("procode", projectMap.get("pro_code"));
            dataMap.put("proname", projectMap.get("pro_name"));
            //2025_12 增加专项债券项目相关数据
            StringBuffer zxzqsql = new StringBuffer("select b.pro_term,t.* from v_perf_project_info b left join pm_debt_info t on b.pro_code = t.pro_code where b.pro_code = ? ");
            List<Map<String, Object>> zxzqMapList = proTraceTaskDAO.queryForList(zxzqsql.toString(),new String[]{procode});
            if(zxzqMapList.size()>0){
                Map<String, Object> zxzqMap = zxzqMapList.get(0);
                dataMap.put("pro_term", !StringUtil.isNullOrEmpty(zxzqMap.get("pro_term")) ? zxzqMap.get("pro_term")+"年" : "");
                dataMap.put("pro_buid_term", !StringUtil.isNullOrEmpty(zxzqMap.get("pro_buid_term")) ? zxzqMap.get("pro_buid_term")+"年" : "");
                dataMap.put("pro_oper_term", !StringUtil.isNullOrEmpty(zxzqMap.get("pro_oper_term")) ? zxzqMap.get("pro_oper_term")+"年" : "");
                dataMap.put("fund_invest_area_code", zxzqMap.get("fund_invest_area_code"));
                dataMap.put("fund_invest_area_name", zxzqMap.get("fund_invest_area_name"));
            }
            //获取项目绩效目标
            String goal = proTraceTaskDAO.getProgramGoal(procode);
            dataMap.put("goal", goal);
            //预算执行情况
            dataMap.putAll(this.getBgtAmtData(traceGuid, procode, tasksTage, "protrace", null, "hefei"));
            int num = 0;
            if (!StringUtil.isEmpty(goal)){
                num = goal.split("&#10;").length;
            }
            dataMap.put("hhfnum", num);
            dataMap.put("pmkpireasontype", pmkpireasontype);
            dataList.add(dataMap);
        }
        backMap.put("proList", dataList);
        return backMap;
    }

    /**
     *
     * 获取预算执行情况数据
     * @param traceGuid
     * @param procode
     * @param taskstage
     * @return
     */
    private Map<String, Object> getBgtAmtData(String traceGuid, String procode, String taskstage, String expType, String agencyguid, String type) {

        Map<String, Object> backMap = new HashMap<>();
        String sql = " mainguid='" + traceGuid + "'";
        List<Map<String, Object>> bgtfundList = proTraceTaskDAO.getDatas(proTraceTaskDAO.PERF_TABLE_PROBGTFUND, sql, " order by ordernum");
        //存在业务数据直接进行返回
        if (bgtfundList == null || bgtfundList.size() <= 0) {
            StringBuffer sqlbufer = new StringBuffer();
            //视图取数
            String tablecode = "v_perf_fund_project";
            if ("protrace".equals(expType)) {
                sqlbufer.append(" PERF_FUNDPAY_VIEW.set_month('").append(taskstage).append("') = '").append(taskstage)
                        .append("' and PERF_FUNDPAY_VIEW.set_procode('").append(procode).append("')='").append(procode).append("'");
            } else if ("depttrace".equals(expType)) {
                tablecode = "v_perf_fund_dept";
                sqlbufer.append(" PERF_FUNDPAY_VIEW.set_month('").append(taskstage).append("') = '").append(taskstage)
                        .append("' and PERF_FUNDPAY_VIEW.set_agencyguid('").append(agencyguid).append("')='").append(agencyguid).append("'");
            }
            bgtfundList = proTraceTaskDAO.getDatas(tablecode, sqlbufer.toString() , " order by ordernum");
        }
        if ("hefei".equals(type)) { //合肥一般监控导出数据
            Map<String, Object> analysisMap = null;
            analysisMap = proTraceTaskDAO.getAnalysisinfo(traceGuid);
            Map<String, Object> goalMap = proTraceTaskDAO.getDataMap("v_perf_t_adjustgoal", " mainguid='"+traceGuid+"'");
            if (analysisMap != null) {
                backMap.putAll(analysisMap);
            }
            if (goalMap != null) {
                backMap.putAll(goalMap);
            }
        }
        if (bgtfundList.size()>0) {
            if ("hefei".equals(type)) { //合肥一般监控导出数据
                Map<String, Object> fundMap = bgtfundList.get(0);
                this.getBgtFund(fundMap, backMap, taskstage, "exp", type);
            } else {//安徽省厅报告导出
                if ("ahprogram".equals(type) || "ahdept".equals(type)) {
                    List data = null;
                    for (Map<String, Object> map : bgtfundList) {
                        data = new ArrayList();
                        this.getBgtFund(map, backMap, taskstage, "exp", type);
                        data.add(map);
                        String name = (String) map.get("name");
                        if ("一般公共预算拨款".equals(name)) {
                            backMap.put("bgtdatas", data);
                        } else if ("其他资金".equals(name)) {
                            backMap.put("qtbgtdatas", data);
                        } else if ("专项债券".equals(name)) {
                            backMap.put("zxzqbgtdatas", data);
                        } else if (!backMap.containsKey("bgtdatas")) {
                            backMap.put("bgtdatas", new ArrayList<>());
                        } else if (!backMap.containsKey("qtbgtdatas")) {
                            backMap.put("qtbgtdatas", new ArrayList<>());
                        } else if (!backMap.containsKey("zxzqbgtdatas")) {
                            backMap.put("zxzqbgtdatas", new ArrayList<>());
                        }
                    }
                } else if ("hfprogram".equals(type) || "hfdept".equals(type)) {
                    Map<String, Object> fundMap = bgtfundList.get(0);
                    this.getBgtFund(fundMap, backMap, taskstage, "exp", "hefei");
                    List list = new ArrayList<>();
                    list.add(fundMap);
                    backMap.put("bgtdatas", list);
                }
            }
        } else {
            backMap.put("bgtdatas", new ArrayList<>());
            backMap.put("qtbgtdatas", new ArrayList<>());
        }
        return backMap;
    }

    /**
     * 预算执行率率数据处理
     * @return
     */
    private String getBgtFund(Map<String, Object> fundMap, Map<String, Object> backMap, String taskstage, String type, String dq){
        String bgtwarn = "";
        BigDecimal amt1 = fundMap.get("amt1") == null || "".equals(fundMap.get("amt1")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt1") +"").replace(",",""));
        BigDecimal amt2 = fundMap.get("amt2") == null || "".equals(fundMap.get("amt2")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt2") +"").replace(",",""));
        BigDecimal amt4 = fundMap.get("amt4") == null || "".equals(fundMap.get("amt4")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt4") +"").replace(",",""));
        BigDecimal amt6 = fundMap.get("amt6") == null || "".equals(fundMap.get("amt6")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt6") +"").replace(",",""));
        BigDecimal amt7 = fundMap.get("amt7") == null || "".equals(fundMap.get("amt7")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt7") +"").replace(",",""));
        BigDecimal amt8 = fundMap.get("amt8") == null || "".equals(fundMap.get("amt8")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt8") +"").replace(",",""));
        BigDecimal amt9 = fundMap.get("amt9") == null || "".equals(fundMap.get("amt9")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt9") +"").replace(",",""));
        BigDecimal amt3 = new BigDecimal(0);
        float bgtget = 0;//预算执行率
        if ("hefei".equals(dq)) {
            //调整预算数 amt1+amt7-amt8
            amt3 = PerfUtil.substrTwoNum(PerfUtil.addTwoNum(amt1, amt7), amt8);
            if (amt3 == null || "0".equals(amt3.toString()) || amt3.floatValue() == 0) {
                bgtget = 0;
            } else {
                bgtget = Float.parseFloat(PerfUtil.rideTwoNum(PerfUtil.delTwoNum(amt4, amt3, 4), new BigDecimal(100)).toString());
            }
            float standard = PerfUtil.rideTwoNum(PerfUtil.delTwoNum(Float.parseFloat(taskstage), 12, 4), 100);
            String isexpfunc = "";
            if (standard <= bgtget) {
                isexpfunc = "1-是";
                bgtwarn = "yes";
            } else {
                isexpfunc = "0-否";
                bgtwarn = "no";
            }
            backMap.put("xsjdwarn", isexpfunc);
        } else {
            if ("imp".equals(type)) {
                if ("ahprotrace".equals(dq)) {
                    amt3 = fundMap.get("amt3") == null || "".equals(fundMap.get("amt3")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt3") +"").replace(",",""));
                } else if ("ahdepttrace".equals(dq)) {
                    amt3 = PerfUtil.addTwoNum(amt1, amt7);
                } else if ("hfprotrace".equals(dq) || "hfdepttrace".equals(dq)) {
                    //调整预算数 amt1+amt7-amt8
                    amt3 = PerfUtil.substrTwoNum(PerfUtil.addTwoNum(amt1, amt7), amt8);
                }
                if (amt3 == null || "0".equals(amt3.toString()) || amt3.floatValue() == 0) {
                    bgtget = 0;
                } else {
                    bgtget = Float.parseFloat(PerfUtil.rideTwoNum(PerfUtil.delTwoNum(amt4, amt3, 4), new BigDecimal(100)).toString());
                }
                if (!StringUtil.isEmpty(taskstage)) {
                    float standard = PerfUtil.rideTwoNum(PerfUtil.delTwoNum(Float.parseFloat(taskstage), 12, 4), 100);
                    if (standard <= bgtget) {
                        bgtwarn = "1";
                    } else {
                        bgtwarn = "0";
                    }
                }
            } else {
                if ("ahprogram".equals(dq)) {
                    amt3 = fundMap.get("amt3") == null || "".equals(fundMap.get("amt3")) ? new BigDecimal("0") : new BigDecimal((fundMap.get("amt3") +"").replace(",",""));
                }
            }
        }
        BigDecimal b = new BigDecimal(10000);
        if ("exp".equals(type)) {
            backMap.put("bgtget", bgtget);
            backMap.put("amt1", PerfUtil.delTwoNum(amt1, b, 4));
            backMap.put("amt2", PerfUtil.delTwoNum(amt2, b, 4));
            backMap.put("amt3", PerfUtil.delTwoNum(amt3, b, 4));
            backMap.put("amt4", PerfUtil.delTwoNum(amt4, b, 4));
            backMap.put("amt6", PerfUtil.delTwoNum(amt6, b, 4));
            backMap.put("amt7", PerfUtil.delTwoNum(amt7, b, 4));
            backMap.put("amt8", PerfUtil.delTwoNum(amt8, b, 4));
            backMap.put("amt9", PerfUtil.delTwoNum(amt9, b, 4));

            fundMap.put("amt1", PerfUtil.delTwoNum(amt1, b, 4));
            fundMap.put("amt2", PerfUtil.delTwoNum(amt2, b, 4));
            fundMap.put("amt3", PerfUtil.delTwoNum(amt3, b, 4));
            fundMap.put("amt4", PerfUtil.delTwoNum(amt4, b, 4));
            fundMap.put("amt6", PerfUtil.delTwoNum(amt6, b, 4));
            fundMap.put("amt7", PerfUtil.delTwoNum(amt7, b, 4));
            fundMap.put("amt8", PerfUtil.delTwoNum(amt8, b, 4));
            fundMap.put("amt9", PerfUtil.delTwoNum(amt9, b, 4));
        } else if ("imp".equals(type)) {
            fundMap.put("bgtget", bgtget + "");
            fundMap.put("amt1", PerfUtil.rideTwoNum(amt1, b));
            fundMap.put("amt2", PerfUtil.rideTwoNum(amt2, b));
            fundMap.put("amt3", PerfUtil.rideTwoNum(amt3, b));
            fundMap.put("amt4", PerfUtil.rideTwoNum(amt4, b));
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

    /**
     * 获取主单数据
     * @param taskstage --任务阶段
     * @param wheresql --过滤条件
     * @return
     */
    private Map<String, Object> getTraceMainDatas(String wheresql, String taskstage) throws AppException {
        List<Map<String, Object>> traceDatas = proTraceTaskDAO.getTraceMainData(wheresql, taskstage);
        Map<String, Object> mainMap = new HashMap<>();
        if (traceDatas.size() > 0) {
            //需要走工作流的主单数据
            List<Map<String, Object>> wfDatas = new ArrayList<>();
            //主建guid
            StringBuffer mainguids = new StringBuffer();
            for (Map<String, Object> map : traceDatas) {
                String wfstatus = (String) map.get("wfstatus");
                String pro_code = (String) map.get("pro_code");
                String guid = (String) map.get("guid");
                if (StringUtil.isEmpty(wfstatus)) {
                    wfDatas.add(map);
                }
                mainMap.put(pro_code, map);
                mainguids.append("'").append(guid).append("',");
            }
            mainguids.deleteCharAt(mainguids.length() - 1);
            wheresql = " mainguid in(" + mainguids.toString() + ")";
            //查询调整数据
            List<Map<String, Object>> goalDatas = this.getDatas("v_perf_t_adjustgoal", wheresql, null);
            mainMap.put("goalDatas", goalDatas);
            mainMap.put("delsql", wheresql);
            mainMap.put("wfDatas", wfDatas);
        }
        return mainMap;
    }

    /**
     * 查询各年度数据.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public List<Map<String, Object>> getIndexData(String mainguid, String proguid, String pro_code, String bustype) {
        String tablecode = "";
        String querytablecode = "V_PERF_T_PROINDEXTRACE";
        String type = "";
        String filter = " mainguid='" + mainguid + "'";
        if (bustype != null && "depttrace".equals(bustype)) {
            type = "DEPT";
            tablecode = "V_BGT_PERF_INDICATOR";
        } else if (bustype != null && "protrace".equals(bustype)) {
            type = "PM001";
            tablecode = "V_PM_PERF_INDICATOR";
        }
        List<Map<String, Object>> indexs = proTraceTaskDAO.findIndexs(querytablecode, filter, type);
        if (indexs == null || indexs.size() <= 0) {
            if ("depttrace".equals(bustype)) {
                filter = " mainguid='" + proguid + "'";
            }else if ("protrace".equals(bustype)) {
                filter = " pro_code = '" + pro_code + "' and t.yearflag = '0' ";
            }
            indexs = proTraceTaskDAO.findIndexs(tablecode, filter, type);
            for (Map<String, Object> map: indexs) {
                map.put("targetvalue", map.get("indexval"));
                map.put("indexval", "");
                map.put("tindex", map.get("guid"));
                map.put("guid", this.getCreateguid());
            }
        }
        List<Map<String, Object>> tempList = null;
        String sindex = "";
        List<Map<String, Object>> tempdatas = proTraceTaskDAO.getTempdatas(type);
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        for (Map<String, Object> map : indexs) {
            //处理下拉数据
            String completeanalysis = (String) map.get("completeanalysis");//完成可行性分析
            String deviationanalysis = (String) map.get("deviationanalysis");//偏差原因分析
            String computesign = map.get("computesignname") == null ? "" : (String) map.get("computesignname");
            String targetvalue = map.get("targetvalue") == null ? "" : (String) map.get("targetvalue");
            String meterunit = map.get("meterunit") == null ? "" : (String) map.get("meterunit");
            //计算符号是"定性"时需要过滤掉
            if("定性".equals(computesign)){
                computesign = "";
            }
            map.put("yearvalue", computesign + targetvalue + meterunit);
            if ("completeanalysis1".equals(completeanalysis)) {
                map.put("a1", "√");
            } else if ("completeanalysis2".equals(completeanalysis)) {
                map.put("a2", "√");
            } else if ("completeanalysis3".equals(completeanalysis)) {
                map.put("a3", "√");
            }
            if (!StringUtil.isEmpty(deviationanalysis)) {
                String[] str = deviationanalysis.split(",");
                for (String s : str) {
                    switch (s){
                        case "dviationanalysis1" :
                            map.put("b1", "√");
                            continue;
                        case "dviationanalysis2" :
                            map.put("b2", "√");
                            continue;
                        case "dviationanalysis3" :
                            map.put("b3", "√");
                            continue;
                        case "dviationanalysis4" :
                            map.put("b4", "√");
                            continue;
                        case "dviationanalysis10" :
                            map.put("b10", "√");
                            continue;
                    }
                }
            }
            sindex = (String) map.get("sindex");
            if (!indexMap.containsKey(sindex)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(sindex, tempList);
            } else {
                tempList = indexMap.get(sindex);
            }
            tempList.add(map);
        }
        for (Map<String, Object> map : tempdatas) {
            map.put("name", null);
            String levelno = map.get("levelno") + "";
            if ("2".equals(levelno)) {
                sindex = (String) map.get("guid");
            } else {
                sindex = "";
            }
            if (indexMap.containsKey(sindex)) {
                tempList = indexMap.get(sindex);
                backdata.addAll(tempList);
            } else {
                if ("2".equals(levelno)) {
                    backdata.add(map);
                }
            }
        }
        int i = 0;
        int j = 0;
        int k = 0;
        String oldfindex = "";
        String oldsi = "";
        Map<String, Object> numMap = new HashMap<>();
        for (Map<String, Object> map : backdata){
            String findex = (String) map.get("findex");
            String si = (String) map.get("sindex");
            if (i == 0 || oldfindex.equals(findex)) {
                i++;
            } else {
                numMap.put(oldfindex, i-1);
                i = 1;
            }
            oldfindex = findex;
            if (!"".equals(si)) {
                if (j == 0 || oldsi.equals(si)) {
                    j++;
                } else {
                    numMap.put(oldsi, j-1);
                    j = 1;
                }
                oldsi = si;
            }
            k++;
            if (k == backdata.size()){
                numMap.put(oldfindex, i-1);
                numMap.put(oldsi, j-1);
            }
        }
        for (Map<String, Object> map : backdata){
            String findex = (String) map.get("findex");
            String si = (String) map.get("sindex");
            map.put("findexnum", numMap.get(findex));
            map.put("sindexnum", numMap.get(si));
        }
        return backdata;
    }

    public List<PerfMonitorInfo> getProTraceResult(PerfQueryRequest request) {
        String province = request.getProvince();
        String year = request.getYear();
        List<PerfMonitorInfo> result = new ArrayList<>();
        List<String> maingList = new ArrayList<>();
        List<String> procodeList = new ArrayList<>();
        List<Map<String, Object>> bgtFundList = new ArrayList<>();
        List<Map<String, Object>> indexTraceList = new ArrayList<>();
        List<Map<String, Object>> indexPmList = new ArrayList<>();
        // 1. 查询监控信息
        String sql1 = "select t.*,t1.ele_name as agency_name,b.taskstage from "+proTraceTaskDAO.PERF_TABLE_T_PROMONITOR+" t" +
                " left join ELE_VD00010 t1 on t.year = t1.fiscal_year and t.province = t1.mof_div_code and t.agencyguid = t1.ele_code" +
                " left join perf_t_taskset b on b.guid = t.taskguid" +
                " where t.PROVINCETASK = '1' and t.is_deleted = '2' and t.wfstatus = '011'" +
                " and t.year = '"+year+"' and t.province = '"+province+"'";
        List<Map<String, Object>> datas = proTraceTaskDAO.queryForList(sql1);
        for (Map<String, Object> data : datas) {
            maingList.add((String) data.get("guid"));
            procodeList.add((String) data.get("pro_code"));
        }
        if(maingList.size() > 0){
            // 2. 查询预算执行情况
            String sql2 = proTraceTaskDAO.createInSql("mainguid",maingList);
            sql2 += " and t.year = '" + year + "' and t.province = '" + province + "' ";
            bgtFundList = proTraceTaskDAO.getDatas(proTraceTaskDAO.PERF_TABLE_T_PROBGTFUND, sql2, "");
            // 3. 查询监控指标
            String sql3 = proTraceTaskDAO.createInSql("mainguid",maingList);
            sql3 += " and t.is_deleted = '2' and t.year = '" + year + "' and t.province = '" + province + "' ";
            String tablecode1 = "(select t1.*,t2.ele_name as findex_name,t3.ele_name as sindex_name,t4.name as computesign_name from " + proTraceTaskDAO.PERF_TABLE_PROINDEXTRACE + " t1" +
                    " left join PERF_T_FRAME t2 on t2.frametype = 'PM001' and t2.ele_code = t1.findex and t2.year = t1.year and t2.province = t1.province" +
                    " left join PERF_T_FRAME t3 on t3.frametype = 'PM001' and t3.ele_code = t1.sindex and t3.year = t1.year and t3.province = t1.province" +
                    " left join PERF_ENUM T4 on t4.ELEMENTCODE = 'PMKPIZBXS' and t4.code = t1.COMPUTESIGN and t4.year = t1.year and t4.province = t1.province)";
            indexTraceList = proTraceTaskDAO.getDatas(tablecode1, sql3, "");
        }
        if(procodeList.size() > 0){
            // 4. 查询项目年度指标
            String sql4 = proTraceTaskDAO.createInSql("pro_code",procodeList);
            sql4 += " and t.is_deleted = '2' and t.year = '" + year + "' and t.province = '" + province + "' ";
            String tablecode2 = "(select t1.*,t2.ele_name as findex_name,t3.ele_name as sindex_name,t4.name as computesign_name from " + proTraceTaskDAO.PERF_TABLE_T_INDICATOR + " t1" +
                    " left join PERF_T_FRAME t2 on t2.frametype = 'PM001' and t2.ele_code = t1.findex and t2.year = t1.year and t2.province = t1.province" +
                    " left join PERF_T_FRAME t3 on t3.frametype = 'PM001' and t3.ele_code = t1.sindex and t3.year = t1.year and t3.province = t1.province" +
                    " left join PERF_ENUM T4 on t4.ELEMENTCODE = 'PMKPIZBXS' and t4.code = t1.COMPUTESIGN and t4.year = t1.year and t4.province = t1.province" +
                    " where t1.yearflag = '0' and t1.is_deleted = '2')";
            indexPmList = proTraceTaskDAO.getDatas(tablecode2, sql4, "");
        }
        // 1. 组装监控信息
        for (Map<String, Object> perfMonitorInfoMap : datas) {
            PerfMonitorInfo info = new PerfMonitorInfo();
            String guid = (String) perfMonitorInfoMap.get("guid");
            String pro_code = (String) perfMonitorInfoMap.get("pro_code");
            info.setGuid(guid);
            info.setProCode(pro_code);
            info.setProName((String) perfMonitorInfoMap.get("name"));
            info.setAgencyCode((String) perfMonitorInfoMap.get("agency_code"));
            info.setAgencyName((String) perfMonitorInfoMap.get("agency_name"));
            info.setTaskstage((String) perfMonitorInfoMap.get("taskstage"));
            info.setCreateTime((String) perfMonitorInfoMap.get("create_time"));
            info.setUpdateTime((String) perfMonitorInfoMap.get("update_time"));
            info.setYeargoaltion((String) perfMonitorInfoMap.get("yeargoal"));
            info.setYeargoalExecution((String) perfMonitorInfoMap.get("yeargoal_execution"));
            info.setProTotalAmt((BigDecimal) perfMonitorInfoMap.get("pro_total_amt"));
            // 2. 组装预算执行情况
            List<Map<String, Object>> proBgtFundList = bgtFundList.stream()
                    .filter(map -> {
                        String mainGuid = (String) map.get("mainguid");
                        return mainGuid != null && guid.equals(mainGuid);
                    })
                    .collect(Collectors.toList());
            if (!proBgtFundList.isEmpty()) {
                List<BudgetExecutionTrace> bgtList = new ArrayList<>();
                for (Map<String, Object> proBgtFundMap : proBgtFundList) {
                    BudgetExecutionTrace bgt = new BudgetExecutionTrace();
                    bgt.setMainguid((String) proBgtFundMap.get("mainguid"));
                    bgt.setName((String) proBgtFundMap.get("name"));
                    bgt.setAmt1((BigDecimal) proBgtFundMap.get("amt1"));
                    bgt.setAmt2((BigDecimal) proBgtFundMap.get("amt2"));
                    bgt.setAmt3((BigDecimal) proBgtFundMap.get("amt3"));
                    bgt.setAmt4((BigDecimal) proBgtFundMap.get("amt4"));
                    bgt.setAmt6((BigDecimal) proBgtFundMap.get("amt6"));
                    BigDecimal bgtget = null;
                    String bgtgetStr = (String) proBgtFundMap.get("bgtget");
                    if (bgtgetStr != null) {
                        bgtget = new BigDecimal(bgtgetStr);
                    } else {
                        bgtget = BigDecimal.ZERO;
                    }
                    bgt.setBgtget(bgtget);
                    bgtList.add(bgt);
                }
                info.setProtracebgtlist(bgtList);
            }
            // 3. 组装监控指标
            List<Map<String, Object>> proIndexTraceList = indexTraceList.stream()
                    .filter(map -> {
                        String mainGuid = (String) map.get("mainguid");
                        return mainGuid != null && guid.equals(mainGuid);
                    })
                    .collect(Collectors.toList());
            if (!proIndexTraceList.isEmpty()) {
                List<MonitorIndex> indexList = new ArrayList<>();
                for (Map<String, Object> proIndexTraceMap : proIndexTraceList) {
                    MonitorIndex idx = new MonitorIndex();
                    idx.setMainguid((String) proIndexTraceMap.get("mainguid"));
                    idx.setFindexName((String) proIndexTraceMap.get("findex_name"));
                    idx.setSindexName((String) proIndexTraceMap.get("sindex_name"));
                    idx.setIndiName((String) proIndexTraceMap.get("name"));
                    idx.setComputesign((String) proIndexTraceMap.get("computesign_name"));
                    idx.setMeterunit((String) proIndexTraceMap.get("meterunit"));
                    idx.setTargetvalue((String) proIndexTraceMap.get("targetvalue"));
                    idx.setIndexval((String) proIndexTraceMap.get("indexval"));
                    idx.setCompleteanalysis((String) proIndexTraceMap.get("completeanalysis"));
                    idx.setCompleteanalyscon((String) proIndexTraceMap.get("completeanalyscon"));
                    idx.setDeviationanalysis((String) proIndexTraceMap.get("deviationanalysis"));
                    idx.setWarn((String) proIndexTraceMap.get("warn"));
                    idx.setRemark((String) proIndexTraceMap.get("remark"));
                    indexList.add(idx);
                }
                info.setProtraceindexlist(indexList);
            }

            // 4. 组装项目年度指标
            List<Map<String, Object>> proIndexList = indexPmList.stream()
                    .filter(map -> {
                        String proCode = (String) map.get("pro_code");
                        return proCode != null && pro_code != null && pro_code.equals(proCode);
                    })
                    .collect(Collectors.toList());
            if(!proIndexList.isEmpty()){
                List<AnnualIndex> annualList = new ArrayList<>();
                for (Map<String, Object> proIndexMap : proIndexList) {
                    AnnualIndex aIdx = new AnnualIndex();
                    aIdx.setFindexName((String) proIndexMap.get("findex_name"));
                    aIdx.setSindexName((String) proIndexMap.get("sindex_name"));
                    aIdx.setIndiName((String) proIndexMap.get("name"));
                    aIdx.setComputesign((String) proIndexMap.get("computesign_name"));
                    aIdx.setMeterunit((String) proIndexMap.get("meterunit"));
                    aIdx.setIndexval((String) proIndexMap.get("indexval"));
                    annualList.add(aIdx);
                }
                info.setProindexlist(annualList);
            }
            result.add(info);
        }
        return result;
    }
}