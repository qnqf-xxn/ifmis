package gov.mof.fasp2.pmkpi.setting.casepage.audit;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class CaseAuditDAO extends PmkpiDAO {
    public void deleteByMainguid(String tableName, String guidcol, String mainguid, String where) {
        StringBuilder sql = new StringBuilder("delete from ");
        sql.append(tableName).append(" where ").append(guidcol).append(" = '").append(mainguid).append("'");
        if (!StringUtil.isEmpty(where)) {
            sql.append(" and ").append(where);
        }
        this.execute(sql.toString());
    }

    /**
     * 获取左侧树数据.
     *
     * @return --
     */
    public List<Map<String, Object>> getCaseType(String casetype, String leftsource) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select distinct t.* from ").append("(select en.* from v_perf_enum en where en.elementcode='" + leftsource + "' order by en.ordernum)");
        sql.append(" t start with guid='").append(casetype).append("'");
        sql.append(" connect by prior t.guid = t.superguid");
        sql.append(" order by code,ordernum ");
        logger.info("查询类型sql：" + sql.toString());
        return this.queryForList(sql.toString());
    }
}
