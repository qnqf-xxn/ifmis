package gov.mof.fasp2.pmkpi.deptoverallmerit.dao;

import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class DeptOverallMeritManageDAO extends PmkpiDAO {

    /**
     * 监控项目来源.
     */
    private static final String PERF_PROGRAM_SOURCE = "PERF_V_TRACEPROGRAMS";

    /**
     * 查询符合的项目.
     * @param cols -- 列.
     * @param filter -- 条件.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> getProList(String cols, String filter) {
        StringBuffer sql = new StringBuffer("select ");
        sql.append(cols).append(", t.tracenum from ");
        sql.append(PERF_PROGRAM_SOURCE);
        if (filter != null && !StringUtils.isEmpty(filter)) {
            sql.append(" t where ").append(filter);
        }
        sql.append(" order by code");
        return this.getJdbcTemplate().queryForList(sql.toString());
    }

}
