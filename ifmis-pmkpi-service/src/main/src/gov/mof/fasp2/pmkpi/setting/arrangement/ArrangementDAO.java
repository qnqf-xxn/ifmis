package gov.mof.fasp2.pmkpi.setting.arrangement;


import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import oracle.jdbc.OracleTypes;
import org.springframework.jdbc.core.ConnectionCallback;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ArrangementDAO extends PmkpiDAO  {

    /**
     * 指标体系层级.
     */
    public static final String PERFSYSTEM_TABLE = "V_PERF_T_FRAMESYSTEM";

    /**
     * 指标体系层级.
     */
    public static final String PERFSYSTEM_T_TABLE = "PERF_T_FRAMESYSTEM";

    /**
     * 临时表.
     */
    public static final String PERF_TABLE_FRAME = "V_PERF_T_FRAME";

    public static final String PERF_TABLE_T_FRAME = "PERF_T_FRAME";

    /**
     * 临时表.
     */
    public static final String PMKPI_TABLE_TMP_GUIDS = "PERF_TMP_GUIDS";

    /**
     * 修改
     * @param map
     * @param tablecode
     */
    public void updateData(Map map, String tablecode) {
        String sql = "update "+tablecode+" set name ='"+map.get("name")+"' , bustype = '"+map.get("bustype")+"' where guid ='"+map.get("guid")+"'";
        this.execute(sql);
    }

    /**
     * 左侧树.
     * @return list.
     */
    public List<Map<String, Object>> getLeftTree() {
        StringBuffer sql = new StringBuffer();
        sql.append(" select t.guid,t.code,t.name,t.superid,t.levelno,t.levelno from ");
        sql.append(PERFSYSTEM_TABLE).append(" t where t.is_deleted = 2 ");
        sql.append(" order by ordernum ");
        List<Map<String, Object>> list = this.queryForList(sql.toString());
        return this.queryForList(sql.toString());
    }

    /**
     * 添加修改指标体系
     * @param addlist
     * @param tablecode 表名
     */
    public void saveFrame(List<Map<String, Object>> addlist, String tablecode){
        String sql = "insert into " + tablecode
                + "(ele_id, ele_code, ele_name, mof_div_code, parent_id, " +
                "level_no, is_leaf, ordernum, weight, frametype, remark, start_date, " +
                "end_date, is_enabled, update_time, is_deleted, create_time, fiscal_year, year, province) " +
                "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        for (Map<String, Object> map : addlist) {
            this.update(sql, new Object[]{map.get("guid"),map.get("code"),map.get("name")
                    ,map.get("mof_div_code"),map.get("superid"),map.get("levelno"),map.get("isleaf")
                    ,map.get("ordernum"),map.get("weight"), map.get("frametype"),map.get("remark")
                    ,PerfUtil.getServerTimeStamp(),PerfUtil.getServerTimeStamp(),1
                    ,PerfUtil.getServerTimeStamp(),2,PerfUtil.getServerTimeStamp()
                    ,map.get("fiscal_year"),map.get("year"),map.get("province")});
        }
    }

    /**
     * 修改指标体系
     * @param uplist
     * @param tablecode 表名
     */
    public void updateFrame(List<Map<String, Object>> uplist, String tablecode){
        String sql = "update " + tablecode
                + " set ele_code=?,ele_name=?,weight=?,remark=?,update_time=? where province=? and year=? " +
                "and ele_id = ?";
        for (Map<String, Object> map : uplist) {
            this.update(sql, new Object[]{map.get("code"),map.get("name"),map.get("weight")
                    ,map.get("remark"),map.get("update_time"),SecureUtil.getUserSelectProvince()
                    ,CommonUtil.getYear(),map.get("guid")
            });
        }
    }

    /**
     * .获取最大的CODE
     * @param wheresql --
     * @return --
     */
    public List<Map<String, Object>> getMaxcode(String wheresql) {
        String sql = "select * from v_perf_t_frame where 1=1"+wheresql;
        return this.queryForList(sql);
    }

    /**
     * .code个数
     * @param code --
     * @return --
     */
    public List<Map<String, Object>> getcodenum(String code) {
        String sql = "select * from v_perf_t_frame where code in("+code+")";
        return this.queryForList(sql);
    }

    /**
     * 刷新中间表编码
     */
    public void setIndexCode(){
        this.getJdbcTemplate().execute(new ConnectionCallback() {
            public Object doInConnection(Connection conn) throws SQLException {
                int indexcodenum = 4;
                String indexcodes = PerfUtil.getSystemSet("indexcoderule");//指标编码规则
                if (indexcodes != null && !indexcodes.isEmpty()) {
                    indexcodenum = Integer.parseInt(indexcodes.split("-")[2]);
                }
                String sql = "{ call pkg_perf_refreshindex.setIndexCode(?,?)}";
                ResultSet rs = null;
                CallableStatement cstmt = null;
                List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
                try{
                    cstmt = conn.prepareCall(sql);
                    cstmt.setInt(1, indexcodenum);
                    cstmt.registerOutParameter(2, OracleTypes.CURSOR);
                    cstmt.execute();
                    rs = (ResultSet) cstmt.getObject(2);
                    while (rs.next()) {
                        HashMap<String, Object> m = getHashMapByReS(rs);
                        list.add(m);
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
                return list;
            }
        });
    }

}
