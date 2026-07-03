package gov.mof.fasp2.pmkpi.workevaluate.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import oracle.jdbc.OracleTypes;
import org.springframework.jdbc.core.ConnectionCallback;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WorkEvaluateQueryDAO extends PmkpiDAO {

    public String PERF_TABLE_WORKEVALUATE = "V_PERF_T_WORKTASKASSIGN";

    /**
     * 根据权限获取单位
     * @param wheresql
     * @return
     */
    public List<Map<String, Object>> getTreeList(String wheresql, String tablecode) {
        String sql = "select * from PMKPI_FASP_T_PUBAGENCY m where 1=1 and exists "
                + "(select 1 from (select * from " + tablecode + " t where "
                + wheresql
                + " ) n where m.guid = n.agencyguid ) order by code";
        return this.queryForList(sql);
    }

    /**
     * @throws AppException
     * 调用存储过程
     * @throws
     */
    @SuppressWarnings({"unchecked", "rawtypes" })
    public List<Map<String, Object>> getDatas(String bustype) throws AppException {
        return (List<Map<String, Object>>)  this.getJdbcTemplate().execute(new ConnectionCallback() {
            @SuppressWarnings("rawtypes")
            @Override
            public Object doInConnection(Connection conn) throws SQLException {
                String sql = "{ call pkg_perf_evaluatescore.getAchievequery(?,?)}";
                ResultSet rs = null;
                CallableStatement cstmt = null;
                List<Map> dList = new ArrayList<Map>();
                try {
                    cstmt = conn.prepareCall(sql);
                    // 处理edb类型
                    if ("edb".equals(DbTypeUtil.getCurrentDBType())) {
                        cstmt.registerOutParameter(1, Types.REF);
                    } else {
                        cstmt.setString(1, bustype);
                        cstmt.registerOutParameter(2, OracleTypes.CURSOR);
                    }
                    cstmt.execute();
                    rs = (ResultSet) cstmt.getObject(2);
                    if (rs != null) {
                        Map dto = null;
                        ResultSetMetaData rsmd = rs.getMetaData();
                        int clmnCount = rsmd.getColumnCount();
                        while (rs.next()) {
                            dto = new HashMap();
                            for (int i = 0; i < clmnCount; i++) {
                                String columnname = rsmd.getColumnName(i + 1).toLowerCase();
                                dto.put(columnname, rs.getObject(i + 1));
                            }
                            dList.add(dto);
                        }
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage(), e);
                } finally {
                    if (rs != null) {
                        rs.close();
                    }
                    if (cstmt != null) {
                        cstmt.close();
                    }
                }
                return dList;
            }
        });
    }
}
