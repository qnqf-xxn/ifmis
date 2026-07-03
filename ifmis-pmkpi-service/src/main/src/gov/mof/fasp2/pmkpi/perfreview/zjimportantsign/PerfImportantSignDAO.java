package gov.mof.fasp2.pmkpi.perfreview.zjimportantsign;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class PerfImportantSignDAO extends PmkpiDAO {
    public static final String PERF_SIGN_PROGJECT = "V_PERF_SIGN_PROJECT_INFO";
    public static final String PERF_SIGN_DEPT = "V_PERF_T_DEPTPERFDECLARE";


    public static final String PERF_STRING_REVIEW = "signreporthide";
    /**
     * 根据权限获取单位
     * @param wheresql
     * @return
     */
    public List<Map<String, Object>> getTreeList(String wheresql, String tablecode) {
        String sql = "select * from PMKPI_FASP_T_PUBAGENCY m where 1=1 and exists "
                + "(select 1 from (select * from " + tablecode + " t where "
                + wheresql
                + " ) n where m.guid = n.agencyguid ) order by m.code";
        return this.queryForList(sql);
    }
}
