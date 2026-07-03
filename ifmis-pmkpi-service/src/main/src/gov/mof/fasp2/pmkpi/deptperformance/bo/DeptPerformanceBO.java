package gov.mof.fasp2.pmkpi.deptperformance.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.LogFactory;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.deptperformance.dao.DeptPerformanceDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;


public class DeptPerformanceBO extends PmkpiBO {

    private DeptPerformanceDAO deptPerformanceDAO;

    public void setDeptPerformanceDAO(DeptPerformanceDAO deptPerformanceDAO) {
        this.deptPerformanceDAO = deptPerformanceDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        return super.getVodSql(sqlmap);
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        String pagetype = (String) params.get("pagetype");
        String orderby = (String) params.get("orderby");
        StringBuffer s = new StringBuffer();
        String wheresql = "";
        List<Map<String, Object>> data = null;
        if (pagetype != null && (pagetype.equals("report") || pagetype.equals("audit"))){
            s = this.getReportQuerySql(params);
            data = deptPerformanceDAO.getDatas(s.toString(), wheresql, orderby);
        } else if (pagetype != null && pagetype.equals("deptfunc")){
            s = this.getDeptfuncQuerySql(params);
            data = deptPerformanceDAO.getDatas(s.toString(), wheresql, orderby);
        } else if (pagetype != null && pagetype.equals("deptindex")){
            return this.getIndexData(params);
        } else {
            String mainguid = (String)params.get("mainguid");
            String tablecode = (String)params.get("tablecode");
            String tablesql = (String)params.get("tablesql");
            wheresql = " t.mainguid = '" + mainguid + "'";
            if (tablesql != null && !StringUtils.isEmpty(tablesql)) {
                wheresql += tablesql;
            }
            data = deptPerformanceDAO.getDatas(tablecode, wheresql, orderby);
        }
        backMap.put("data", data);
        return backMap;
    }


