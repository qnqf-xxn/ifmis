package gov.mof.fasp2.pmkpi.setting.casepage.query;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class CaseQueryDAO extends PmkpiDAO {
    /**
     * 获取左侧树数据.
     *
     * @return --
     */
    public List<Map<String, Object>> getCaseType(String casetype, String leftsource) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select distinct t.* from ").append("(select t.* from v_perf_enum t where t.elementcode='" + leftsource + "' order by ordernum)");
        sql.append(" t start with guid='").append(casetype).append("'");
        sql.append(" connect by prior t.guid = t.superguid");
        sql.append(" order by code,ordernum ");
        logger.info("查询类型sql：" + sql.toString());
        return this.queryForList(sql.toString());
    }
}
