package gov.mof.fasp2.pmkpi.tabfream;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import oracle.jdbc.internal.OracleTypes;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ConnectionCallback;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 9:47 2020/8/24  chongdayong
 */
public class TabfreamDAO extends PmkpiDAO {

    /**
     * 根据guid查询数据
     * @param guid
     * @return
     */
    public List getDataByGuid(String tablecode, String guid){
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from ");
        sql.append(tablecode).append(" where guid = '").append(guid).append("'");
        logger.info("---根据guid查询数据：" + sql);
        return this.queryForList(sql.toString());
    }

    /**
     * 根据guid查询数据
     * @param guid
     * @return
     */
    public List getDataByMainguid(String tablecode, String guid){
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from ");
        sql.append(tablecode).append(" where mainguid = '").append(guid).append("'");
        logger.info("---根据mainguid查询数据：" + sql);
        return this.queryForList(sql.toString());
    }

    /**
     * 获取编辑区公式信息
     * @param tablecode --表
     * @param mainguid --主表guid
     * @param saveAgency --单位
     * @return
     */
    public List<Map<String, Object>> getEditFormal(final String tablecode, final String mainguid, final String saveAgency) {
        List<Map<String, Object>> list = (List<Map<String, Object>>)getJdbcTemplate().execute(new ConnectionCallback() {
            public List<Map<String, Object>> doInConnection(Connection conn) throws SQLException, DataAccessException {
                String sql = "{call pkg_perf_editformal.geteditdata(?,?,?,?)}";
                ResultSet cursor = null;
                CallableStatement cstmt = null;
                List<Map<String, Object>> reList = new ArrayList<Map<String, Object>>();
                try{
                    cstmt = conn.prepareCall(sql);
                    cstmt.setString(1, mainguid);
                    cstmt.setString(2, saveAgency);
                    cstmt.setString(3, tablecode);
                    cstmt.registerOutParameter(4, OracleTypes.CURSOR);
                    cstmt.execute();
                    cursor = (ResultSet) cstmt.getObject(4);
                    while (cursor.next()) {
                        int cl = cursor.getMetaData().getColumnCount();
                        Map iVoucherDTO = new HashMap();
                        for (int i = 1; i < cl+1; i++) {
                            String key = cursor.getMetaData().getColumnName(i);
                            Object val = cursor.getObject(key);
                            iVoucherDTO.put(key.toLowerCase(), val);
                        }
                        reList.add(iVoucherDTO);
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage(), e);
                } finally {
                    if (cursor != null) {
                        cursor.close();
                    }
                    if (cstmt != null) {
                        cstmt.close();
                    }
                }
                return reList;
            }
        });
        return list;
    }
    /**
     * 查询部门已申报数据.
     * @param tablecode
     * @param wheresql
     * @return
     */
    public List<Map<String, Object>> getDeclareData(String tablecode, String wheresql) {
        String sql = "select t.* from " + tablecode + " t ";
        if (wheresql != null && !wheresql.isEmpty()){
            sql += " where " + wheresql;
        }
        return this.queryForList(sql);
    }

    /**
     * 查询上一年度部门绩效的长期目标年限.
     * @param agencyguid --单位，部门。
     */
    public List getMainMap(String agencyguid){
        String sql = "select t.endyear,t.guid from perf_t_deptperfdeclare t where t.agencyguid = ? and t.year = ? and t.province = ?";
        return this.queryForList(sql,new String[]{agencyguid, (Integer.parseInt(CommonUtil.getYear())-1)+"",CommonUtil.getProvince()});
    }
}
