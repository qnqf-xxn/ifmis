package gov.mof.fasp2.pmkpi.perfcommon.auditdefine;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import oracle.jdbc.OracleTypes;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import org.springframework.jdbc.core.ConnectionCallback;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AuditDefineDAO extends PmkpiDAO {

    private final static Logger logger = Logger.getLogger(AuditDefineDAO.class);


    private String TABLE_PERF_TMP_AUDITDEFINE = "PERF_TMP_AUDITDEFINE";

    /**
     * 获取审核定义校验数据.
     * @param busguid --
     * @return --
     */
    public List getBusauditdefine(String busguid) {
        String sql = "select * from v_perf_t_busauditdefine t where t.busguid='" + busguid + "'";
        return this.queryForList(sql);
    }

    /**
     * 获取审核定义值集
     * @Description:
     * @param guid --审核定义guid
     * @return 审核定义要素map
     * @throws
     */
    public List getAuditDefineByGuid(String guid) {
        String sql = "select * from v_perf_t_auditdefine t where t.guid ='" + guid + "'";
        return this.queryForList(sql.toString());
    }

    /**
     * @throws AppException
     * 调用存储过程
     * @param buslist 业务数据
     * @param busdefinemap 审核定义关联数据
     * @throws
     */
    @SuppressWarnings({"unchecked", "rawtypes" })
    public List<Map> callprocedurenew(List buslist, Map busdefinemap, final String procedure) throws AppException {
        //存入临时表
        this.insertBusDatasToTmpTable(buslist, busdefinemap);
        logger.info("--------perf_tmp_guids--------" + this.queryForList(" select * from perf_tmp_guids").toString());
        logger.info("perf_tmp_auditdefinewheresql+++++++" + this.queryForList(" select * from perf_tmp_auditdefinewheresql").toString());
        List<Map> list = (List<Map>)  this.getJdbcTemplate().execute(new ConnectionCallback() {
            @SuppressWarnings("rawtypes")
            @Override
            public Object doInConnection(Connection conn) throws SQLException {
                String sql = "{ call "+procedure+"(?)}";
                List<Map> dList = new ArrayList<Map>();
                CallableStatement cstmt = null;
                ResultSet rs = null;
                try {
                    cstmt = conn.prepareCall(sql);
                    // 处理edb类型
                    if("edb".equals(DbTypeUtil.getCurrentDBType())){
                        if("polardb".equalsIgnoreCase(DbTypeUtil.getPhysicsDbType())){
                            cstmt.registerOutParameter(1, OracleTypes.CURSOR);
                        } else {
                            cstmt.registerOutParameter(1, OracleTypes.REF);
                        }
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
                            dList.add(dto);
                        }
                    }
                    logger.error("------------------结果集-----------:"+dList+"--------");
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
        return list;
    }

    /**
     * 参数与工作流数据guid存储到临时表
     * @param datalist
     * @param tempdef
     * @throws AppException AppException
     */
    private void insertBusDatasToTmpTable(List<Map<String, Object>> datalist,Map<String, Object> tempdef) throws AppException {
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(this.TABLE_PERF_TMP_AUDITDEFINE);
        }
        this.execute("delete from " + this.TABLE_PERF_TMP_AUDITDEFINE);
        if(datalist!=null && datalist.size()>0){
            this.saveAll(datalist, this.TABLE_PERF_TMP_AUDITDEFINE);
        }
        String province = SecureUtil.getUserSelectProvince();
        String user = SecureUtil.getCurrentUserID();
        String year = SecureUtil.getUserSelectYear() + "";
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("key", "user");
        map.put("value", user);
        list.add(map);
        map = new HashMap<String,Object>();
        map.put("key", "province");
        map.put("value", province);
        list.add(map);
        map = new HashMap<String,Object>();
        map.put("key", "year");
        map.put("value", year);
        list.add(map);
        for (Map.Entry<String, Object>entry : tempdef.entrySet()) {
            String entrykey  = entry.getKey();
            Object entryvalue = entry.getValue();
            Map<String,Object> tmp = new HashMap<String,Object>();
            map.put("key", entrykey);
            map.put("value", entryvalue);
            list.add(tmp);
        }
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable("PERF_TMP_AUDITDEFINEWHERESQL");
        }
        this.saveAll(list, "PERF_TMP_AUDITDEFINEWHERESQL");
    }
}
