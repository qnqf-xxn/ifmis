/**
 * @Title: PerfDataRuleDAO
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-8-10  GM
 */


package gov.mof.fasp2.pmkpi.perfset.datarule;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import org.springframework.jdbc.core.ConnectionCallback;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.*;
import java.util.List;
import java.util.Map;


/**
 * @ClassName: PrjIndexDAO
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@bjinfor.cn">GM</a>于 2020-1-6 上午10:42:14
 */

public class PerfDataRuleDAO extends PmkpiDAO {

    public void delDataRule(String roleid, String meuid) throws AppException{
        String sql = "delete from pmkpi_t_roledatarule t where t.roleguid = '";
        sql +=roleid;
        sql += "' and t.menuguid = '";
        sql += meuid;
        sql += "'";
        sql += " and year='" + CommonUtil.getYear() + "'";
        sql += " and province='" + SecureUtil.getUserSelectProvince() + "'";
        this.execute(sql);
    }

    //根据
    public void delDataRuleByTable(String roleid,String table) throws AppException{
        StringBuffer sql = new StringBuffer();
        sql.append("delete from pmkpi_t_roledatarule t where t.roleguid = '");
        sql.append(roleid).append("'");
        sql.append(" and exists (select 1 from ").append(PmkpiDAO.PMKPI_TABLE_TMP_AGENCY);
        sql.append(" tmp where t.menuguid = tmp.guid ) ");
        sql.append(" and year = '").append(CommonUtil.getYear()).append("'");
        sql.append(" and province = '").append(SecureUtil.getUserSelectProvince()).append("'");
        this.execute(sql.toString());
    }

    /**
     * 查询本区划和公共的数据权限.
     * @return list.
     * @throws
     */
    public List<Map<String, String>> findAllDatarule() {
        String sql = "select t.guid,t.name from pmkpi_t_datarule t where (t.province = '87' or t.province = '" + CommonUtil.getProvince() + "') and t.status = 1";
        return this.queryForList(sql);
    }
    /**
     * 查询角色已经分配的菜单.
     * @return
     * @throws
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, String>> getMenuByRoleId(String roleid) {
        String sql = "select distinct a.* from fasp_t_pubmenu a start with exists (select t.menuguid from pmkpi_t_roledatarule t where t.roleguid = '" + roleid + "'";
        sql += " and t.year='" + CommonUtil.getYear() + "'";
        sql += " and t.province='" + SecureUtil.getUserSelectProvince() + "' and t.menuguid = a.guid ) connect by prior a.parentid = a.guid order by code";
        logger.info("---查询角色已经分配数据权限的菜单sql：" + sql);
        return this.queryForList(sql);
    }

    /**
     * 根据角色和菜单查询已经分配的数据权限.
     * @param roleid -- 角色
     * @param menuid -- 菜单
     * @return
     * @throws
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, String>> getMenuByRoleId(String roleid, String menuid) {
        String sql = "select t.dataruleguid from pmkpi_t_roledatarule t where t.roleguid = '" + roleid + "' and t.menuguid ='" + menuid + "'";
        sql += " and year='" + CommonUtil.getYear() + "'";
        sql += " and province='" + SecureUtil.getUserSelectProvince() + "'";
        return this.queryForList(sql);
    }
    /**
     * <p>查询角色下所有已经配置数据权限的菜单</p >
     *
     * @author hw
     * @date 2022/6/7 11:19
     * @param
     */
    public List<Map<String, String>> getAllMenuByRoleId(String roleid) {
        String sql = "select t.* from pmkpi_t_roledatarule t where t.roleguid = '" + roleid + "'";
        sql += " and year='" + CommonUtil.getYear() + "'";
        sql += " and province='" + SecureUtil.getUserSelectProvince() + "'";
        return this.queryForList(sql);
    }
    /**
     * 查询角色.
     * @param wheresql -- 查询条件.
     * @param orderby -- 排序.
     * @return
     * @throws
     */
    public List getRoleList(String wheresql, String orderby) {
        if (StringUtil.isEmpty(wheresql)) {
            wheresql = "1=1";
        }
        if (StringUtil.isEmpty(orderby)) {
            orderby = "code";
        }
        String sql = (new StringBuilder("select * from fasp_t_carole t where status=1 and ")).append(wheresql)
                .append("  order by ").append(orderby).toString();
        return this.queryForList(sql);
    }
    /**
     * 查询用户所在角色.
     * @param userguid -- 用户.
     * @return
     * @throws
     */
    public List getUserRoleList(String userguid) {
        return getRoleList((new StringBuilder(
                "exists (select 1 from fasp_t_causerrole a where t.guid = a.roleguid and a.userguid = '")).append(userguid)
                .append("')").toString(), "code");
    }
    /**
     * 查询页面数据权限.
     * @param rolelist -- 角色.
     * @param menuguid -- 菜单.
     * @param tablealias -- 别名.
     * @return
     * @throws AppException -- 异常
     * @throws
     */
    public String queryWhereSql(List rolelist, final String menuguid, final String tablealias) throws AppException {
        final String userguid = CommonUtil.getCurrentUserID();
        final String province = CommonUtil.getProvince();
        final String usertype = CommonUtil.getCurrentUser().getUsertype() + "";
        String curragency = CommonUtil.getCurrentUser().getAgency();
        if ("1".equals(usertype)) {
            curragency = CommonUtil.getCurrentUser().getDivision(); //处室
        }
        final String agencyid = curragency;
        /*if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable("PERF_TMP_RULEGUIDS");
        }
        this.saveAll(rolelist, "PERF_TMP_RULEGUIDS");*/
        return (String) getJdbcTemplate().execute(new ConnectionCallback() {
            public Object doInConnection(Connection conn) throws SQLException {
                String sql = "{ call PKG_PMKPI_DATARULE.getwheresql(?,?,?,?,?,?,?)}";
                CallableStatement cstmt = null;
                StringBuffer wheresql = new StringBuffer();
                try {
                    cstmt = conn.prepareCall(sql);
                    cstmt.setString(1, menuguid);
                    cstmt.setString(2, userguid);
                    cstmt.setString(3, province);
                    cstmt.setString(4, usertype); //0 单位 1财政
                    cstmt.setString(5, agencyid);
                    cstmt.setString(6, tablealias);
                    if (!"edb".equals(DbTypeUtil.getCurrentDBType()) && !"dm".equals(DbTypeUtil.getCurrentDBType())) {
                        cstmt.registerOutParameter(7, Types.CLOB);
                        cstmt.execute();
                        Clob clob = cstmt.getClob(7);
                        if (clob == null || clob.length() == 0L) {
                            wheresql.append("1=1");
                        } else {
                            Reader is = clob.getCharacterStream();
                            BufferedReader br = new BufferedReader(is);
                            try {
                                for (String s = br.readLine(); s != null; s = br.readLine()) {
                                    wheresql.append(s);
                                }
                            } catch (IOException e) {
                                logger.error(e.getMessage(), e);
                            }
                        }
                    } else {
                        cstmt.registerOutParameter(7, Types.VARCHAR);
                        cstmt.execute();
                        String clob = cstmt.getString(7);
                        if (clob == null || clob.length() == 0L) {
                            wheresql.append("1=1");
                        } else {
                            wheresql.append(clob);
                        }
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage(), e);
                } finally {
                    if (cstmt != null) {
                        cstmt.close();
                    }
                }
                return wheresql.toString();
            }
        });
    }

}
