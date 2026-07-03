package gov.mof.fasp2.pmkpi.setting.casepage.report;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class CaseReportDAO extends PmkpiDAO {
    public static final String TABLECODE_CASE = "perf_t_case";
    public static final String TABLECODE_CASEMODELGOAL ="perf_t_casemodelgoal";
    public static final String TABLECODE_CASEMODELINDEX = "perf_t_casemodelindex";
    public static final String TABLECODE_T_CASE = "v_perf_t_case";
    public static final String TABLECODE_T_CASEMODELGOAL ="v_perf_t_casemodelgoal";
    public static final String TABLECODE_T_CASEMODELINDEX = "v_perf_t_casemodelindex";
    public static final String CASETYEP_SOURCE = "PERFGXCLASSIFICATION";//左侧树数据源

    /**
     * 获取左侧树数据.
     *
     * @return --
     */
    public List<Map<String, Object>> getCaseType(String casetype, String leftsource) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select distinct t.* from ").append("(select en.* from v_perf_enum en where en.elementcode='" + leftsource + "' order by en.ordernum)");
        sql.append(" t start with guid='").append(casetype).append("'");
        sql.append(" connect by prior t.guid = t.superguid");
        sql.append(" order by code,ordernum ");
        logger.info("查询类型sql：" + sql.toString());
        return this.queryForList(sql.toString());
    }
}
