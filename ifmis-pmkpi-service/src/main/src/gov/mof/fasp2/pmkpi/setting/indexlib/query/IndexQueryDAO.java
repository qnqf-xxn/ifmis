package gov.mof.fasp2.pmkpi.setting.indexlib.query;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 14:54 2020/8/17  chongdayong
 */
public class IndexQueryDAO extends PmkpiDAO {

    /**
     * 基础指标表.
     */
    public static final String PMKPI_TABLE_BASE_INDEX = "V_BAS_PERF_INDICATOR";

    /**
     * 获取单位的下级数据.
     * @param  guid -- guid.
     * @param  tablecode -- 表名
     * @return --
     */
    public List<Map<String, Object>> getElementDatas(String guid, String tablecode) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select distinct t.* from (" + tablecode + ") ");
        sql.append(" t start with  t.guid='").append(guid).append("'");
        sql.append(" connect by prior t.guid = t.superid");
        sql.append(" order by code ");
        return this.queryForList(sql.toString());
    }
}
