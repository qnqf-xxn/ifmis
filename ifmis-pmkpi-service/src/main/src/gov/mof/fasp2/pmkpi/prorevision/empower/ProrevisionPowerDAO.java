package gov.mof.fasp2.pmkpi.prorevision.empower;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class ProrevisionPowerDAO extends PmkpiDAO {

    public static final String PERF_PROREVISION_AGENCY = "V_PERF_PROREVISION_AGENCY";

    /**
     * 根据权限获取单位
     * @param wheresql
     * @return
     */
    public List<Map<String, Object>> getTreeList(String wheresql, String tablecode) {
        StringBuffer sql = new StringBuffer();
        sql.append("select * from PMKPI_FASP_T_PUBAGENCY m where 1=1 and exists (select 1 from (select * from ")
                .append(tablecode).append(" t where ").append(wheresql).append(" ) n where m.guid = n.agencyguid ) order by code");
        return this.queryForList(sql.toString());
    }

}
