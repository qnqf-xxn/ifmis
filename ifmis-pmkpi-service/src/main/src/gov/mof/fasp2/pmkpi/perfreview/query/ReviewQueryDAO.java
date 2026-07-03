package gov.mof.fasp2.pmkpi.perfreview.query;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class ReviewQueryDAO extends PmkpiDAO {

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
