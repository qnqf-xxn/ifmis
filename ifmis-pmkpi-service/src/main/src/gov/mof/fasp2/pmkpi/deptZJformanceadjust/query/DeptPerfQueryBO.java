package gov.mof.fasp2.pmkpi.deptZJformanceadjust.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
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

public class DeptPerfQueryBO extends PmkpiBO {

    private DeptPerfQueryDAO deptPerfQueryDAO;

    public void setDeptPerfQueryDAO(DeptPerfQueryDAO deptPerfQueryDAO) {
        this.deptPerfQueryDAO = deptPerfQueryDAO;
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
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String tablecode = "v_perf_t_adjust";
        String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype='dept' ";
        leftconfig.put("datas", deptPerfQueryDAO.getLeftTree(tablecode, datarule));
        return leftconfig;
    }

    /**
     * 获取左侧树显示数据.
     *
     * @param menuId
     *            -- 菜单.
     * @throws AppException
     *             -- 自定义异常
     * @rturn --
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getLeftTreeData(String menuId,String sysvalue)
            throws AppException {
        String sql = this.getDicDSDataListByWheresql("t", menuId, sysvalue);
        //根据权限查询
        List<Map<String, Object>> list = deptPerfQueryDAO.getTreeList(sql,sysvalue);
        List<Map<String, Object>> treesourcedata = new ArrayList<Map<String, Object>>();
        Object isleaf = 0;
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(deptPerfQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        for (Map<String, Object> map : list) {
            isleaf = map.get("isleaf");
            if (1 == ((Number) isleaf).intValue()) {
                treesourcedata.add(map);
            }
        }
        if("PMKPIDEPT".equals(sysvalue)){
            deptPerfQueryDAO.saveAll(list, deptPerfQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        } else {
            deptPerfQueryDAO.saveAll(treesourcedata, deptPerfQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        return deptPerfQueryDAO.getLeftTree();
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
            data = deptPerfQueryDAO.getDatas(s.toString(), wheresql, null);
        } else {
            String mainguid = (String)params.get("mainguid");
            String tablecode = (String)params.get("tablecode");
            String tablesql = (String)params.get("tablesql");
            String orderby = (String)params.get("orderby");
            wheresql = " t.mainguid = '" + mainguid + "'";
            if (tablesql != null && !StringUtils.isEmpty(tablesql)) {
                wheresql += tablesql;
            }
            data = deptPerfQueryDAO.getDatas(tablecode, wheresql, orderby);
        }
        backMap.put("data", data);
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
//        String workflow = (String) sqlmap.get("workflow");
//        String tabcode = (String) sqlmap.get("tabcode");
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(deptPerfQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        if (!"1".equals(isleaf) && !"treeroot".equals(agency)) {
            // 数据权限
            String datarule = this.getDicDSDataListByWheresql("t", menuid, "PMKPIAGENCYALLPAY");
            //String sql = "";
            if (!"treeroot".equals(agency)) {
                datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
            }
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("AGENCY",datarule);
            deptPerfQueryDAO.saveAll(eledatas, deptPerfQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
            String sysvalue = PerfUtil.getSystemSet("dept_letftree");
            if (sysvalue == null || StringUtils.isEmpty(sysvalue)){
                //默认查询单位
                sysvalue="PMKPIAGENCYALLPAY";
            }
            List<Map<String, Object>> treeData =  this.getLeftTreeData(menuid,sysvalue);
            deptPerfQueryDAO.saveAll(treeData, deptPerfQueryDAO.PMKPI_TABLE_TMP_AGENCY);
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
        if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
            sql.append(" and t.agencyguid='").append(agency).append("')");
        } else if ("0".equals(isleaf)) {
            sql.append(" and exists(select * from ").append(deptPerfQueryDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid))");
        }
        if (orderby != null && !StringUtils.isEmpty(orderby)) {
            sql.append(" ").append(orderby);
        }
        return sql;
    }
}
