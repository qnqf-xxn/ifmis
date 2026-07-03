
package gov.mof.fasp2.pmkpi.deptperformance.audit;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class PmkpiPerfAuditDAO extends PmkpiDAO {
    public static final String AUDITSUB_TABLE = "perf_t_audititems";
    public static final String AUDITMAIN_TABLE = "perf_t_auditmain";
    public static final String TEMPLATE_TABLE = "perf_t_natrueaudittemp";

    /**
     * @description 获取四性审核明细数据.
     * @param mainguid -- 主表guid
     * @return map
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getData(String mainguid) {
//        Map<String, Object> map = new HashMap<String, Object>();
        StringBuilder sql = new StringBuilder("select t.*, m.proposal from ");
        sql.append(TEMPLATE_TABLE).append(" t left join (select * from ").append(AUDITSUB_TABLE);
        sql.append(" where auditguid = '").append(mainguid).append("') m on t.guid = m.tempguid order by ordernum");
        List<Map<String, Object>> datas = this.queryForList(sql.toString());
        return datas;
    }
}
