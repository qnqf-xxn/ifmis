package gov.mof.fasp2.pmkpi.rectification.dao;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;


public class FeedbackAuditIndexDAO extends PmkpiDAO {

    public static final String PERF_STRING_PROCONFIRM = "feedaudithide";

    /**
     *
     * @param tableName
     * @param guidcol
     * @param mainguid
     * @param where
     */
    public void deleteByMainguid(String tableName, String guidcol, String mainguid, String where) {
        StringBuilder sql = new StringBuilder("delete from ");
        sql.append(tableName).append(" where ").append(guidcol).append(" = '").append(mainguid).append("'");
        if (null != where && !where.isEmpty()) {
            sql.append(" and ").append(where);
        }
        this.execute(sql.toString());
    }
}
