package gov.mof.fasp2.pmkpi.appraisal.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.Map;

public class AppraisalQueryBO extends PmkpiBO {
    private AppraisalQueryDAO appraisalQueryDAO;

    public void setAppraisalQueryDAO(AppraisalQueryDAO appraisalQueryDAO) {
        this.appraisalQueryDAO = appraisalQueryDAO;
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
        leftconfig.put("name", "预算部门");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String treesource = PerfUtil.getSystemSet("dept_letftree");
        if (!StringUtils.isEmpty(treesource)) {
            // 数据权限
            String sql = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
            sql += " and exists(select 1 from v_perf_t_appraisal a where a.agencyguid=t.guid)";
            leftconfig.put("datas", PerfUtil.getSourceData(treesource, sql));
        }
        return leftconfig;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String querysql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String) sqlmap.get("menuid");
        String tablecode = (String) sqlmap.get("tablecode");
        String wheresql = (String) sqlmap.get("tablesql");
        String agencyguid = (String) sqlmap.get("agencyguid");
        String isleaf = sqlmap.get("isleaf") + "";
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where ");
        String datarulesql = this.getDataRuleByMenuguidNull(menuid, "t", "1=1");
        sql.append(datarulesql);
        if (querysql != null && ! querysql.isEmpty()){
            sql.append(" and (").append(querysql).append(")");
        }
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agencyguid, appraisalQueryDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }

}