    /**
     * 获取指标数据.
     * @return
     */
    public Map<String, Object> getIndexData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String)params.get("mainguid");
        String tablecode = (String)params.get("tablecode");
        //String indextable = (String)params.get("indextable");
        //String agency = (String)params.get("agency");
        String modelguid = (String)params.get("modelguid");
        String indexsql = " t.mainguid = '" + mainguid + "'";
        String orderby = " order by ordernum";
        List<Map<String, Object>> indexs = deptPerformanceDAO.getDatas(tablecode, indexsql, orderby);
        List<Map<String, Object>> tempdatas = deptPerformanceDAO.getTempdatas(mainguid);
        List<Map<String, Object>> modeldatas = deptPerformanceDAO.getModeldatas(modelguid, tablecode, mainguid);
        List<Map<String, Object>> collist = deptPerformanceDAO.getCol(tablecode);
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        Map<String, Object> sumMap = new HashMap<String, Object>();
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        List<Map<String, Object>> tempList = null;
        String sindex = "";
        String findex = "";
        String fsuperid = "";
        String ssuperid = "";
        float sweightsum = 0;
        float fweightsum = 0;
        for (Map<String, Object> map : modeldatas) {
            map.put("tindex", map.get("guid"));
            map.put("guid", this.getCreateguid());
            map.put("mainguid", mainguid);
            indexs.add(map);
        }
        for (Map<String, Object> map : indexs) {
            map.put("levelno", "3");
            map.put("isleaf", "1");
            findex = (String) map.get("findex");
            sindex = (String) map.get("sindex");
            String weight = map.get("weight") + "";
            if (findex.equals(fsuperid)) {
                if (weight != null && !"null".equals(weight) && !StringUtils.isEmpty(weight)) {
                    fweightsum = fweightsum + Float.parseFloat(weight);
                }
            } else {
                if (weight != null && !"null".equals(weight) && !StringUtils.isEmpty(weight)) {
                    fweightsum =  + Float.parseFloat(weight);
                }
            }
            if (sindex.equals(ssuperid)) {
                if (weight != null && !"null".equals(weight) && !StringUtils.isEmpty(weight)) {
                    sweightsum = sweightsum + Float.parseFloat(weight);
                }
            } else {
                if (weight != null && !"null".equals(weight) && !StringUtils.isEmpty(weight)) {
                    sweightsum = Float.parseFloat(weight);
                }
            }
            map.put("superid", sindex);
            if (!indexMap.containsKey(sindex)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(sindex, tempList);
            } else {
                tempList = indexMap.get(sindex);
            }
            tempList.add(map);
            ssuperid = sindex;
            fsuperid = findex;
            sumMap.put(sindex, sweightsum);
            sumMap.put(findex, fweightsum);
        }
        sindex = "";
        //findex = "";
        for (Map<String, Object> map : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                    map.put(col, "");
                }
            }
            String levelno = map.get("levelno") + "";
            if (levelno != null && !StringUtils.isEmpty(levelno) && !"null".equals(levelno) && "2".equals(levelno)) {
                sindex = (String) map.get("guid");
                map.put("weight",sumMap.get(sindex));
            } else if (levelno != null && !StringUtils.isEmpty(levelno) && !"null".equals(levelno) && "1".equals(levelno)) {
                findex = (String) map.get("guid");
                map.put("weight",sumMap.get(findex));
                sindex = "";
            }
            backdata.add(map);
            if (indexMap.containsKey(sindex)) {
                tempList = indexMap.get(sindex);
                backdata.addAll(tempList);
            }
        }
        backMap.put("data", backdata);
        return backMap;
    }


	/**
     * 申报/审核页面查询
     * @param sqlmap --
     * @return --
     * @throws AppException
     */
    public StringBuffer getReportQuerySql(Map sqlmap) throws AppException {
//        List queryConfig = (List) sqlmap.get("queryConfig");
//        Map<String ,String> queryParam = (Map<String, String>) queryConfig.get(0);
        String wheresql = (String) sqlmap.get("querySql");
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf");
        String agency = (String)sqlmap.get("agency");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        //String orderby = (String) sqlmap.get("orderby");
        String workflow = (String) sqlmap.get("workflow");
        String tabcode = (String) sqlmap.get("tabcode");
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        if (!"1".equals(isleaf) && !"treeroot".equals(agency)) {
            // 数据权限
            String datarule = this.getDicDSDataListByWheresql("t", menuid, "PMKPIAGENCYALLPAY");
            //String sql = "";
            if (!"treeroot".equals(agency)) {
                datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
            }
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY",datarule);
            deptPerformanceDAO.saveAll(eledatas, deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
        	String sysvalue = PerfUtil.getSystemSet("dept_letftree");
            List<Map<String, Object>> treeData =  this.getLeftTree(menuid,sysvalue);
            deptPerformanceDAO.saveAll(treeData, deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("(select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where t.province='").append(province).append("'");
        sql.append(" and t.year=").append(year);
        if (wheresql != null && !StringUtils.isEmpty(wheresql)){
            sql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !StringUtils.isEmpty(tablesql)){
            sql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !StringUtils.isEmpty(tabfilter)){
            sql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !StringUtils.isEmpty(wfsql)) {
            sql.append(" and ").append(wfsql);
        }
        if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
            sql.append(" and t.agencyguid='").append(agency).append("')");
        } else if ("0".equals(isleaf)) {
            sql.append(" and exists(select * from ").append(deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid))");
        }
        return sql;
    }

    /**
     *
     * @param sqlmap
     * @return
     * @throws AppException
     */
    public StringBuffer getDeptfuncQuerySql(Map sqlmap) throws AppException {
        StringBuffer sql = new StringBuffer();
        String mainguid = (String)sqlmap.get("mainguid");
        String tablecode = (String)sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql");
        sql.append(" (select * from ").append(tablecode).append(" where 1=1 ");
        sql.append(" and mainguid='").append(mainguid).append("'");
        if (tablesql != null && !StringUtils.isEmpty(tablecode)) {
            sql.append(" and ").append(tablecode);
        }
        sql.append(")");
        return sql;
    }

    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String treesource = PerfUtil.getSystemSet("dept_letftree");
        if (!StringUtils.isNullOrEmpty(treesource)){
            // 数据权限
            String sql = this.getDicDSDataListByWheresql("t", menuId, treesource);
            if ("PMKPIDEPT".equals(treesource)) {
                sql += " and isleaf = 0 and length(guid)=3 ";
            }
            List datas = deptPerformanceDAO.getLeftTree(PmkpiDAO.PMKPI_TABLE_T_AGENCY, sql);
            leftconfig.put("datas", datas);
        }
        return leftconfig;
    }


	/**
	 * 基础信息修改
	 * @param config --
	 * @return
	 * @throws AppException
	 */
	public Map infosave(HashMap config) throws AppException {
	    Map<String,Object> backMap = new HashMap<String, Object>();
	    String guid = (String) config.get("mainguid");
        String tablecode = (String) config.get("tablecode");
        String agency = (String) config.get("agency");
        String workflow = (String) config.get("workflow");
        String busguid = (String) config.get("busguid");
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
		//当前登录用户
		UserDTO user = SecureUtil.getCurrentUser();
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
		if(null != guid && !StringUtils.isEmpty(guid)){
			Map map = null;
			List<Map> datas = deptPerformanceDAO.getByGuid(tablecode, guid);
			if (datas != null && datas.size() > 0) {//修改
				map = datas.get(0);
				map.putAll(infodata);
				map.put("updatetime", StringUtil.getSysDBDate());
				deptPerformanceDAO.update(map, tablecode);
			} else {//新增
                infodata.put("createtime", StringUtil.getSysDBDate());
                infodata.put("updatetime", StringUtil.getSysDBDate());
                infodata.put("guid", guid);
                infodata.put("creater", user.getGuid());
                infodata.put("province", user.getProvince());
                infodata.put("year", CommonUtil.getYear());
                infodata.put("agencyguid", agency);
				//初始化有效状态
                infodata.put("status", "1");

                this.workflow("create",workflow, "", tablecode, l);
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
        //Map<String, Object> urlparameters = (Map<String, Object>) params.get("urlparameters");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid,"perf", null);
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> tablesave(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        //关联字段
        //String mainguid = (String) params.get("mainguid");
        String agency = (String) params.get("agency");
        String busguid = (String) params.get("busguid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //修改数据
        //List<Map<String, Object>> updatas = (List<Map<String, Object>>) params.get("updatas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        List<String> deltables = (List<String>) params.get("deltables");
        List<String> delcols = (List<String>) params.get("delcols");

        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        int i = 1;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            map.put("ordernum", i++);
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("agencyguid", agency);
                Map object = getByGuid(tablecode, (String) map.get("guid"));
                if (object.size() <= 0){
                    addlist.add(map);
                }
            } else {
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            deptPerformanceDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            deptPerformanceDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            deptPerformanceDAO.saveAll(deldatas, deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            deptPerformanceDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    deptPerformanceDAO.delDatas(deltable, delsql);
                }
            }
        }
        return this.auditdefine(datas, busguid,"perf", null);
    }

    /**
     * 编辑区查询
     * @param params
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String agency = (String) params.get("agency");
        String tablecode = (String) params.get("tablecode");
        String pagetype = (String) params.get("pagetype");
        Map<String, Object> map = this.getByGuid(tablecode, mainguid);
        if (pagetype != null && pagetype.equals("manceinfo")) {
            if(map.isEmpty()){
                List<Map<String, Object>> agencyList = this.getAgencyData(agency);
                if (null != agencyList && agencyList.size() != 0) {
                    String name = (String) agencyList.get(0).get("name");
                    String code = (String) agencyList.get(0).get("code");
                    map.put("name", name);
                    map.put("code", code);
                }
                map.put("guid", mainguid);
            }
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
        List<String> deltables = (List<String>) parms.get("deltables");
        List<String> delcols = (List<String>) parms.get("delcols");
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        try {
            deptPerformanceDAO.saveAll(deldatas, deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            deptPerformanceDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    deptPerformanceDAO.delDatas(deltable, delsql);
                }
            }
            backMap.put("flg","1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }


    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> saveall(HashMap<String, Object> params) throws AppException {
        Map<String,Object> backMap = new HashMap<String, Object>();
        //关联字段
        String mainguid = (String) params.get("mainguid");
        String agency = (String) params.get("agency");
        String workflow = (String) params.get("workflow");
        List<String> savecomponentis = (List<String>) params.get("savecomponentis");
        Map<String, Object> tableconfig =  (Map<String, Object>) params.get("tableconfig"); //组件
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();//数据
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        for (String componentid: savecomponentis) {
            //表名
            String tablecode = (String) tableconfig.get(componentid);
            String busguid = (String) tableconfig.get(componentid + "_busguid");
            if(componentid.indexOf("editform") != -1){
                Map<String, Object> infodata = (Map<String, Object>) tableconfig.get(componentid  + "_infodata");
                //当前登录用户
                UserDTO user = SecureUtil.getCurrentUser();
                l.add(infodata);
                if(null != mainguid && !StringUtils.isEmpty(mainguid)){
                    Map map = null;
                    List<Map> datas = deptPerformanceDAO.getByGuid(tablecode, mainguid);
                    if (datas != null && datas.size() > 0) {//修改
                        map = datas.get(0);
                        map.putAll(infodata);
                        map.put("updatetime", StringUtil.getSysDBDate());
                        deptPerformanceDAO.update(map, tablecode);
                    } else {//新增
                        infodata.put("createtime", StringUtil.getSysDBDate());
                        infodata.put("updatetime", StringUtil.getSysDBDate());
                        infodata.put("guid", mainguid);
                        infodata.put("creater", user.getGuid());
                        infodata.put("province", user.getProvince());
                        infodata.put("year", CommonUtil.getYear());
                        infodata.put("agencyguid", agency);
                        //初始化有效状态
                        infodata.put("status", "1");

                        this.workflow("create",workflow, "", tablecode, l);
                    }
                }
            }
            if(componentid.indexOf("datatable") != -1 ){
                //全部数据
                List<Map<String, Object>> datas = (List<Map<String, Object>>) tableconfig.get(componentid  + "_datas");
                //修改数据
                //List<Map<String, Object>> updatas = (List<Map<String, Object>>) tableconfig.get(componentid  + "_updatas");
                //删除数据
                List<Map<String, Object>> deldatas = (List<Map<String, Object>>) tableconfig.get(componentid  + "_deldatas");
                List<String> deltables = (List<String>) tableconfig.get(componentid  + "_deltables");
                List<String> delcols = (List<String>) tableconfig.get(componentid  + "_delcols");
                l = datas;
                List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
                List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
                int i = 1;
                for (Map<String, Object> map : datas) {
                    String rowtype = (String) map.get("rowtype");
                    //String guid = (String) map.get("guid");
                    map.put("ordernum", i++);
                    if (rowtype != null && "add".equals(rowtype)) {
                        map.put("createtime", StringUtil.getSysDBDate());
                        map.put("updatetime", StringUtil.getSysDBDate());
                        map.put("creater", SecureUtil.getCurrentUser().getGuid());
                        map.put("province", SecureUtil.getUserSelectProvince());
                        map.put("year", CommonUtil.getYear());
                        map.put("agencyguid", agency);
                        addlist.add(map);
                    } else {
                        uplist.add(map);
                    }
                }
                if (addlist.size() > 0) {
                    deptPerformanceDAO.saveAll(addlist, tablecode);
                }
                if (uplist.size() > 0) {
                    deptPerformanceDAO.updateAllByPK(uplist, "guid", tablecode);
                }
                if (deldatas.size() > 0) {
                    deptPerformanceDAO.saveAll(deldatas, deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY);
                    String delsql = " exists(select 1 from " + deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
                    deptPerformanceDAO.delDatas(tablecode, delsql);
                    if (deltables != null && deltables.size() > 0) {
                        String col = "mainguid";
                        int j = 0;
                        for (String deltable : deltables) {
                            if (delcols != null && delcols.size() > 0) {
                                col = delcols.get(j);
                            }
                            delsql = " exists(select 1 from " + deptPerformanceDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                            deptPerformanceDAO.delDatas(deltable, delsql);
                        }
                    }
                }
            }
            backMap.put("componentid", componentid);
            backMap = this.auditdefine(l, busguid,"perf", backMap);
            boolean  success = (Boolean) backMap.get("success");
            String errtype = (String) backMap.get("errtype");
            if(!success && "force".equals(errtype)){
                throw new PerfAppException("checkAuditDefine", errtype, backMap);
            } else if (!success) {
                return backMap;
            }
        }
        return backMap;
    }

    /**
     * 获取选择指标
     * @param parms
     * @return
     */
	public Map<String, Object> indexcheck(HashMap<String, Object> parms) {
		Map<String, Object> backMap = new HashMap<String, Object>();
		List<Map<String, Object>> data =new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> indexlib = deptPerformanceDAO.getDatas("perf_t_indexlib",null,null);
		List<Map<String, Object>> deptindexlib = deptPerformanceDAO.getDatas("perf_t_deptindexlib",null,null);
		if(indexlib!=null && indexlib.size()>0){
			data.addAll(indexlib);
		}
		if(deptindexlib!=null && deptindexlib.size()>0){
			data.addAll(deptindexlib);
		}
		backMap.put("data", data);
        return backMap;
	}

	public void bgtAudit(List<String> list,String iscancel) throws AppException {
        Logger logger = LogFactory.getLog(this.getClass());
        HashSet<Map<String, Object>> agencyList = new HashSet<>();
        Map<String, Object> agencymap = null;
        PmkpiDAO pmkpiDAO = PerfServiceFactory.getPmkpiDAO();
        HashSet<String> ageList = new HashSet<>();
        for (String value : list){
            agencymap = new HashMap<>();
            agencymap.put("guid", value); //单位编码
            agencyList.add(agencymap);
            ageList.add(value);
            for (int i=0; i<value.length()/3 - 1; i++) {
                String code = value.substring(0,3 * (i+1));
                if (!ageList.contains(code)) {
                    agencymap = new HashMap<>();
                    agencymap.put("guid", code); //部门编码
                    agencyList.add(agencymap);
                    ageList.add(code);
                }
            }
        }
        if (agencyList.size() >0){
            String deptbgtaudit = PerfUtil.getSystemSet("DEPTBGTAUDIT");
            Map<String, Object> mm = PerfUtil.parseString2Map(deptbgtaudit);
            String deptwfstatus = (String) mm.get("deptwfstatus");
            List<Map<String, Object>> al = new ArrayList<Map<String, Object>>();
            al.addAll(agencyList);
            if(!StringUtils.isEmpty(iscancel) && "1".equals(iscancel)){//取消终审
                deptwfstatus = "00";//取消终审状态
                //删除批复部门整体目标和指标数据
                this.delDeptPerfPfdata(al,true);
            }else{//终审
                //备份批复部门整体目标和指标数据
                this.saveDeptPerfPfdata(al,true);
            }
            String istogether = PerfUtil.getSystemSet("DEPTGOALSINGLE"); //部门整体绩效申报是否与预算编制流程一起
            if (!StringUtil.isEmpty(istogether) && "1".equals(istogether)) { //和预算一起走流程的场景，需要更新流程状态；单独报不更新
                logger.debug("预算终审单位/部门++++++++" + agencyList.toString());
                String sql = "update v_perf_t_deptperfdeclare t set t.wfstatus='" + deptwfstatus + "' ,t.updatetime='"+PerfUtil.getServerTimeStamp()+"' where " + deptPerformanceDAO.createInSql("agencyguid", ageList) + " and nvl(t.wfstatus,'00') <> '" + deptwfstatus + "'";
                logger.debug("--------修改状态sql -------------"+sql);
                pmkpiDAO.execute(sql);
            }
        }
    }

    /**
     * 终审/批复 保存备份批复部门整体目标和指标数据
     * @param agencyList 单位
     * @param isUpdateLastInst 是否更新is_last_inst终审状态，预算接口调用true，模块调用false
     * @throws AppException
     */
    public void saveDeptPerfPfdata(List<Map<String, Object>> agencyList,boolean isUpdateLastInst) throws AppException {
        String timestamp = PerfUtil.getServerTimeStamp();
        deptPerformanceDAO.saveAll(agencyList, deptPerformanceDAO.PMKPI_TABLE_TMP_GUIDS);
        //用于查询日常版本数据（is_backup = 2）-复制批复版本
        String pfsql = " is_backup = 2 and exists(select 1 from "+ deptPerformanceDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid = t.agencyguid)";
        //用于删除历史批复版本数据（is_backup = 1 and is_last_inst = 1）
        String delsql = " is_backup = 1 and exists(select 1 from "+ deptPerformanceDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid = t.agencyguid)";
        //用于判断是否有过批复数据（调用过批复接口日常版本数据is_last_inst = 1）
        String isexistsql = " is_last_inst = 1 and exists(select 1 from "+ deptPerformanceDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid = t.agencyguid)";
        if(PerfUtil.getIS_HUBEI()){//湖北，只处理年度
            pfsql += " and yearflag = '0'";
            delsql += " and yearflag = '0'";
            isexistsql += " and yearflag = '0'";
        }
        List<Map<String, Object>> pfGoalDataList = deptPerformanceDAO.getDatas(deptPerformanceDAO.BGT_TABLE_GOAL, pfsql, null);
        List<Map<String, Object>> delGoalDataList = deptPerformanceDAO.getDatas(deptPerformanceDAO.BGT_TABLE_GOAL, isexistsql, null);
        for (Map<String, Object> data : pfGoalDataList){
            String newguid = StringUtil.createUUID();
            data.put("guid", newguid);
            data.put("kpi_dep_id", newguid);
            if(isUpdateLastInst || delGoalDataList.size()>0){//is_last_inst=1的两种情况：1.接口调用isUpdateLastInst=true, 2.有is_last_inst=1的接口历史批复数据需要覆盖
                data.put("is_last_inst",1);//是否终审
            }else{
                data.put("is_last_inst",2);//是否终审
            }
            data.put("is_backup",1);//版本记录
            data.put("versiontype",2);//批复
            data.put("update_time",timestamp);
            data.put("version",CommonUtil.getYear() + "yspf");//版本号
            data.put("version_name","预算批复版本");//版本号说明
        }
        if(pfGoalDataList.size()>0){
            deptPerformanceDAO.updateIsDeleteDatas(PerfConstant.BGT_BACKUP_TABLE_GOAL,delsql);
            deptPerformanceDAO.saveAll(pfGoalDataList, PerfConstant.BGT_BACKUP_TABLE_GOAL);
        }
        List<Map<String, Object>> pfIndexDataList = deptPerformanceDAO.getDatas(deptPerformanceDAO.BGT_TABLE_INDICATOR, pfsql, null);
        List<Map<String, Object>> delIndexDataList = deptPerformanceDAO.getDatas(deptPerformanceDAO.BGT_TABLE_INDICATOR, isexistsql, null);
        for (Map<String, Object> data : pfIndexDataList){
            String newguid = StringUtil.createUUID();
            data.put("guid", newguid);
            data.put("kpi_id", newguid);
            if(isUpdateLastInst || delIndexDataList.size()>0){//is_last_inst=1的两种情况：1.接口调用isUpdateLastInst=true, 2.有is_last_inst=1的接口历史批复数据需要覆盖
                data.put("is_last_inst",1);//是否终审
            }else{
                data.put("is_last_inst",2);//是否终审
            }
            data.put("is_backup",1);//版本记录
            data.put("versiontype",2);//批复
            data.put("update_time",timestamp);
            data.put("version",CommonUtil.getYear() + "yspf");//版本号
            data.put("version_name","预算批复版本");//版本号说明
        }
        if(pfIndexDataList.size()>0){
            deptPerformanceDAO.updateIsDeleteDatas(PerfConstant.BGT_BACKUP_TABLE_INDICATOR,delsql);
            deptPerformanceDAO.saveAll(pfIndexDataList, PerfConstant.BGT_BACKUP_TABLE_INDICATOR);
        }
        if (agencyList.size() > 0 ) {//更新规范表数据为终审 20240409追加-前提为预算接口更新，绩效单独模块不更新
            if(isUpdateLastInst || delGoalDataList.size()>0){//更新规范表数据为终审 20240410追加-有is_last_inst=1的接口历史批复数据
                String updategoalsql = "update "+deptPerformanceDAO.BGT_TABLE_GOAL+" t set t.is_last_inst = 1,updatetime = ?,update_time = ? where " + pfsql;
                deptPerformanceDAO.update(updategoalsql, new String[]{timestamp,timestamp});
            }
            if(isUpdateLastInst || delIndexDataList.size()>0){//更新规范表数据为终审 20240410追加-有is_last_inst=1的接口历史批复数据
                String updateindexsql = "update "+deptPerformanceDAO.BGT_TABLE_INDICATOR+" t set t.is_last_inst = 1,updatetime = ?,update_time = ? where " + pfsql;
                deptPerformanceDAO.update(updateindexsql, new String[]{timestamp,timestamp});
            }
        }
    }

    /**
     * 取消终审/批复 删除备份批复部门整体目标和指标数据
     * @param agencyList 单位
     * @param isUpdateLastInst 是否更新islastinst true为接口调用取消批复；需要处理，false为绩效模块调用取消流程终审，不处理
     * @throws AppException
     */
    public void delDeptPerfPfdata(List<Map<String, Object>> agencyList,boolean isUpdateLastInst) throws AppException {
        String timestamp = PerfUtil.getServerTimeStamp();
        deptPerformanceDAO.saveAll(agencyList, deptPerformanceDAO.PMKPI_TABLE_TMP_GUIDS);
        String upfsql = " is_backup = 2 and exists(select 1 from "+ deptPerformanceDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid = t.agencyguid)";
        String pfsql = " is_backup = 1 and versiontype = 2 and exists(select 1 from "+ deptPerformanceDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid = t.agencyguid)";
        if(isUpdateLastInst){ //接口调用只删除=1的数据
            pfsql += " and is_last_inst = 1";
        }else{ //绩效流程调用只删除=2的数据
            pfsql += " and is_last_inst = 2";
        }
        if(PerfUtil.getIS_HUBEI()){//湖北，只处理年度
            upfsql += " and yearflag = '0'";
            pfsql += " and yearflag = '0'";
        }
        if (isUpdateLastInst && agencyList.size() > 0) {//更新规范表数据为未终审
            String updategoalsql = "update "+deptPerformanceDAO.BGT_TABLE_GOAL+" t set t.is_last_inst = 2,updatetime = ?,update_time = ? where " + upfsql;
            deptPerformanceDAO.update(updategoalsql, new String[]{timestamp,timestamp});
            String updateindexsql = "update "+deptPerformanceDAO.BGT_TABLE_INDICATOR+" t set t.is_last_inst = 2,updatetime = ?,update_time = ? where " + upfsql;
            deptPerformanceDAO.update(updateindexsql, new String[]{timestamp,timestamp});
        }
        deptPerformanceDAO.updateIsDeleteDatas(PerfConstant.BGT_BACKUP_TABLE_GOAL, pfsql);
        deptPerformanceDAO.updateIsDeleteDatas(PerfConstant.BGT_BACKUP_TABLE_INDICATOR, pfsql);
    }

    public void savePf(List<String> list, String iscancel) throws AppException {
        String procodes = deptPerformanceDAO.createInSql("pro_code", list);
        String wheresql = procodes + " and t.is_deleted=2 and t.is_backup = 2 and t.yearflag= '0' " + PerfUtil.yearProvinceSql("t");
        if (PerfUtil.getProgramIsyear()) {
            wheresql += " and nvl(t.is_adj, 2) = 2";
        }
        String timestamp = PerfUtil.getServerTimeStamp();
        //处理接收项目的编码规范表的附表，年度绩效修改是否终审字段
        if ("1".equals(iscancel)){
            String updategoalsql = "update PM_PERF_GOAL_INFO t set t.is_last_inst = 2,updatetime = ?,update_time = ?,version_name = ? where " + wheresql;
            deptPerformanceDAO.update(updategoalsql,new String[]{timestamp,timestamp, "日常动态维护版本_取消批复"});
            String updateindexsql = "update PM_PERF_INDICATOR t set t.is_last_inst = 2,updatetime = ?,update_time = ?,version_name = ? where " + wheresql;
            deptPerformanceDAO.update(updateindexsql,new String[]{timestamp,timestamp, "日常动态维护版本_取消批复"});
        } else {
            String updategoalsql = "update PM_PERF_GOAL_INFO t set t.is_last_inst = 1,updatetime = ?,update_time = ?,version_name = ? where " + wheresql;
            deptPerformanceDAO.update(updategoalsql,new String[]{timestamp,timestamp, "日常动态维护版本_批复"});
            String updateindexsql = "update PM_PERF_INDICATOR t set t.is_last_inst = 1,updatetime = ?,update_time = ?,version_name = ? where " + wheresql;
            deptPerformanceDAO.update(updateindexsql,new String[]{timestamp,timestamp, "日常动态维护版本_批复"});
        }
        //1、查询项目
        /*List<Map<String, Object>> projects = deptPerformanceDAO.getDatas("v_perf_project_info", wheresql, null);
        if (projects != null && !projects.isEmpty()) {
            for (Map<String, Object> project : projects) {
                this.setPf(project);
            }
            deptPerformanceDAO.delDatas("v_perf_bgt_projectpf", wheresql);
            deptPerformanceDAO.saveAll(projects, "v_perf_bgt_projectpf");
        }
        wheresql += " and t.yearflag = 0 ";
        //2、查询年度目标
        List<Map<String, Object>> goals = deptPerformanceDAO.getDatas("v_pm_perf_goal_info", wheresql, null);
        if (goals != null && !goals.isEmpty()) {
            for (Map<String, Object> goal : goals) {
                this.setPf(goal);
            }
            deptPerformanceDAO.delDatas("v_perf_bgt_goalpf", wheresql);
            deptPerformanceDAO.saveAll(goals, "v_perf_bgt_goalpf");
        }
        //3、查询年度指标
        List<Map<String, Object>> indexs = deptPerformanceDAO.getDatas("v_pm_perf_indicator", wheresql, null);
        if (indexs != null && !indexs.isEmpty()) {
            for (Map<String, Object> index : indexs) {
                this.setPf(index);
            }
            deptPerformanceDAO.delDatas("v_perf_bgt_indicatorpf", wheresql);
            deptPerformanceDAO.saveAll(indexs, "v_perf_bgt_indicatorpf");
        }*/
    }

    public void setPf(Map<String, Object> map) {
        map.put("guid", this.getCreateguid());
        map.put("create_time", PerfUtil.getServerTimeStamp());
        map.put("update_time", PerfUtil.getServerTimeStamp());
        map.put("createtime", PerfUtil.getServerTimeStamp());
        map.put("updatetime", PerfUtil.getServerTimeStamp());
    }
}
