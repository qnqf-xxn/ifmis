package gov.mof.fasp2.pmkpi.evaluation.dept.report;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptReportDAO extends PmkpiDAO {
    public static final String PERF_TABLE_DEPTEVAL = "v_perf_t_deptevaluation";

    public Map<String, Object> getCount(String tablecode) {
        String sql = "SELECT MAX(TO_NUMBER(code)) AS code FROM " + tablecode + " t  where  t.isadd='1'";
        List list = (List) PerfUtil.lowMapKey(this.queryForList(sql));
        if (list.size() > 0) {
            return (Map<String, Object>) list.get(0);
        } else {
            return new HashMap<>();
        }
    }

}
