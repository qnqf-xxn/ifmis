package gov.mof.fasp2.pmkpi.appraisal.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AppraisalAuditBO extends PmkpiBO {
    private AppraisalAuditDAO appraisalAuditDAO;

    public void setAppraisalAuditDAO(AppraisalAuditDAO appraisalAuditDAO) {
        this.appraisalAuditDAO = appraisalAuditDAO;
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
        String workflow = (String) sqlmap.get("workflow");
        String tabcode = (String) sqlmap.get("tabcode");
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
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            sql.append(" and (").append(wfsql).append(")");
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agencyguid, appraisalAuditDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }

    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> seldatas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, seldatas);
        return this.auditdefine(seldatas, busguid, actioncode, null);
    }
}
