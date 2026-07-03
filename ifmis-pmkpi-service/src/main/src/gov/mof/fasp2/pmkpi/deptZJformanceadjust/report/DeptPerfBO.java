package gov.mof.fasp2.pmkpi.deptZJformanceadjust.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class DeptPerfBO extends PmkpiBO {

    private DeptPerfDAO deptPerfDAO;
    /**
     * 注入dao.
     * @param deptPerfDAO --dao.
     * @throws
     */
    public void setDeptPerfDAO(DeptPerfDAO deptPerfDAO) {
        this.deptPerfDAO = deptPerfDAO;
    }
    /**
     *  列表的查询方法.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     * @param sqlmap
     * @return
     * @throws AppException
     * @see gov.mof.fasp2.pmkpi.common.PmkpiBO#getVodSql(java.util.Map)
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
            deptPerfDAO.saveAll(eledatas, deptPerfDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if (nodeguid != null && "treeroot".equals(nodeguid)) {
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            deptPerfDAO.saveAll(eledatas, deptPerfDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append("V_PERF_T_ADJUST").append(" t");
        returnsql.append(" where t.bustype='dept'");
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
            returnsql.append(" and exists(select 1 from ").append(deptPerfDAO.PMKPI_TABLE_TMP_AGENCY)
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
        /*String treesource = PerfUtil.getSystemSet("dept_letftree");
        if (treesource != null && !StringUtils.isEmpty(treesource)){
            leftconfig.put("datas", this.getLeftTree(menuId, treesource));
        }*/
        String tablecode = "v_perf_t_adjust";
        String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype='dept' ";
        leftconfig.put("datas", deptPerfDAO.getLeftTree(tablecode, datarule));
        return leftconfig;
    }
    
    /**
     *
     * @param agencyguid
     * @return
     */
    public boolean findDeptPerformance(String  agencyguid){
        int n = deptPerfDAO.findDeptPerformance(agencyguid);
        if (n > 0 ){
         return true;
        }
        return  false;
    }
	
	/**
	 * 编辑区统一保存.
	 * @param config -- 前端参数.
	 * @return
	 * @throws AppException -- 自定义异常.
	 */
	public Map infosave(HashMap config) throws AppException {
	    Map<String,Object> backMap = new HashMap<String, Object>();
	    String guid = (String) config.get("mainguid");
	    String iswf = (String) config.get("iswf");
        String tablecode = (String) config.get("tablecode");
        String saveAgency = (String) config.get("saveAgency");
        String workflow = (String) config.get("workflow");
        String busguid = (String) config.get("busguid");
        String viewtype = (String) config.get("viewtype");
//        String componentid = (String) config.get("componentid"); //编辑区组件
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        if (guid != null && !guid.isEmpty()) {
            String timeStamp = PerfUtil.getServerTimeStamp();
            Map edit = this.getByGuid(tablecode, guid, iswf);
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
                deptPerfDAO.update(cols, infodata, tablecode); //修改字段
            } else {//新增
                infodata.put("createtime", timeStamp);
                infodata.put("updatetime", timeStamp);
                infodata.put("creater", SecureUtil.getCurrentUserID());
                infodata.put("province", SecureUtil.getUserSelectProvince());
                infodata.put("year", CommonUtil.getYear());
                infodata.put("agencyguid", saveAgency);
                infodata.put("finintorgguid", deptPerfDAO.getFinintorByCode(saveAgency));
                infodata.put("status", "1");
                //处理部门整体绩效目标
                if ("V_PERF_T_ADJUSTGOAL".equals(tablecode)){
                    String  kpi_depid = StringUtil.createUUID();
                    infodata.put("guid", kpi_depid);
                    infodata.put("kpi_per_id", kpi_depid);
                    infodata.put("mof_div_code", SecureUtil.getUserSelectProvince());
                    infodata.put("fiscal_year", CommonUtil.getYear());
                    infodata.put("dept_code", saveAgency);
                    infodata.put("update_time", timeStamp);
                    infodata.put("is_deleted", 2);
                    infodata.put("create_time", timeStamp);
                    infodata.put("adj_batch_no", "");
                }
                if(iswf != null && "true".equals(iswf)){ //只有主表编辑区才会新增工作流，其他
                    infodata.put("guid", guid);
                    this.workflow("create",workflow, "", tablecode, l);
                } else {
                    infodata.put("mainguid", guid);
                    String delsql = " mainguid='" + guid + "'";
                    deptPerfDAO.delDatas(tablecode, delsql);
                    deptPerfDAO.save(infodata, tablecode);
                }
            }
            backMap.put("success", true);
		}
		return this.auditdefine(l, busguid,"perf", null);
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
        return this.auditdefine(datas, busguid, "perf", null);
    }

    /**
     * 编辑区查询.
     * @param params
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String projguid = (String) params.get("projguid");
        String tablecode = (String) params.get("tablecode");
        String saveAgency = (String) params.get("saveAgency") ;
        String componentid = (String) params.get("componentid") ; //编辑区组件
        String iswf = (String) params.get("iswf"); //区分是主编辑区，其他编辑区不要这个参数
        Map<String, Object> map = new HashMap<String, Object>();
        if ("goaleditform".equals(componentid)){ //绩效目标
            map = this.getByGuid(tablecode, mainguid, iswf);
            if(map.isEmpty()){
                map = this.getByGuid("V_BGT_PERF_GOAL_INFO", projguid, iswf);
            }
        } else {
            map = this.getByGuid(tablecode, projguid, iswf);
        }
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        String agencycode = (String)map.get("agencyguid");
        if(StringUtils.isEmpty(agencycode)){
            agencycode = saveAgency;
        }
        map.put("agencyguid",agencycode);
        if ("infoeditform".equals(componentid)){
            DicRangeDTO  dicRangeDTO = dss.getRangeByElementcode("PMKPIAGENCYALLPAY",agencycode);
            map.put("code",agencycode);
            map.put("name",dicRangeDTO.getName());
        }
        backMap.put("editdata", map);
        return backMap;
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
            deptPerfDAO.saveAll(deldatas, deptPerfDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + deptPerfDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            deptPerfDAO.delDatas(tablecode, delsql);
            //处理挂载的表.
            delsql = " exists(select 1 from " + deptPerfDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.mainguid)";
            deptPerfDAO.updateIsDeleteDatas("V_PERF_T_ADJUSTGOAL", delsql);
            delsql = " exists(select 1 from " + deptPerfDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.mainguid)";
            deptPerfDAO.updateIsDeleteDatas("V_PERF_T_DEPTINDEXADJUST", delsql);
            delsql = " exists(select 1 from " + deptPerfDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.mainguid)";
            deptPerfDAO.updateIsDeleteDatas("V_PERF_BGT_INDEXPROADJUST", delsql);
            delsql = " exists(select 1 from " + deptPerfDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.mainguid)";
            deptPerfDAO.updateIsDeleteDatas("V_PERF_BGT_LINKBGTINFOADJUST", delsql);
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
        String orderby = (String) params.get("orderby");
        String mainguid = (String)params.get("mainguid");
        String tablecode = (String)params.get("tablecode");
        String tablesql = (String)params.get("tablesql");
        String componentid = (String)params.get("componentid"); //哪个组件
        String projguid = (String)params.get("projguid");

        String wheresql = "";
        String dctablecode = "";
        List<Map<String, Object>> data = null;
        wheresql = " t.mainguid = '" + projguid + "'";
        if (tablesql != null && !tablesql.isEmpty()) {
            wheresql += tablesql;
        }
        if ("indexprodatatable".equals(componentid)){ //处理部门预算指标对应项目关系
            tablecode = "V_PERF_INDEXTOPROSADJUST";
            dctablecode ="V_PERF_INDEXTOPROS";
        }
        if ("perfindexdatatable".equals(componentid)){
            dctablecode ="V_BGT_PERF_INDICATOR";
        }
        if ("budgetdatatable".equals(componentid)){
            dctablecode ="V_PERF_BGT_LINKBGTINFO";
        }
        data = deptPerfDAO.getDatas(tablecode, " t.mainguid = '" + mainguid + "'", orderby);//查调整数据
        if (data.size() == 0 ){
            data = deptPerfDAO.getDatas(dctablecode, wheresql, orderby);//查申报数据
        }
        if ("budgetdatatable".equals(componentid)){ // 预算挂钩机制 有问题，得处理下
            List<Map<String, Object>> bgtdata =  new ArrayList<>();
            List<Map<String, Object>> bgtindicators = deptPerfDAO.getDatas("v_perf_indextobgtadjust", " t.mainguid = '" + mainguid + "' and t.isbudget = 1", " order by t.ordernum");
            if (bgtindicators.size() == 0 ){
                bgtindicators = deptPerfDAO.getDatas("v_perf_indextobgt", " t.mainguid = '" + projguid + "' and t.isbudget = 1", " order by t.ordernum");
            }
            if (data.size() == 0 ){
                List<Map<String, Object>> fixedMap = deptPerfDAO.getDatas("PERF_BGT_LINKBGTINFO", " t.province = '87' ", " order by ordernum");
                bgtdata.addAll(fixedMap);
                bgtdata.addAll(bgtindicators);
                String tempguid = "";
                String newguid = "";
                for (Map<String, Object> map : bgtdata) {
                    newguid = (String) map.get("guid");
                    tempguid = StringUtil.createUUID();
                    map.put("rowtype","add");
                    map.put("guid",tempguid);
                    if (!"FIXEDBGTLINKBGTINFO0001".equals(newguid) && !"FIXEDBGTLINKBGTINFO0002".equals(newguid)){
                        map.put("indexguid",newguid);
                    } else {
                        map.put("is_deleted",2);
                    }
                }
            } else { //处理最新的匹配数据
                Map<String,Map<String,Object>> indexguids = new HashMap<>();
                String tempguid = "";
                String tempindex = "";
                for (Map<String, Object> map : data) {
                    tempindex = (String) map.get("indexguid");
                    if ("FIXEDBGTLINKBGTINFO0001".equals(tempindex) || "FIXEDBGTLINKBGTINFO0002".equals(tempindex)){
                        map.put("rowtype","");
                        bgtdata.add(map);
                    } else {
                        indexguids.put(tempindex,map);
                    }
                }
                Map<String, Object> tempcurMap = new HashMap<>();
                for (Map<String, Object> map : bgtindicators) {
                    tempguid = (String) map.get("guid");
                    if (indexguids.containsKey(tempguid)){
                        tempcurMap = indexguids.get(tempguid);
                        tempcurMap.put("name", map.get("name"));
                        tempcurMap.put("kpi_val1", map.get("kpi_val1")); // 前面变化，这跟着显示
                        tempcurMap.put("kpi_val2", map.get("kpi_val2"));
                        tempcurMap.put("kpi_val3", map.get("kpi_val3"));
                        tempcurMap.put("lv1_perf_ind_code", map.get("kpi_val1")); // 前面变化，这跟着显示
                        tempcurMap.put("lv2_perf_ind_code", map.get("kpi_val2"));
                        tempcurMap.put("lv3_perf_ind_code", map.get("kpi_val3"));
                        tempcurMap.put("computesign", map.get("computesign"));
                        tempcurMap.put("kpi_val", map.get("kpi_val"));
                        tempcurMap.put("meterunit", map.get("meterunit"));
                        tempcurMap.put("rowtype", "mod");
                        tempcurMap.put("bgtamt1", map.get("bgtamt1"));
                        tempcurMap.put("bgtamt2", map.get("bgtamt2"));
                        tempcurMap.put("bgtamt3", map.get("bgtamt3"));
                        tempcurMap.put("baseperiod", map.get("baseperiod"));
                        tempcurMap.put("couplerate", map.get("couplerate"));
                        tempcurMap.put("coupleamt", map.get("coupleamt"));
                        tempcurMap.put("remark", map.get("remark"));
                        bgtdata.add(tempcurMap);
                    } else {
                        map.put("rowtype","add");
                        map.put("indexguid",tempguid);
                        bgtdata.add(map);
                    }
                }
            }
            backMap.put("data", bgtdata);
            return backMap;
        }
        if ("perfindexdatatable".equals(componentid)){ //部门指标
            //部门绩效指标组件，查询选择的项目信息
            List<Map<String, Object>> projects = PerfUtil.lowMapKey(deptPerfDAO.findIndexProsadjust(mainguid));
            if(projects.size() <= 0){
                projects = PerfUtil.lowMapKey(deptPerfDAO.findIndexPros(projguid));
            }
            Map<String,List<Map<String, Object>>> indexProsMap = new HashMap<String,List<Map<String, Object>>>();
            String tempindex = "";
            List<Map<String, Object>> proslist = new ArrayList<Map<String, Object>>();
            for (Map<String, Object> map : projects) {
                tempindex = (String) map.get("indexguid");
                if (indexProsMap.containsKey(tempindex)){
                    proslist = indexProsMap.get(tempindex);
                    proslist.add(map);
                } else {
                    proslist = new ArrayList<Map<String, Object>>();
                    proslist.add(map);
                    indexProsMap.put(tempindex,proslist);
                }
            }
            String indexguid = "";
            for (Map<String, Object> map : data) { //给行数据挂载
                indexguid = (String) map.get("guid");
                if (indexProsMap.containsKey(indexguid)){
                    map.put("projects", indexProsMap.get(indexguid));
                } else {
                    map.put("projects", new ArrayList<Map<String, Object>>());
                }
            }
        }
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 编辑区列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> tablesave(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        //关联字段
        String mainguid = (String) params.get("mainguid");

        String saveAgency = (String) params.get("saveAgency");
        String busguid = (String) params.get("busguid");
        //哪个组件
        String componentid = (String)params.get("componentid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //修改数据
        //List<Map<String, Object>> updatas = (List<Map<String, Object>>) params.get("updatas");
        //删除数据
        //List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");

        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        //List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();

        String timeStamp = PerfUtil.getServerTimeStamp();
        int i = 1;
        //String rowtype = "";
        List<Map<String, Object>> bgtmodlist = new ArrayList(); //预算编制阶段.
        for (Map<String, Object> map : datas) {
            //rowtype = (String) map.get("rowtype");
            map.put("ordernum", i++);
            //if (rowtype != null && "add".equals(rowtype)) {
                //map.put("guid", createguid);
                map.put("createtime", timeStamp);
                map.put("updatetime", timeStamp);
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("agencyguid", saveAgency);
                map.put("status", 1);
                map.put("mainguid", mainguid);
                if (tablecode.equalsIgnoreCase("V_PERF_T_DEPTINDEXADJUST")){
                    map.put("kpi_id",map.get("guid"));
                    map.put("mof_div_code",SecureUtil.getUserSelectProvince());
                    map.put("fiscal_year",CommonUtil.getYear());
                    map.put("dept_code",saveAgency);
                    map.put("kpi_lv1",map.get("findex"));
                    map.put("kpi_lv2","41"); //后处理
                    map.put("kpi_lv3","410000009"); //后处理
                    map.put("kpi_evalstd",map.get("scorerule"));
                    map.put("kpi_val",map.get("kpi_val"));
                    map.put("lv1_perf_ind_code",map.get("findex"));
                    map.put("lv1_perf_ind_name","产出与效果");
                    map.put("lv2_perf_ind_code","41"); //后处理
                    map.put("lv2_perf_ind_name","自定义二级"); //后处理
                    map.put("lv3_perf_ind_code","410000009"); //后处理
                    map.put("lv3_perf_ind_name","自定义三级"); //后处理
                    map.put("update_time",timeStamp);
                    map.put("is_deleted",2);
                    map.put("createtime",timeStamp);
                    map.put("create_time",timeStamp);
                    map.put("is_backup","2");
                }
                addlist.add(map);
           // }
        }
        if (addlist.size() > 0) {
            String delsql = " mainguid='" + mainguid + "'";
            deptPerfDAO.delDatas(tablecode, delsql);
            deptPerfDAO.saveAll(addlist, tablecode);
            if ("perfindexdatatable".equals(componentid)){ //处理指标对应的项目s
                List<Map<String, Object>> allprojs = new ArrayList<>();
                String modflg = "";
                List<Map<String, Object>> tempprojs = new ArrayList<>();
                for (Map<String, Object> map : addlist) {
                    //modflg = map.get("projmod")== null ? "": (String) map.get("projmod");
                    //if ("mod".equals(modflg)){
                        tempprojs = (List<Map<String, Object>>) map.get("projects");
                        if (tempprojs.size() > 0){
                            allprojs.addAll(tempprojs);
                        }
                    //}
                }
                //处理guid
                for (Map<String, Object> map : allprojs) {
                    map.put("guid", StringUtil.createUUID());
                    map.put("mainguid", mainguid);
                    map.put("agencyguid", saveAgency);
                    map.put("is_deleted", 2);
                    map.put("createtime", timeStamp);
                    map.put("updatetime", timeStamp);
                    map.put("creater", SecureUtil.getCurrentUser().getGuid());
                    map.put("province", SecureUtil.getUserSelectProvince());
                    map.put("year", CommonUtil.getYear());
                }
                deptPerfDAO.delDatas("V_PERF_BGT_INDEXPROADJUST", delsql);
                deptPerfDAO.saveAll(allprojs, "V_PERF_BGT_INDEXPROADJUST");
            }
        }
        /**
         * 处理修改的行
         */
        /*Map<String, Object> newdata = new HashMap<String, Object>();
        List<String> modguid = new ArrayList<>();
        for (Map<String, Object> map : updatas) {
            newdata = (Map<String, Object>) map.get("nowData");
            rowtype = (String) newdata.get("rowtype");
            if (!"add".equals(rowtype)){
//                List<Map<String, Object>> modprojs = new ArrayList<>();
                newdata.put("updatetime",timeStamp);
                newdata.put("update_time",timeStamp);
                modguid.add((String) newdata.get("guid"));
                uplist.add(newdata);
            }
        }
        // 处理要修改的数据内容.
        String bgtguid = "";
        for (Map<String, Object> map : bgtmodlist) {
            bgtguid = (String) map.get("guid");
            if (!modguid.contains(bgtguid)){
                uplist.add(map);
            }
        }
        if (uplist.size() > 0) {
            IDicTableQueryService dicQueryService = (IDicTableQueryService) ServiceFactory.getBean("bus.dic.table.queryService");
            List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode(tablecode);
            List diccolumn = new ArrayList<String>();
            String curcolumn = "";
            for (DicColumnDTO dicColumnDTO : dicColumnDTOs) {
                curcolumn = (String) dicColumnDTO.get("dbcolumncode");
                if ("PROVINCE".equals(curcolumn) || "YEAR".equals(curcolumn) || "PROSELECT".equals(curcolumn)) {
                    continue;
                }
                diccolumn.add(curcolumn);
            }
            deptPerfDAO.updateAllByPK(diccolumn, uplist,"guid",tablecode);
            if ("perfindexdatatable".equals(componentid)){ //处理指标对应的项目s
                List<Map<String, Object>> modallprojs = new ArrayList<>();
                String modflg = "";
                List<Map<String, Object>> tempprojs = new ArrayList<>();
                for (Map<String, Object> map : uplist) {
                    modflg = map.get("projmod")== null ? "": (String) map.get("projmod");
                    if ("mod".equals(modflg)){
                        tempprojs = (List<Map<String, Object>>) map.get("projects");
                        if (tempprojs.size() > 0){
                            modallprojs.addAll(tempprojs);
                        }
                    }
                }
                //处理guid
                for (Map<String, Object> map : modallprojs) {
                    map.put("guid", StringUtil.createUUID());
                    map.put("mainguid", mainguid);
                    map.put("agencyguid", saveAgency);
                    map.put("status", 1);
                    map.put("is_deleted", 2);
                    map.put("createtime", timeStamp);
                    map.put("updatetime", timeStamp);
                    map.put("creater", SecureUtil.getCurrentUser().getGuid());
                    map.put("province", SecureUtil.getUserSelectProvince());
                    map.put("year", CommonUtil.getYear());
                }
                deptPerfDAO.saveAll(uplist, deptPerfDAO.PMKPI_TABLE_TMP_GUIDS);
                String delsql = " exists(select 1 from " + deptPerfDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.indexguid) ";
                delsql = delsql + " and mainguid = '"+mainguid+"'";
                deptPerfDAO.updateIsDeleteDatas("V_PERF_BGT_INDEXPRO", delsql);
                deptPerfDAO.saveAll(modallprojs, "V_PERF_BGT_INDEXPRO");
            }
        }
        *//**
         * 处理删除
         *//*
        if (deldatas.size() > 0) {
            deptPerfDAO.saveAll(deldatas, deptPerfDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + deptPerfDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            deptPerfDAO.updateIsDeleteDatas(tablecode, delsql);
            if ("perfindexdatatable".equals(componentid)){ //处理指标对应的项目s
                delsql = " exists(select 1 from " + deptPerfDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.indexguid) ";
                delsql = delsql + " and mainguid = '"+mainguid+"'";
                deptPerfDAO.updateIsDeleteDatas("V_PERF_BGT_INDEXPRO", delsql);
            }
        }
        if ("budgetdatatable".equals(componentid)){ //预算机制挂钩，处理一下原来表有，后来改掉的.
            String tempsql = " t.mainguid = '"+mainguid+"' and t.agencyguid = '"+saveAgency+"' and not exists (select 1 from v_bgt_perf_indicator c where c.guid = t.indexguid and c.isbudget = 1)";
            tempsql = tempsql + " and t.indexguid not in ('FIXEDBGTLINKBGTINFO0001','FIXEDBGTLINKBGTINFO0002')";
            deptPerfDAO.updateIsDeleteDatas("V_PERF_BGT_LINKBGTINFO", tempsql);
        }*/
        if ("perfindexdatatable".equals(componentid)){ //处理绩效指标二三级编码
            deptPerfDAO.updateGroupSindx(saveAgency, mainguid);
            deptPerfDAO.updateGroupTindx(saveAgency, mainguid);
        }
        return this.auditdefine(datas, busguid,"perf", null);
    }

    /**
     * 查询部门指标填报的选择项目.
     * @param agencyguid -- 部门.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public List<Map<String, Object>> findWaitPros(String agencyguid) {
        return deptPerfDAO.findWaitPros(agencyguid);
    }

}
