package gov.mof.fasp2.pmkpi.perfprogram.assessment;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.List;
import java.util.Map;

public class PerfAssessmentDAO extends PmkpiDAO {

    public static final String PERF_TABLE_ASSESSMENTTEMP = "V_PERF_T_ASSESSMENTTEMP";

    public static final String PERF_TABLE_ASSESSMENT = "V_PERF_T_ASSESSMENT";

    public static final String PERF_TABLE_ASSESSMENTOPINION = "V_PERF_T_ASSESSMENTOPINION";

    /**
     * 查询数据
     * @param proguid --项目guid
     * @return
     */
    public List<Map<String, Object>> getDatas(String proguid, String bustype) {
        String[] str;
        String sql = "select t.guid, t.code,t.name,t.weight,t.points,t.superid,t.levelno,t.isleaf," +
                " t.guid as tguid, a.scorenum,a.standard,a.remarks,t.bustype from " + this.PERF_TABLE_ASSESSMENTTEMP +
                " t left join " + this.PERF_TABLE_ASSESSMENT + " a on t.guid=a.tempguid where a.mainguid = ?";
        if (!StringUtil.isEmpty(bustype)) {
            sql += " and t.bustype = a.bustype and t.bustype = ?";
            str = new String[]{proguid, bustype};
        } else {
            sql += " and nvl(t.bustype, 'assessment') = 'assessment'";
            str = new String[]{proguid};
        }
        sql += " order by t.ordernum";
        logger.info("事前绩效评估sql------------" + sql);
        return PerfUtil.lowMapKey(this.queryForList(sql, str));
    }

}
