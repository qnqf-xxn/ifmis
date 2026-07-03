
package gov.mof.fasp2.pmkpi.perfcommon.expdoc;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import oracle.jdbc.OracleTypes;
import org.springframework.jdbc.core.ConnectionCallback;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;


public class ExpDocDAO extends PmkpiDAO {

    public List<Map<String, Object>> queryData(String tablecode, String busguid) {
        // String sql = "select * from " + tablecode + " where guid = ?";
        // return this.queryForList(sql, new Object[] {busguid });

        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

        List<Map<String, Object>> detaillist = new ArrayList<Map<String, Object>>();

        Map<String, Object> detail = new HashMap<String, Object>();
        detail.put("name", "部门项目");
        detail.put("dutyman", "dutyman");
        detail.put("code", "001");
        detaillist.add(detail);

        Map<String, Object> m = new HashMap<String, Object>();
        m.put("data1", detaillist);
        m.put("expfilename", "绩效报告测试.doc");

        list.add(m);

        return list;
    }

    public Map<String, Object> getExpdoc(String templatecode) {
        String sql = "select * from v_perf_t_expdocmain where templatecode = ?";
        logger.info("模板配置：++++"+templatecode+"++++++" + sql);
        List<Map<String, Object>> list = PerfUtil.lowMapKey(this.queryForList(sql, new String[] {templatecode }));
        if (list.size() > 0) {
            return list.get(0);
        } else {
            return new HashMap<>();
        }
    }


    /**
     * 根据guid查询是否存在二级查询.
     *
     * @param guid --
     * @return --
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getSubExpdoc(String guid) {
        String sql = "select * from v_perf_t_expdocsub where mainguid=? order by ordernum";
        logger.info("模板配置：++++++++++" + sql);
        return PerfUtil.lowMapKey(this.queryForList(sql, new String[] {guid }));
    }

    /**
     * @查询数据
     * @param tablecode
     * @param busguid
     * @param querytype
     * @param wheresql
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getData(final String tablecode, final String busguid, String querytype, String wheresql) {
        StringBuffer sb = new StringBuffer();
        this.setProfundParams(null, busguid, null, null);
        if (querytype != null && "1".equals(querytype)) {
            sb.append("select * from ").append(tablecode);
            sb.append(" where busguid = ?");

            if (wheresql != null && !wheresql.isEmpty()) {
                sb.append(wheresql);
            }
            logger.info("导出视图语句：++++++++++" + sb.toString());
            return PerfUtil.lowMapKey(this.queryForList(sb.toString(),new String[]{busguid}));

        } else if (querytype != null && "2".equals(querytype)) {
            return (List<Map<String, Object>>) this.getJdbcTemplate().execute(new ConnectionCallback() {
                public Object doInConnection(Connection conn) throws SQLException {
                    String sql = "{ call "+tablecode+"(?,?)}";
                    List<HashMap<String, Object>> datalist = new ArrayList<HashMap<String, Object>>();
                    CallableStatement cstmt = null;
                    ResultSet rs = null;
                    try {
                        cstmt = conn.prepareCall(sql);
                        cstmt.setString(1, busguid);
                        cstmt.registerOutParameter(2, OracleTypes.CURSOR);
                        cstmt.execute();
                        if (cstmt != null){
                            rs = (ResultSet) cstmt.getObject(2);
                            if (rs != null){
                                while (rs.next()) {
                                    HashMap<String, Object> m = getHashMapByReS(rs);
                                    datalist.add(m);
                                }
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
                    return datalist;
                }
            });
        }
        return null;
    }
}
