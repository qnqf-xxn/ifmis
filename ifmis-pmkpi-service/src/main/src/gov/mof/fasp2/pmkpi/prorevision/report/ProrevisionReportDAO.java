package gov.mof.fasp2.pmkpi.prorevision.report;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class ProrevisionReportDAO extends PmkpiDAO {
    public static final String PERF_TABLE_REVISION_AGENCY = "V_PERF_PROREVISION_AGENCY";

    public static final String PERF_T_TABLE_REVISIONGOAL = "V_PERF_PROVISION_GOAL_INFO";

    public static final String PERF_TABLE_PROVISIONDECLARE = "V_PERF_T_PROVISIONDECLARE";

    public static final String PERF_TABLE_PROVISIONDINDEX = "V_PERF_PROVISION_INDICATOR";


    /**
     *获取项目最大调整次数
     * @return
     */
    public List<Map<String, Object>> getJustnums() {
        //修改不是末级
        StringBuffer sql = new StringBuffer();
        sql.append("update " + this.PERF_TABLE_PROVISIONDECLARE + " t set t.islast = 0 where exists(select 1 from ");
        sql.append(this.PMKPI_TABLE_TMP_GUIDS).append(" d where t.guid=d.guid)");
        this.execute(sql.toString());
        //获取项目最大调整次数
        sql = new StringBuffer();
        sql.append("select max(revisionnum) revisionnum,proguid from (select proguid,revisionnum from " + this.PERF_TABLE_PROVISIONDECLARE + " t where exists(select 1 from ");
        sql.append(this.PMKPI_TABLE_TMP_GUIDS).append(" d where t.guid=d.guid)) group by proguid");
        return this.queryForList(sql.toString());
    }
}
