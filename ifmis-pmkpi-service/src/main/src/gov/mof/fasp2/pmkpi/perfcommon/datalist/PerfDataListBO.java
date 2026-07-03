package gov.mof.fasp2.pmkpi.perfcommon.datalist;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.Map;

public class PerfDataListBO extends PmkpiBO {

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String tablecode = (String) sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql");
        String querycols = (String) sqlmap.get("querycols");
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where 1=1 ");
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            sql.append(" and ").append(tablesql);
        }
        if (!StringUtil.isNullOrEmpty(querycols)) {
            String[] qc = querycols.split(",");
            for (String querycol : qc) {
                if (sqlmap.get(querycol) instanceof String) {
                    sql.append(" and ").append(querycols).append("='").append(sqlmap.get(querycol)).append("'");
                } else {
                    sql.append(" and ").append(querycols).append("=").append(sqlmap.get(querycol));
                }
            }
        }
        return sql.toString();
    }
}
