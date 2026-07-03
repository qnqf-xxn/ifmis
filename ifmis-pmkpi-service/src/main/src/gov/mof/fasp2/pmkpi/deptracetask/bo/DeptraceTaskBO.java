package gov.mof.fasp2.pmkpi.deptracetask.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.deptracetask.dao.DeptraceTaskDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptraceTaskBO extends PmkpiBO {

    private DeptraceTaskDAO deptraceTaskDAO;

    public void setDeptraceTaskDAO(DeptraceTaskDAO deptraceTaskDAO) {
        this.deptraceTaskDAO = deptraceTaskDAO;
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
        StringBuffer s = new StringBuffer();
        String wheresql = "";
        List<Map<String, Object>> data = null;
        if (pagetype != null && (pagetype.equals("report") || pagetype.equals("audit"))){
            s = this.getReportQuerySql(params);
            data = deptraceTaskDAO.getDatas(s.toString(), wheresql, null);
        } else if (pagetype != null && pagetype.equals("deptfunc")){
            s = this.getDeptfuncQuerySql(params);
            data = deptraceTaskDAO.getDatas(s.toString(), wheresql, null);
        } else if (pagetype != null && pagetype.equals("deptindex")){
            return this.getIndexData(params);
        } else {
            String mainguid = (String)params.get("mainguid");
            String tablecode = (String)params.get("tablecode");
            String tablesql = (String)params.get("tablesql");
            String orderby = (String)params.get("orderby");
            wheresql = " t.mainguid = '" + mainguid + "'";
            if (tablesql != null && !tablesql.isEmpty()) {
                wheresql += tablesql;
            }
            data = deptraceTaskDAO.getDatas(tablecode, wheresql, orderby);
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
        String indexsql = " t.mainguid = '" + mainguid + "'";
        String orderby = " order by ordernum";
        List<Map<String, Object>> indexs = deptraceTaskDAO.getDatas(tablecode, indexsql, orderby);
        List<Map<String, Object>> tempdatas = deptraceTaskDAO.getTempdatas(mainguid);
        List<Map<String, Object>> collist = deptraceTaskDAO.getCol(tablecode);
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        List<Map<String, Object>> tempList = null;
        String sindex = "";
        for (Map<String, Object> map : indexs) {
            map.put("levelno", "3");
            map.put("isleaf", "1");
            sindex = (String) map.get("sindex");
            map.put("superid", sindex);
            if (!indexMap.containsKey(sindex)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(sindex, tempList);
            } else {
                tempList = indexMap.get(sindex);
            }
            tempList.add(map);
        }
        for (Map<String, Object> map : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (value == null || value.isEmpty() || "null".equals(value)) {
                    map.put(col, "");
                }
            }
            backdata.add(map);
            sindex = (String) map.get("sindex");
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
        String orderby = (String) sqlmap.get("orderby");
        String workflow = (String) sqlmap.get("workflow");
        String tabcode = (String) sqlmap.get("tabcode");
        if (!"1".equals(isleaf) && !"treeroot".equals(agency)) {
            // 数据权限
            String datarule = this.getDicDSDataListByWheresql("t", menuid, "PMKPIAGENCYALLPAY");
            //String sql = "";
            if (!"treeroot".equals(agency)) {
                datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
            }
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY",datarule);
            deptraceTaskDAO.saveAll(eledatas, deptraceTaskDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
        	String sysvalue = deptraceTaskDAO.getSystemDepttree();
            List<Map<String, Object>> treeData =  this.getLeftTree(menuid,sysvalue);
            deptraceTaskDAO.saveAll(treeData, deptraceTaskDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("(select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where t.province='").append(province).append("'");
        sql.append(" and t.year=").append(year);
        if (wheresql != null && !wheresql.isEmpty()){
            sql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !tablesql.isEmpty()){
            sql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            sql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            sql.append(" and ").append(wfsql);
        }
        if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
            sql.append(" and t.agencyguid='").append(agency).append("')");
        } else if ("0".equals(isleaf)) {
            sql.append(" and exists(select * from ").append(deptraceTaskDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid))");
        }
        if (orderby != null && !orderby.isEmpty()) {
            sql.append(" ").append(orderby);
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
        if (tablesql != null && !tablecode.isEmpty()) {
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
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.FALSE);
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        String sysvalue = deptraceTaskDAO.getSystemDepttree();
        leftconfig.put("datas", this.getLeftTree(menuId,sysvalue));
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
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
		//当前登录用户
		UserDTO user = SecureUtil.getCurrentUser();
		if(null != guid && ! guid.isEmpty()){
			Map map = null;
			List<Map> datas = deptraceTaskDAO.getByGuid(tablecode, guid);
			if (datas != null && datas.size() > 0) {//修改
				map = datas.get(0);
				map.putAll(infodata);
				map.put("updatetime", StringUtil.getSysDBDate());
				deptraceTaskDAO.update(map, tablecode);
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
                List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
                l.add(infodata);
                this.workflow("create",workflow, "", tablecode, l);
			}
            backMap.put("flg","1");
		}
		return backMap;
	}


    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //noinspection unused,unused
        //Map<String, Object> urlparameters = (Map<String, Object>) params.get("urlparameters");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = (String) params.get("tablecode");
        return this.workflow(actioncode, workflow, remark, tablecode, datas);
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public void tablesave(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        //关联字段
        //String mainguid = (String) params.get("mainguid");
        String agency = (String) params.get("agency");
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
            deptraceTaskDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            deptraceTaskDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            deptraceTaskDAO.saveAll(deldatas, deptraceTaskDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + deptraceTaskDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            deptraceTaskDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + deptraceTaskDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    deptraceTaskDAO.delDatas(deltable, delsql);
                }
            }
        }
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
        try {
            deptraceTaskDAO.saveAll(deldatas, deptraceTaskDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + deptraceTaskDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            deptraceTaskDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + deptraceTaskDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    deptraceTaskDAO.delDatas(deltable, delsql);
                }
            }
            backMap.put("flg","1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
}
