package gov.mof.fasp2.pmkpi.deptTJformance.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;
import java.util.stream.Collectors;


public class DeptTJPerfBO extends PmkpiBO {

    private DeptTJPerfDAO deptTJPPerfDAO;
    /**
     * 注入dao.
     * @param deptTJPPerfDAO --dao.
     * @throws
     */
    public void setDeptTJPerfDAO(DeptTJPerfDAO deptTJPPerfDAO) {
        this.deptTJPPerfDAO = deptTJPPerfDAO;
    }
    /**
     *  列表的查询方法.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     * @param sqlmap
     * @return
     * @throws AppException
     * @see PmkpiBO#getVodSql(Map)
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String nodeguid = (String)sqlmap.get("nodeguid"); //节点id.
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String tablecode = (String) sqlmap.get("tablecode");
        String elementcode = PerfUtil.getSystemSet("dept_letftree");
        logger.info("左侧树要素"+elementcode+"####");
        if (StringUtil.isEmpty(elementcode)){
            elementcode  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        }
        String datarule = this.getDataRuleByMenuguid(menuid, "t", null); //数据权限
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        if (!"1".equals(isleaf) && !"treeroot".equals(nodeguid)) {
            datarule += " start with superguid='" + nodeguid + "' connect by prior guid = superguid";
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            deptTJPPerfDAO.saveAll(eledatas, deptTJPPerfDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if (nodeguid != null && "treeroot".equals(nodeguid)) {
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            deptTJPPerfDAO.saveAll(eledatas, deptTJPPerfDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t where 1=1");
        returnsql.append(PerfUtil.yearProvinceSql("t"));
        if (wheresql != null && !wheresql.isEmpty()) {
            returnsql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }
        if (isleaf != null && "1".equals(isleaf)) {
            returnsql.append(" and t.agencyguid = '").append(nodeguid).append("'");
        } else {
            returnsql.append(" and exists(select 1 from ").append(deptTJPPerfDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid)");
        }
        if (orderby == null || orderby.isEmpty()) {
            returnsql.append(" order by t.updatetime");
        }
        return returnsql.toString();
    }

    /**
     * 获取左侧树数据.
     * @param menuId -- 菜单.
     * @return --
     */
    @SuppressWarnings({"unchecked"})
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String treesource = PerfUtil.getSystemSet("dept_letftree");
        if (treesource != null && !StringUtils.isEmpty(treesource)){
            leftconfig.put("datas", this.getLeftTree(menuId, treesource));
        }
        return leftconfig;
    }
    
    /**
     *
     * @param agencyguid
     * @return
     */
    public boolean findDeptPerformance(String  agencyguid){
        int n = deptTJPPerfDAO.findDeptPerformance(agencyguid);
        if (n > 0 ){
         return true;
        }
        return  false;
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
        String tablecode = (String) params.get("tablecode");
        //审核定义
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        //送审删除对应的暂存数据
        if (!StringUtil.isEmpty(actioncode) && "sendaudit".equals(actioncode) && datas != null && datas.size() > 0) {
            List<String> guids = new ArrayList<String>();
            for (Map<String, Object> m : datas){
                String guid = (String) m.get("guid");
                guids.add(guid);
            }
            String delsql = " mainguid in('" + guids.stream().collect(Collectors.joining(",")).replace(",","','") + "')";
            Map delparams = new HashMap();
            delparams.put("delsql",delsql);
            PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
            perfMidsaveBO.delData(delparams);
        }
        return this.auditdefine(datas, busguid, "perf", null);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        String tablecode = (String) parms.get("tablecode");
        try {
            deptTJPPerfDAO.saveAll(deldatas, deptTJPPerfDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + deptTJPPerfDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            deptTJPPerfDAO.delDatas(tablecode, delsql);
            //处理挂载的表.
            delsql = " exists(select 1 from " + deptTJPPerfDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.mainguid)";
            deptTJPPerfDAO.delDatas(deptTJPPerfDAO.PERF_DEPT_TASK, delsql);
            deptTJPPerfDAO.updateIsDeleteDatas(deptTJPPerfDAO.PERF_DEPT_GOAL, delsql);
            deptTJPPerfDAO.updateIsDeleteDatas(deptTJPPerfDAO.PERF_DEPT_INDEX, delsql);
            //删除对应的暂存数据
            Map delparams = new HashMap();
            delparams.put("delsql",delsql);
            PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
            perfMidsaveBO.delData(delparams);
            backMap.put("flg","1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
    
    /**
     * 编辑区列表查询.
     * @param params -- 参数.
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String)params.get("mainguid");
        String saveAgency = (String)params.get("saveAgency");
        String isloaddefaultline = (String)params.get("isloaddefaultline");//是否加载预算资金规模参考值默认行
        String wheresql = " mainguid = '"+mainguid+"'";
        Map<String, Object> cfgmap = (Map<String, Object>) params.get("pagecomcfg");//获取暂存配置
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        boolean ishidMidSave = false;
        Map<String, Object> infomap = this.getByGuid(deptTJPPerfDAO.PERF_DEPTP_ERFDECLARE, mainguid, "true");
        //业务表无数据，查询有暂存返回暂存
        if(infomap.isEmpty()){
            Map<String, Object> midsavedata = perfMidsaveBO.getMidData((Map<String, Object>) cfgmap.get("#infocfg"));
            if(midsavedata!=null && midsavedata.get("result")!=null){
                infomap = (Map<String, Object>) midsavedata.get("result");
            }
        }
        if(infomap.isEmpty()){
            List<Map<String, Object>> agencyList = this.getAgencyData(saveAgency);
            if (null != agencyList && agencyList.size() != 0) {
                String name = (String) agencyList.get(0).get("name");
                String code = (String) agencyList.get(0).get("code");
                infomap.put("name", name);
                infomap.put("code", code);
            }
            infomap.put("guid", mainguid);
        }
        backMap.put("#infomap",infomap);//基本信息
        List<Map<String, Object>> taskdatas = deptTJPPerfDAO.getDatas(deptTJPPerfDAO.PERF_DEPT_TASK, wheresql, "order by t.ordernum");
        if(taskdatas.size()==0){
            Map<String, Object> midsavedata = perfMidsaveBO.getMidData((Map<String, Object>) cfgmap.get("#taskcfg"));
            if(midsavedata!=null && midsavedata.get("result")!=null){
                taskdatas = (List<Map<String, Object>>) midsavedata.get("result");
            }
        }
        if(taskdatas.size()==0 && "1".equals(isloaddefaultline)){
            //获取视图资金
            Map<String, Object> taskfundmap = deptTJPPerfDAO.getDataMap("v_perf_depttaskfund", "t.agency_code='" + saveAgency + "'");
            Map<String, Object> tasktemp = new HashMap<String, Object>();
            tasktemp.put("guid", this.getCreateguid());
            tasktemp.put("mainguid", mainguid);
            tasktemp.put("agencyguid", saveAgency);
            tasktemp.put("isedit","false");
            tasktemp.put("totalamt",taskfundmap.get("totalamt")!=null ? taskfundmap.get("totalamt") : 0);
            tasktemp.put("basicfund",taskfundmap.get("basicfund")!=null ? taskfundmap.get("basicfund") : 0);
            tasktemp.put("projectfund",taskfundmap.get("projectfund")!=null ? taskfundmap.get("projectfund") : 0);
            tasktemp.put("otherfund",taskfundmap.get("otherfund")!=null ? taskfundmap.get("otherfund") : 0);
            tasktemp.put("name","total");
            tasktemp.put("context","预算资金规模参考值");
            tasktemp.put("createtime", PerfUtil.getServerTimeStamp());
            tasktemp.put("updatetime", PerfUtil.getServerTimeStamp());
            tasktemp.put("creater", SecureUtil.getCurrentUser().getGuid());
            tasktemp.put("province", SecureUtil.getUserSelectProvince());
            tasktemp.put("year", CommonUtil.getYear());
            tasktemp.put("ordernum", 0);
            taskdatas.add(tasktemp);
            Map<String, Object> tasktotal = new HashMap<String, Object>();
            tasktotal.put("guid", this.getCreateguid());
            tasktotal.put("mainguid", mainguid);
            tasktotal.put("agencyguid", saveAgency);
            tasktotal.put("isedit","false");
            tasktotal.put("totalamt",0);
            tasktotal.put("basicfund",0);
            tasktotal.put("projectfund",0);
            tasktotal.put("otherfund",0);
            tasktotal.put("name","total");
            tasktotal.put("context","合计");
            tasktotal.put("createtime", PerfUtil.getServerTimeStamp());
            tasktotal.put("updatetime", PerfUtil.getServerTimeStamp());
            tasktotal.put("creater", SecureUtil.getCurrentUser().getGuid());
            tasktotal.put("province", SecureUtil.getUserSelectProvince());
            tasktotal.put("year", CommonUtil.getYear());
            tasktotal.put("ordernum", 1);
            taskdatas.add(tasktotal);
        }
        backMap.put("#tasklist",taskdatas);//任务列表
        List<Map<String, Object>> goaldatas = deptTJPPerfDAO.getDatas(deptTJPPerfDAO.PERF_DEPT_GOALTASKVIEW, wheresql, "order by t.ordernum");
        Map<String, Object> goalindexmap = new HashMap<String, Object>();
        //获取模板数据
        List<Map<String, Object>> collist = deptTJPPerfDAO.getCol(deptTJPPerfDAO.PERF_DEPT_INDEX);
        List<Map<String, Object>> tempdatas = deptTJPPerfDAO.getTempdatas();
        for (Map<String, Object> tempdata : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = tempdata.get(col) + "";
                if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                    tempdata.put(col, "");
                }
            }
            tempdata.put("mainguid", mainguid);
            tempdata.put("_isleaf", "1");
        }
        backMap.put("#tempdatas",tempdatas);//模板列表
        if(goaldatas.size()==0){
            Map<String, Object> midsavedata = perfMidsaveBO.getMidData((Map<String, Object>) cfgmap.get("#goalcfg"));
            if(midsavedata!=null && midsavedata.get("result")!=null){
                goaldatas = (List<Map<String, Object>>) midsavedata.get("result");
            }
            Map<String, Object> midsavedata2 = perfMidsaveBO.getMidData((Map<String, Object>) cfgmap.get("#indexcfg"));
            if(midsavedata2!=null && midsavedata2.get("result")!=null){
                goalindexmap = (Map<String, Object>) midsavedata2.get("result");
            }
        }else{
            for (Map goalmap: goaldatas) {
                String goalguid = (String) goalmap.get("guid");//目标id
                List<Map<String,Object>> datas = new ArrayList<>();//指标数据集合(模板+指标)
                //模板数据
                for (Map<String, Object> tempdata : tempdatas) {
                    Map<String, Object> tempindexdata = new HashMap<>();
                    tempindexdata.putAll(tempdata);
                    for (Map<String, Object> colmap : collist) {
                        String col = (String) colmap.get("columncode");
                        String value = tempindexdata.get(col) + "";
                        if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                            tempindexdata.put(col, "");
                        }
                    }
                    tempindexdata.put("mainguid", mainguid);
                    tempindexdata.put("kpi_dep_id", goalguid);
                    tempindexdata.put("_isleaf", "1");
                    datas.add(tempindexdata);
                }
                String indexwheresql = wheresql +" and kpi_dep_id = '"+goalguid+"'";
                List<Map<String, Object>> indexdatas = deptTJPPerfDAO.getDatas(deptTJPPerfDAO.PERF_DEPT_INDEX, indexwheresql, "order by t.ordernum");
                //指标数据
                for (Map<String, Object> indexdata : indexdatas) {
                    datas.add(indexdata);
                }
                goalindexmap.put(goalguid,datas);
            }
            ishidMidSave = true;
        }
        if(ishidMidSave){
            backMap.put("hidButtons", "暂存");
        }
        backMap.put("#goallist",goaldatas);//目标列表
        backMap.put("#goalindexmap",goalindexmap);//指标列表
        return backMap;
    }

    public  List<Map<String, Object>> addDataformat(List<Map<String, Object>> datas){
        if(datas!= null && datas.size()>0){
            for (Map<String, Object> data : datas) {
                String rowtype = (String) data.get("rowtype");
                if(rowtype != null && "add".equals(rowtype)){
                    data.put("yearflag", "0");
                    this.getBasMap(data,"add");
                    data.put("is_last_inst",2);//是否终审
                }
            }
        }
        return datas;
    }

    public void infosave(HashMap config) throws AppException {
        String mainguid = (String) config.get("mainguid");
        String workflow = (String) config.get("workflow");
        String saveAgency = (String) config.get("saveAgency");
        String viewtype = (String) config.get("viewtype");
        //基本信息保存 infodata datas #infomap #tasklist #goallist #goalindexmap
        Map<String, Object> datas = (Map<String, Object>) config.get("datas");
        Map<String, Object> infodata = (Map<String, Object>) datas.get("#infomap");
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        if (mainguid != null && !mainguid.isEmpty()) {
            String timeStamp = PerfUtil.getServerTimeStamp();
            Map edit = this.getByGuid(deptTJPPerfDAO.PERF_DEPTP_ERFDECLARE, mainguid, "true");
            if (!edit.isEmpty()){
                viewtype = "mod";
            } else {
                viewtype = "add";
            }
            if (viewtype != null && "mod".equals(viewtype)) {//修改
                infodata.put("updatetime", timeStamp);
                List<String> cols = new ArrayList<String>(infodata.keySet());
                cols.remove("province");
                cols.remove("year");
                deptTJPPerfDAO.update(cols, infodata, deptTJPPerfDAO.PERF_DEPTP_ERFDECLARE); //修改字段
            } else {//新增
                infodata.put("createtime", timeStamp);
                infodata.put("updatetime", timeStamp);
                infodata.put("creater", SecureUtil.getCurrentUserID());
                infodata.put("province", SecureUtil.getUserSelectProvince());
                infodata.put("year", CommonUtil.getYear());
                infodata.put("agencyguid", saveAgency);
                infodata.put("finintorgguid", deptTJPPerfDAO.getFinintorByCode(saveAgency));
                infodata.put("status", "1");
                infodata.put("guid", mainguid);
                this.workflow("create",workflow, "", deptTJPPerfDAO.PERF_DEPTP_ERFDECLARE, l);
            }
        }
    }

    /**
     * 编辑区统一保存.
     * @param config -- 前端参数.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map saveAll(HashMap config) throws AppException {
        Map<String,Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) config.get("mainguid");
        String workflow = (String) config.get("workflow");
        String busguid = (String) config.get("busguid");
        String menuid = (String) config.get("menuid");
        String saveAgency = (String) config.get("saveAgency");
        String viewtype = (String) config.get("viewtype");
        String wheresql = " mainguid = '"+mainguid+"'";
        //20230606 部标2.0
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> eledatas = null;
        String deptCode = saveAgency.substring(0,3);
        try {
            eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY", "guid='" + deptCode + "'");
        } catch (AppException e) {
            e.printStackTrace();
        }
        String deptName = "";
        if (eledatas.size() > 0) {
            deptName = (String)eledatas.get(0).get("name");
        }
        //基本信息保存 infodata datas #infomap #tasklist #goallist #goalindexmap
        Map<String, Object> datas = (Map<String, Object>) config.get("datas");
        Map<String, Object> infodata = (Map<String, Object>) datas.get("#infomap");
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        this.infosave(config);
        if(StringUtil.isEmpty(busguid)){//如果为新增数据，拼接busguid
            Map infom = this.getByGuid(deptTJPPerfDAO.PERF_DEPTP_ERFDECLARE,mainguid,"true");
            String wfstatus = (String) infom.get("wfstatus");
            busguid = menuid + "_" + wfstatus;
        }
        //任务列表保存 taskdatas datas #infomap #tasklist #goallist #goalindexmap
        List<Map<String, Object>> taskdatas = (List<Map<String, Object>>) datas.get("#tasklist");
        this.addDataformat(taskdatas);
        deptTJPPerfDAO.delDatas(deptTJPPerfDAO.PERF_DEPT_TASK, wheresql);
        deptTJPPerfDAO.saveAll(taskdatas, deptTJPPerfDAO.PERF_DEPT_TASK);
        //目标列表保存 goaldatas datas #infomap #tasklist #goallist #goalindexmap
        List<Map<String, Object>> goaldatas = (List<Map<String, Object>>) datas.get("#goallist");
        this.addDataformat(goaldatas);
        //指标标列表保存 goalindexmap 转 indexdatas  datas #infomap #tasklist #goallist #goalindexmap
        Map<String, Object> goalindexmap = (Map<String, Object>) datas.get("#goalindexmap");
        List<Map<String, Object>> goaltaskdatas = new ArrayList<Map<String, Object>>();
        int num = 1;
        for (Map<String, Object> goals : goaldatas) {//遍历目标处理关联数据
            String ogoalguid = (String) goals.get("guid");
            String ngoalguid = this.getCreateguid();
            //目标
            goals.put("ordernum", num++);
            goals.put("guid", ngoalguid);
            goals.put("kpi_dep_id", ngoalguid);
            //目标任务关系
            Map<String,Object> goaltask = new HashMap<String, Object>();
            goaltask.put("guid",this.getCreateguid());
            goaltask.put("goalguid",ngoalguid);
            goaltask.put("taskguid",goals.get("taskguid"));
            goaltask.put("mainguid",mainguid);
            goaltask.put("task_context",goals.get("task_context"));
            goaltask.put("province", SecureUtil.getUserSelectProvince());
            goaltask.put("year", CommonUtil.getYear());
            goaltaskdatas.add(goaltask);
            //目标所对应指标
            List<Map<String, Object>> goalindexlist = (List<Map<String, Object>>) goalindexmap.get(ogoalguid);
            goalindexlist.forEach(m->{m.put("kpi_dep_id",ngoalguid);});
        }
        deptTJPPerfDAO.updateIsDeleteDatas(deptTJPPerfDAO.PERF_DEPT_GOAL, wheresql);
        deptTJPPerfDAO.saveAll(goaldatas, deptTJPPerfDAO.PERF_DEPT_GOAL);
        deptTJPPerfDAO.delDatas(deptTJPPerfDAO.PERF_DEPT_GOALTASK, wheresql);
        deptTJPPerfDAO.saveAll(goaltaskdatas, deptTJPPerfDAO.PERF_DEPT_GOALTASK);
        List<Map<String, Object>> indexdatas = new ArrayList<Map<String, Object>>();
        Set keyset = goalindexmap.keySet();
        for(Object key:keyset){
            if(!"undefined".equals(key) && goalindexmap.get(key)!=null){
                List<Map<String, Object>> goalindexlist = (List<Map<String, Object>>) goalindexmap.get(key);
                List<Map<String, Object>> newdata= goalindexlist.stream().filter(m -> (int)m.get("levelno")==3).collect(Collectors.toList());
                indexdatas.addAll(newdata);
            }
        }
        this.addDataformat(indexdatas);
        indexdatas.forEach(m->{
            m.put("guid", StringUtil.createUUID());
            m.put("mainguid", mainguid);
            m.put("kpi_id", m.get("guid"));
            m.put("kpi_val", m.get("indexval"));
            m.put("kpi_evalstd", 1);
            m.put("is_last_inst",2);
        });
        deptTJPPerfDAO.setIndexCode(indexdatas);//注入指标code
        deptTJPPerfDAO.setIndexDatas(indexdatas,"DEPT",false);
        deptTJPPerfDAO.updateIsDeleteDatas(deptTJPPerfDAO.PERF_DEPT_INDEX, wheresql);
        deptTJPPerfDAO.saveAll(indexdatas, deptTJPPerfDAO.PERF_DEPT_INDEX);
        backMap.put("success", true);
        return this.auditdefine(l, busguid,"perf", null);
    }

    /**
     * 编辑区统一保存.
     * @param config -- 前端参数.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map midsave(HashMap config) throws AppException {
        Map<String,Object> backMap = new HashMap<String, Object>();
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        Map<String, Object> pagecomcfg = (Map<String, Object>) config.get("pagecomcfg");
        Map<String, Object> datas = (Map<String, Object>) config.get("datas");
        //基本信息保存不暂存直接走保存
        this.infosave(config);
        //任务列表保存 taskdatas datas #infomap #tasklist #goallist #goalindexmap
        List<Map<String, Object>> taskdatas = (List<Map<String, Object>>) datas.get("#tasklist");
        Map taskparam = (Map) pagecomcfg.get("#taskcfg");
        taskparam.put("data",taskdatas);
        perfMidsaveBO.saveData(taskparam);
        //目标列表保存 goaldatas datas #infomap #tasklist #goallist #goalindexmap
        List<Map<String, Object>> goaldatas = (List<Map<String, Object>>) datas.get("#goallist");
        Map goalparam = (Map) pagecomcfg.get("#goalcfg");
        goalparam.put("data",goaldatas);
        perfMidsaveBO.saveData(goalparam);
        //指标标列表保存 goalindexmap 转 indexdatas  datas #infomap #tasklist #goallist #goalindexmap
        Map<String, Object> goalindexmap = (Map<String, Object>) datas.get("#goalindexmap");
        Map indexparam = (Map) pagecomcfg.get("#indexcfg");
        indexparam.put("data",goalindexmap);
        perfMidsaveBO.saveData(indexparam);
        backMap.put("success", true);
        return backMap;
    }

}
