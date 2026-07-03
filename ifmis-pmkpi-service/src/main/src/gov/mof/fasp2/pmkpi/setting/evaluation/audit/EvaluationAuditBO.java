package gov.mof.fasp2.pmkpi.setting.evaluation.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EvaluationAuditBO extends PmkpiBO {
    private EvaluationAuditDAO evaluationAuditDAO;

    public void setEvaluationAuditDAO(EvaluationAuditDAO evaluationAuditDAO){
        this.evaluationAuditDAO = evaluationAuditDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String loginuserid = PerfUtil.getuserid();
        StringBuffer returnsql = new StringBuffer("select t.* from ");
        returnsql.append(tablecode).append(" t  where ");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1"); //数据权限
        returnsql.append(datarule);
        if (wheresql != null && !wheresql.isEmpty()){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }

        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, evaluationAuditDAO.PMKPI_TABLE_T_AGENCY));
        return returnsql.toString();
    }

    /**
     * 查询左侧树。
     * */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = "V_PERF_T_EVALUATION";
        //String lefttabtype = (String) params.get("lefttabtype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        //datarule += " and bustype='" + lefttabtype + "' ";
        return evaluationAuditDAO.getLeftTree(tablecode, datarule);
    }

    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = "V_PERF_T_EVALUATION";
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid, actioncode, null);
    }

}
