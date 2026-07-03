package gov.mof.fasp2.pmkpi.deptperformance.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.deptperformance.dao.DeptPerformanceQueryDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptPerformanceQueryBO extends PmkpiBO {

    private DeptPerformanceQueryDAO deptPerformanceQueryDAO;

    public void setDeptPerformanceQueryDAO(DeptPerformanceQueryDAO deptPerformanceQueryDAO) {
        this.deptPerformanceQueryDAO = deptPerformanceQueryDAO;
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
        String sysvalue = PerfUtil.getSystemSet("dept_letftree");
        if (sysvalue == null || StringUtils.isEmpty(sysvalue)){
            //默认查询单位
            sysvalue="PMKPIAGENCYALLPAY";
        }
        leftconfig.put("datas", this.getLeftTreeData(menuId,sysvalue));
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
        String tablecode = "v_perf_t_deptperfdeclare";
        String sql = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        //根据权限查询
        return deptPerformanceQueryDAO.getLeftTree(tablecode, sql);
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf");
        String agency = (String)sqlmap.get("agency");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String datarule = this.getDataRuleByMenuguidNull(menuid,"t", "1=1");
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where ");
        sql.append(datarule);
        if (wheresql != null && !StringUtils.isEmpty(wheresql)){
            sql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !StringUtils.isEmpty(tablesql)){
            sql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !StringUtils.isEmpty(tabfilter)){
            sql.append(" and ").append(tabfilter);
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, deptPerformanceQueryDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }
}
