package gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class ProConfirmDAO extends PmkpiDAO {
    public static final String PERF_TABLE_PROCONFIRM = "v_perf_t_finevaluation";

    public static final String PERF_STRING_PROCONFIRM = "finconfirmhide";

    public static final String PERF_TABLE_PROINDEXTRACE = "PERF_T_PROINDEXTRACE";

    public static final String PERF_TABLE_PROMONITOR = "PERF_T_PROMONITOR";

    public static final String PERF_TABLE_T_PROBGTFUND = "PERF_T_PROBGTFUND";

    public static final String PERF_TABLE_T_FINEVALUATION = "PERF_T_FINEVALUATION";

    public static final String PERF_TABLE_T_FINEVARELATION = "PERF_T_FINEVARELATION";

    public static final String PERF_TABLE_T_SELFEVALTASK = "PERF_T_SELFEVALTASK";

    public static final String PERF_TABLE_T_SELFPROFUND = "PERF_T_SELFPROFUND";

    public static final String PERF_TABLE_T_SELFPERFINDEX = "PERF_T_SELFPERFINDEX";

    /**
     * 根据权限获取单位
     * @param wheresql
     * @return
     */
    public List<Map<String, Object>> getTreeList(String wheresql, String tablecode) {
        String sql = "select * from PMKPI_FASP_T_PUBAGENCY m where 1=1 and exists "
                + "(select 1 from (select * from " + tablecode + " t where "
                + wheresql
                + " ) n where m.guid = n.agencyguid ) order by code";
        return this.queryForList(sql);
    }
}
