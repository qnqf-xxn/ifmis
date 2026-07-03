package gov.mof.fasp2.pmkpi.perfreview.proindex;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class ReviewProindexDAO extends PmkpiDAO {

    /**
     * 查询数据.
     *
     * @param guid
     * @return --
     */
    public List<Map<String, Object>> getDatas(String guid) {
        String sql ="select b.*, a.freview, a.sreview, a.content, a.type, a.proguid, a.mainguid " +
                "  from v_perf_t_reviewtemp b left join perf_t_audititems a on b.guid = a.tempguid" +
                "  and  a.mainguid = '" + guid + "' order by b.ordernum";
        return this.queryForList(sql);
    }

    /**
     * 查询数据.
     *
     * @param guid
     * @return --
     */
    public List<Map<String, Object>> findauditmain(String guid) {
        String sql ="select * from v_perf_t_auditmain a where a.mainguid = '" + guid + "' ";
        return this.queryForList(sql);
    }

    /**
     * 获取模板数据
     * @return
     */
    public List<Map<String, Object>> getTempdatas(String wheresql) {
        String sql = "select guid,t.superid,t.code,t.name,levelno,isleaf,ordernum from " + PMKPI_TABLE_T_FRAME + " t where 1=1 "
        + wheresql + " order by ordernum";
        return queryForList(sql);
    }
}
