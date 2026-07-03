package gov.mof.fasp2.pmkpi.workevaluate.score;

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

public class WorkEvaluateScoreDAO extends PmkpiDAO {
    private String TABLE_PERF_TMP_AUDITDEFINE = "PERF_TMP_AUDITDEFINE";

    /**
     * 查询数据.
     * @param wheresql
     * @return
     */
    public List<Map<String, Object>> getScoreDatas(String wheresql) {
        String sql = "select t.*,a.selfscore,a.remark,a.mainguid,a.creater,a.status,nvl(t.score,a.score)score,a.ratiscore from v_perf_t_evaluatetemp t left join v_perf_t_deptscore a on ";
        sql += wheresql;
        sql += " order by t.ordernum";
        return this.queryForList(sql);
    }

    /**
     * @throws AppException
     * 调用存储过程
     * @param params --存储过程
     * @throws
     */
    @SuppressWarnings({"unchecked", "rawtypes" })
    public List<Map<String, Object>> getScoreDatas(HashMap<String, Object> params) throws AppException {
        String agencyCode = (String)params.get("saveAgency");
        String subprovince = (String)params.get("subprovince");
        String bustype = (String)params.get("bustype");
        String filetype = params.get("scoretype") + "workscore";
        String mainguid = (String) params.get("mainguid");
        logger.info("PERF_TMP_AUDITDEFINEWHERESQL++++++" + this.queryForList("select * from PERF_TMP_AUDITDEFINEWHERESQL").toString());
        return (List<Map<String, Object>>)  this.getJdbcTemplate().execute(new ConnectionCallback() {
            @SuppressWarnings("rawtypes")
            @Override
            public Object doInConnection(Connection conn) throws SQLException {
                String sql = "{ call pkg_perf_evaluatescore.workevaluatescore(?)}";
                ResultSet rs = null;
                CallableStatement cstmt = null;
                List<Map> dList = new ArrayList<Map>();
                try {
                    cstmt = conn.prepareCall(sql);
                    // 处理edb类型
                    if("edb".equals(DbTypeUtil.getCurrentDBType())){
                        cstmt.registerOutParameter(1, Types.REF);
                    } else {
                        cstmt.registerOutParameter(1, OracleTypes.CURSOR);
                    }
                    cstmt.execute();
                    rs = (ResultSet) cstmt.getObject(1);
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
                            String isleaf = dto.get("isleaf").toString();
                            if(isleaf!=null&&"1".equals(isleaf)){
                                String filename = "";
                                String billguid = dto.get("guid") + mainguid;
                                filename = getFilenameList(billguid, filetype);
                                dto.put("filename", filename);
                            }else{
                                dto.put("filename", "");
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

    private String getFilenameList(String mainguid,String filetype){
        String name = "";
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT replace(wm_concat(t.filename), ',', '；') as FILENAME ");
        sql.append(" FROM V_PERF_FILE t ");
        sql.append(" WHERE t.BILLGUID = '").append(mainguid).append("' and t.filetype = '").append(filetype).append("'");
        Map<String,Object> map =  this.queryForMap(sql.toString());
        if(map!=null&&map.size()>0){
            name = (String)map.get("FILENAME");
        }
        return name;
    }
}
