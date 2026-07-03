package gov.mof.fasp2.pmkpi.deptracetask.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.deptracetask.dao.DeptraceTaskManageDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptraceTaskManageBO extends PmkpiBO {
    private DeptraceTaskManageDAO deptraceTaskManageDAO;

    public void setDeptraceTaskManageDAO(DeptraceTaskManageDAO deptraceTaskManageDAO) {
        this.deptraceTaskManageDAO = deptraceTaskManageDAO;
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
//        String pagetype = (String) params.get("pagetype");
        List<Map<String, Object>> data = null;
//        List queryConfig = (List) params.get("queryConfig");
//        Map<String ,String> queryParam = (Map<String, String>) queryConfig.get(0);
        String wheresql = (String) params.get("querySql");
        String menuid = (String)params.get("menuid");
        String isleaf = (String)params.get("isleaf");
        String agency = (String)params.get("agency");
        String tablecode = (String)params.get("tablecode");
        String tabfilter = (String) params.get("tabfilter");
        String tablesql = (String) params.get("tablesql");
        String orderby = (String) params.get("orderby");
        String workflow = (String) params.get("workflow");
        String tabcode = (String) params.get("tabcode");
        String ctablecode = (String) params.get("ctablecode");
        if (tabcode != null && "create".equals(tabcode)) {
            tablecode = ctablecode;
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
            deptraceTaskManageDAO.saveAll(eledatas, deptraceTaskManageDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
        	String sysvalue = deptraceTaskManageDAO.getSystemDepttree();
            List<Map<String, Object>> treeData =  this.getLeftTree(menuid,sysvalue);
            deptraceTaskManageDAO.saveAll(treeData, deptraceTaskManageDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("select * from ");
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
            sql.append(" and exists(select * from ").append(deptraceTaskManageDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid)");
        }
        if (orderby != null && !orderby.isEmpty()) {
            sql.append(" ").append(orderby);
        }
        data = deptraceTaskManageDAO.queryForList(sql.toString());
        backMap.put("data", data);
        return backMap;
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
        String sysvalue = deptraceTaskManageDAO.getSystemDepttree();
        leftconfig.put("datas", this.getLeftTree(menuId,sysvalue));
        return leftconfig;
    }

    /**
     * 保存绩效监控
     * @param parms --
     * @return
     */
    public Map<String, Object> saveTask(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> backmap = new HashMap<String, Object>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) parms.get("datas");
        Map<String, Object> infodata = (Map<String, Object>) parms.get("infodata");
        String workflow = (String) parms.get("workflow");
        String tablecode = (String) parms.get("tablecode");
        List<Map<String, Object>> tasklist = new ArrayList<Map<String, Object>>();
        Map<String, Object> taskMap = null;
        deptraceTaskManageDAO.saveAll(datas, PmkpiDAO.PMKPI_TABLE_TMP_GUIDS);
        String wheresql = " exists(select * from "+ PmkpiDAO.PMKPI_TABLE_TMP_GUIDS + " a where t.mainguid=a.guid)";
        List<Map<String, Object>> indexList = deptraceTaskManageDAO.getDatas("perf_t_deptperfindex", wheresql, "order by ordernum");
        for (Map<String, Object> map : datas) {
            String newguid = this.getCreateguid();
            String mainproguid = (String) map.get("guid");
            taskMap = new HashMap<String, Object>();
            for(Map.Entry<String, Object> entry : infodata.entrySet()){
                String mapKey = entry.getKey();
                taskMap.put(mapKey, entry.getValue());
            }
            for (Map<String, Object> indexmap : indexList) {
                String proguid =  (String) indexmap.get("mainguid");
                if (proguid.equals(mainproguid)) {
                    String guid = (String) indexmap.get("guid");
                    indexmap.put("indexguid", guid);
                    indexmap.put("taskguid", newguid);
                    indexmap.put("guid", this.getCreateguid());
                    indexmap.put("createtime", StringUtil.getSysDBDate());
                    indexmap.put("updatetime", StringUtil.getSysDBDate());
                    indexmap.put("creater", SecureUtil.getCurrentUserID());
                    indexmap.put("province", SecureUtil.getUserSelectProvince());
                    indexmap.put("year", CommonUtil.getYear());
                    indexmap.put("agencyguid", map.get("agencyguid"));
                }
            }
            taskMap.put("createtime", StringUtil.getSysDBDate());
            taskMap.put("updatetime", StringUtil.getSysDBDate());
            taskMap.put("guid", newguid);
            taskMap.put("creater", SecureUtil.getCurrentUserID());
            taskMap.put("province", SecureUtil.getUserSelectProvince());
            taskMap.put("year", CommonUtil.getYear());
            taskMap.put("agencyguid", map.get("agencyguid"));
            taskMap.put("deptproguid", mainproguid);
            taskMap.put("tracestatus", "1"); //已下达
            taskMap.put("islast", "1"); //标记最后一次
            int tracenum = this.mapGetInt(map, "tracenum") + 1;
            map.put("tracenum", tracenum); //最后一次+1
            tasklist.add(taskMap);
        }
        this.workflow("create", workflow, null, tablecode, tasklist);
        deptraceTaskManageDAO.saveAll(indexList, "perf_t_traceindex");
        backmap.put("flg","1");
        return backmap;
    }

    /**
     * 字符数字转换.
     * @param map -- map.
     * @param col -- 字段.
     * @return int.
     * @throws
     */
    public int mapGetInt(Map<String, Object> map, String col) {
        Object o = map.get(col);
        if (o == null) {
            return 0;
        }
        return Integer.parseInt(o.toString());
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
            deptraceTaskManageDAO.saveAll(deldatas, deptraceTaskManageDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + deptraceTaskManageDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            deptraceTaskManageDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + deptraceTaskManageDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    deptraceTaskManageDAO.delDatas(deltable, delsql);
                }
            }
            backMap.put("flg","1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
}
