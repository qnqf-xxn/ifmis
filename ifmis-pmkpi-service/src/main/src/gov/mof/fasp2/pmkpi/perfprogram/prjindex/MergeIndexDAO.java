/**
 * @Title: PrjIndexDAO.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import oracle.jdbc.OracleTypes;
import org.springframework.jdbc.core.ConnectionCallback;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @ClassName: PrjIndexDAO
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@szlongtu.com">GM</a>于 2020-1-6 上午10:42:14
 */

public class MergeIndexDAO extends PmkpiDAO {

    /**
     * 查询年度指标空指标模板.
     * @param proguid -- 项目.
     * @return list.
     */
    public List<Map<String, Object>> findNullTemp(String proguid) {
        String sql = "select sys_guid() guid, t.superid findex, t.guid sindex, t.guid frame, '"
                + proguid + "' prjguid from " + PMKPI_TABLE_T_FRAME + " t where 1=1 "
                + " and t.isleaf = 1 and t.frametype = 'PM001' order by ordernum";
        return this.queryForList(sql);
    }
    /**
     * 根据项目，年度，查询年度明细指标.
     * @param proguid -- 项目guid.
     * @param tablecode -- 查询案例表或项目指标表
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> findIndexs(String proguid, String tablecode) {
        String isZJ = PerfUtil.getSystemSet("isZJ"); //是否是浙江环境
        StringBuffer sql = new StringBuffer();
        if ("1".equals(isZJ) && "v_pm_perf_indicator".equals(tablecode)) { //浙江环境
            sql.append("select 1 isleaf, '1' rowtype,t.*, ");
            sql.append(" case when f.ADJOPTION = '1' then '指标不够完整' " +
                    "            when f.ADJOPTION = '2' then '指标不够细化、量化' " +
                    "              when f.ADJOPTION = '3' then '指标与项目的相关性不够' " +
                    "            when f.ADJOPTION = '4' then '指标与指标值不匹配' " +
                    "              when f.ADJOPTION = '5' then '建议拆分指标' " +
                    "              when f.ADJOPTION = '6' then '一级指标类型错误' " +
                    "                when f.ADJOPTION = '7' then '二级指标类型错误' " +
                    "                  when f.ADJOPTION = '8' then '建议增加明确效益指标' " +
                    "                    when f.ADJOPTION = '9' then '建议增加明确产出指标' " +
                    "                    when f.ADJOPTION = '10' then '建议增加满意度指标' " +
                    "                      when f.ADJOPTION = '11' then '其他'  end ADJOPTION,");
            sql.append(" f.options from ").append(tablecode).append(" t ");
            sql.append("left join v_perf_t_supervision f ");
            sql.append("on t.kpi_id = f.indexguid and t.mainguid = f.mainguid where f.wfstatus = '011' and t.mainguid = '");
        }else{
            sql.append("select * from ").append(tablecode).append(" t where t.mainguid = '");
        }
        sql.append(proguid);
        sql.append("' order by t.sindex,t.findex,t.ordernum");
        logger.debug("-------------指标查询sql-------------"+sql.toString());
        return this.queryForList(sql.toString());
    }
    /**
     * 删除项目绩效表有关.
     * @param tablecode -- 表名.
     * @param proguid -- 项目.
     * @throws -- 异常.
     */
    public void delTargets(String tablecode, String proguid) {
        String sql = "delete from " + tablecode + " t where t.mainguid = ?";
        this.update(sql, new Object[] { proguid });
    }
    /**
     * 获取符号的值集.
     * @return
     * @throws
     */
    public List<Map<String, Object>> queryComputesign() {
        String sql = "SELECT * FROM Pub_t_Enum t WHERE t.elementcode='calculateymbol'";
        return this.queryForList(sql);
    }
    /**
     * 推荐指标查询左侧树.
     * @param tabcode -- 表名
     * @param filter -- 过滤条件
     * @return
     * @throws
     */
    public List<Map<String, Object>> finTreeData(String tabcode, String filter) {
        StringBuffer sql = new StringBuffer(" select * from ");
        sql.append(tabcode).append(" where 1=1");
        if (!StringUtil.isEmpty(filter)) {
            sql.append(filter);
        }
        sql.append(" order by code");
        return this.queryForList(sql.toString());
    }
    
    /**获取部门guid
	 * 
	 * @param agencyguid
	 * @return
	 */
	public List<Map<String, Object>> getDeptGuid(String agencyguid) {
		String sql = "select t.guid,t.code||'-'||t.NAME as agency from " + PMKPI_TABLE_T_AGENCY + " t " +
		" where t.id in (select a.superid from " + PMKPI_TABLE_T_AGENCY + " a where a.GUID= " +
		" '"+agencyguid+"')";
		return this.queryForList(sql);
	}

    /**
     * 根据条件查询指标数据.
     * @param proguid -- 项目guid.
     * @param tablecode -- 查询案例表或项目指标表
     * @param wheresql -- 过滤条件.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> findIndexsByFilter(String proguid, String tablecode, String wheresql) {
        StringBuffer sql = new StringBuffer();
        sql.append("select 1 isleaf, '1' rowtype, t.* from ").append(tablecode).append(" t where t.mainguid = '");
        sql.append(proguid).append("'");
        if (!StringUtil.isEmpty(wheresql)){
            sql.append(" and ");
            sql.append(wheresql);
        }
        sql.append(" order by yearflag,t.findex,t.sindex,t.ordernum");
        return this.queryForList(sql.toString());
    }

    /**
     * 河北根据类别查询人员信息.
     * @param wheresql -- 过滤条件.
     * @return
     */
    public List<Map<String, Object>> findMouldByFilter(String mouldcode, String wheresql) {
        StringBuffer sql = new StringBuffer();
        sql.append("select 1 isleaf, 'add' rowtype, '1' yearflag,t.code,t.ordernum,t.sindex superid, 3 levelno,t.computesign,t.meterunit,\n" +
                " t.findex kpi_lv1,t.sindex kpi_lv2,t.indexvalue kpi_val,t.indexremark kpi_remark,t.findex,t.sindex,t.name,t.indexvalue indexval from v_perf_t_casemodelindex t where t.mainguid = (");
        sql.append("select c.guid from v_perf_t_model c where c.code = ?)");
        if (!StringUtil.isEmpty(wheresql)){
            sql.append(" and ");
            sql.append(wheresql);
        }
        sql.append(" order by yearflag,t.findex,t.sindex,t.ordernum");
        return this.queryForList(sql.toString(),new String[]{mouldcode});
    }
    /**
     * 指标树级获取指标.
     * @param mainguid -- 项目guid.
     * @return list.
     */
    public List<Map<String, Object>> getTempdatas(String mainguid) {
        String sql = "select guid,'"+mainguid+"' mainguid,t.superid,t.code,t.name,levelno,isleaf, '1' rowtype, ordernum from " + PMKPI_TABLE_T_FRAME + " t where frametype='PM001' order by ordernum";
        List<Map<String, Object>> flist = queryForList(sql);
        List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : flist) {
            //map.put("rowtype", "mod");
            String guid = (String) map.get("guid");
            String superid = (String) map.get("superid");
            String levelno = map.get("levelno") + "";
            if (levelno != null && !"1".equals(levelno)) {
                map.put("findex", superid);
                map.put("sindex", guid);
                //map.put("_isleaf", map.get("isleaf"));
            }
            map.put("is_add", "2");
            map.put("zqindexval", "");
            map.put("zqmeterunit", "");
            map.put("zqcomputesign", "");
            map.put("adjoption", "");
            map.put("options", "");
            temps.add(map);
        }
        return temps;
    }

    /**
     * 删除树级指标带有删除的.
     * @param tablecode -- 表格
     * @param guids -- guids.
     * @param proguid -- 项目id.
     */
    public void delIndexByguid(String tablecode, String guids, String proguid) {
        String sql = "update " + tablecode + " t set t.is_deleted = 1 where t.guid in (";
        sql += guids;
        sql += ") and t.mainguid = ?";
        this.update(sql, new String[]{proguid});
    }

    /**
     * 查询页面表格的注册字段
     * @param uikey
     * @return
     */
    public List<Map<String, Object>> getUicolumn(String uikey){
        String sql = "SELECT * FROM ( " +
                "SELECT LOWER(a.columncode) as columncode,a.name,a.ordernum FROM busfw_t_Uicolumn a where " +
                "a.key='"+uikey+"' and a.columncode in('FINDEX','SINDEX') " +
                " UNION ALL " +
                "SELECT LOWER(t.columncode) as columncode,t.name,t.ordernum FROM busfw_t_Uicolumn t where " +
                "t.key='"+uikey+"' and t.isvisiable=1 and  t.columncode <>'OBLIGATE1'" +
                "union all select 'type' columncode ,'类型' as name, 0 ordernum from dual ) order by ordernum";
        return this.queryForList(sql);
    }

    /**
     * 查询指标
     * @param proguid
     * @param yearflag
     * @return
     */
    public List<Map<String, Object>> getExportIndex(String proguid, String yearflag){
        String sql = "SELECT t.*,case when t.yearflag = '0' then '年度指标' when t.yearflag = '1' then '总体指标' end type, " +
                "(SELECT a.name FROM v_perf_t_frame a where t.FINDEX = a.guid) as ftindex,  " +
                "(SELECT a.name FROM v_perf_t_frame a where t.FINDEX = a.guid) as stindex  " +
                "FROM V_PM_PERF_INDICATOR t where t.MAINGUID = '"+proguid+"' and t.YEARFLAG = '"+yearflag+"' " +
                " order by t.CODE";
        return this.queryForList(sql);
    }

    /**
     * 根据条件查询指标数据.
     * @param proguid -- 项目guid.
     * @param tablecode -- 查询案例表或项目指标表
     * @param wheresql -- 过滤条件.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> getGoalsByFilter(String proguid, String tablecode, String wheresql) {
        StringBuffer sql = new StringBuffer("select t.* from ").append(tablecode).append(" t where t.mainguid = '");
        sql.append(proguid).append("'");
        if (!StringUtil.isEmpty(wheresql)){
            sql.append(" and ");
            sql.append(wheresql);
        }
        sql.append(" order by yearflag");
        logger.info("查询绩效目标sql----------" + sql.toString());
        return this.queryForList(sql.toString());
    }

    /**
     * 获取固定模板加载.
     * @param mouldcode -- 模板编码.
     * @param wheresql -- 过滤条件.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> getMouldGoalByFilter(String mouldcode, String wheresql) {
        StringBuffer sql = new StringBuffer("select t.zqgoal kpi_target,'1' yearflag  from v_perf_t_casemodelgoal t where t.mainguid = (select c.guid from v_perf_t_model c where c.code = ?)");
        if (!StringUtil.isEmpty(wheresql)){
            sql.append(" and ");
            sql.append(wheresql);
        }
        sql.append(" order by yearflag");
        logger.info("查询绩效目标sql----------" + sql.toString());
        return this.queryForList(sql.toString(), new String[]{mouldcode});
    }

    /**
     * 查询是否存在.
     * @param tablecode
     * @param wheresql
     * @return
     */
    public int getHeBeiMain(String tablecode, String wheresql) {
        String sql = "select count(*) from "+tablecode+" t where t.proid = ?";
        return this.queryForInt(sql, new  String[]{wheresql});
    }

    /**
     * 查询是否存在.
     * @param tablecode
     * @param wheresql
     * @return
     */
    public int getHeBeiBGTMain(String tablecode, String wheresql) {
        String province = SecureUtil.getUserSelectProvince();
        int year = SecureUtil.getUserSelectYear();
        String sql = "select count(*) from "+tablecode+" t where t.BGT_PMAIN_ID = ? and t.mof_div_code = ? and t.fiscal_year=?";
        return this.queryForInt(sql, new  String[]{wheresql, province, year+""});
    }

    /**
     * 保存操作主记录
     * @param map
     */
    public void saveMain(Map<String, Object> map) {
        String sql = "insert into  PM_KPI_MAIN_"+ SecureUtil.getUserSelectProvince()+"(kpimainid,proid,bdgyear,procode,proname,parentdept,unitname,admdivcode) " +
                "values (?,?,?,?,?,?,?,?')";
        this.update(sql, new Object[] { map.get("kpimainid"),map.get("proid"), map.get("bdgyear"),map.get("procode"),map.get("proname"),map.get("parentdept"),map.get("unitname"),map.get("admdivcode")});
    }

    /**
     * 保存绩效目标
     * @param map
     */
    public void savePerfRecord(Map<String, Object> map) {
        String sql = "insert into PM_KPI_PERFORMANCE_"+SecureUtil.getUserSelectProvince()+" (kpiperid,proid,admdivcode,bdgyear,performance"
                + ",busi_type,is_deleted,indcontent,enddate,kpimainid) values (?,?,?,?,?,?,?,?,?,?')";
        this.update(sql, new Object[] { map.get("kpiperid"),map.get("proid"), map.get("admdivcode"),map.get("bdgyear"),map.get("performance"),"1","2","绩效目标", "9998-12-31",map.get("kpimainid")});
    }

    /**
     * 保存绩效指标.
     * @param indexList -- 列表
     * @param  kpimainid -- 指标主键
     */
    public void saveKPIRecord(String kpimainid, List<Map<String, Object>>  indexList) {
        this.getJdbcTemplate().execute(new ConnectionCallback() {
            public Object doInConnection(Connection conn) throws SQLException {
                StringBuffer acctSql = new StringBuffer();
                acctSql.append("insert into PM_KPI_"+ SecureUtil.getUserSelectProvince()+" (kpiid,proid,admdivcode,bdgyear,indtypecode,indtypecode1,indcontent,indsymbol,indvalue,");
                acctSql.append("indunit,busi_type,is_deleted,inddesc,orderby,enddate,kpimainid)");
                acctSql.append(" values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                PreparedStatement pstmt = null;
                try {
                    pstmt = conn.prepareStatement(acctSql.toString());
                    for (int i = 0; i < indexList.size(); i++) {
                        HashMap<String,Object> temp = (HashMap<String,Object>) indexList.get(i);
                        pstmt.setString(1, StringUtil.createUUID());
                        pstmt.setString(2, (String) temp.get("proid"));
                        pstmt.setString(3, PerfUtil.getProvince());
                        pstmt.setInt(4, Integer.parseInt(PerfUtil.getYear()));
                        pstmt.setString(5, (String) temp.get("findex"));
                        pstmt.setString(6, (String) temp.get("sindex"));
                        pstmt.setString(7, (String) temp.get("name"));
                        pstmt.setString(8, (String) temp.get("computesign"));
                        pstmt.setString(9, (String) temp.get("indexval"));
                        pstmt.setString(10, (String) temp.get("meterunit"));
                        pstmt.setString(11, "0");
                        pstmt.setInt(12, 2);
                        pstmt.setString(13, (String) temp.get("name"));
                        pstmt.setInt(14, i+1);
                        pstmt.setString(15, "9998-12-31");
                        pstmt.setString(16, kpimainid);
                        pstmt.addBatch();
                    }
                    pstmt.executeBatch();
                } catch (SQLException e) {
                    logger.error(e.getMessage(), e);
                } finally {
                    if (pstmt != null) {
                        pstmt.close();
                    }
                }
                return null;
            }
        });
    }

    /**
     * 保存操作主记录,预算年度指标
     * @param map
     */
    public void saveBGTMain(Map<String, Object> map) {
        StringBuffer sql = new StringBuffer();
        sql.append("insert into BGT_KPI_INFO_").append(SecureUtil.getUserSelectProvince());
        sql.append(" (bgt_data_id, bgt_pmain_id, achieve_target, imple_play, expend1, expend2, expend3, " +
                "expend4, funds_use, teplate_id, mof_div_code, fiscal_year, pro_code) ");
        sql.append("values ('").append(map.get("bgt_data_id")).append("','");
        sql.append(map.get("bgt_pmain_id")).append("','绩效年度目标',");
        sql.append("null,1,1,1,1,'绩效年度目标',null,'");
        sql.append(SecureUtil.getUserSelectProvince()).append("','").append(SecureUtil.getUserSelectYear()).append("','");
        sql.append(map.get("pro_code")).append("')");
        this.getJdbcTemplate().execute(sql.toString());
    }

    /**
     * 保存绩效目标,预算年度目标
     * @param map
     */
    public void saveBGTPerfGoal(Map<String, Object> map) {
        StringBuffer sql = new StringBuffer();
        sql.append("insert into BGT_KPI_GOAL_").append(SecureUtil.getUserSelectProvince());
        sql.append(" (bgt_data_id, bgt_pmain_id, pro_code, orderby,performance, indcontent, mof_div_code, fiscal_year) ");
        sql.append("values ('").append(map.get("bgt_data_id")).append("','");
        sql.append(map.get("bgt_pmain_id")).append("','");
        sql.append(map.get("pro_code")).append("',");
        sql.append("1,null,'绩效年度目标','");
        sql.append(SecureUtil.getUserSelectProvince()).append("','").append(SecureUtil.getUserSelectYear()).append("')");
        this.getJdbcTemplate().execute(sql.toString());
    }

    /**
     * 保存绩效指标.,预算年度指标
     * @param indexList -- 列表
     * @param  kpimainid -- 指标主键
     */
    public void saveBGTPerfIndex(String kpimainid, List<Map<String, Object>>  indexList) {
        this.getJdbcTemplate().execute(new ConnectionCallback() {
            public Object doInConnection(Connection conn) throws SQLException {
                StringBuffer acctSql = new StringBuffer();
                acctSql.append("insert into BGT_KPI_IND_").append(SecureUtil.getUserSelectProvince());
                acctSql.append(" (IND_ID, FILE_GUID, ORDERBY, " +
                        "IND_TYPE1,IND_TYPE2, IND_TYPE3, IND_TYPE3_NAME, IND_DESC, IND_SYMBOL, IND_VALUE, " +
                        "IND_UNIT, EVABASIS, MOF_DIV_CODE, FISCAL_YEAR, CREATE_USER, CREATE_TIME, " +
                        "UPDATE_USER, UPDATE_TIME, BGT_PMAIN_ID, PRO_CODE, KPI_EVALSTD)");
                acctSql.append(" values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                PreparedStatement pstmt = null;
                try {
                    pstmt = conn.prepareStatement(acctSql.toString());
                    for (int i = 0; i < indexList.size(); i++) {
                        HashMap<String,Object> temp = (HashMap<String,Object>) indexList.get(i);
                        pstmt.setString(1, StringUtil.createUUID());
                        pstmt.setString(2, StringUtil.createUUID());
                        pstmt.setInt(3, Integer.parseInt(temp.get("ordernum").toString()));
                        pstmt.setString(4, (String) temp.get("findex"));
                        pstmt.setString(5, (String) temp.get("sindex"));
                        pstmt.setString(6, (String) temp.get("kpi_lv3"));
                        pstmt.setString(7, (String) temp.get("name"));
                        pstmt.setString(8, null);
                        pstmt.setString(9,  (String) temp.get("computesign"));
                        pstmt.setInt(10, 1);
                        pstmt.setString(11, (String) temp.get("meterunit"));
                        pstmt.setString(12, (String) temp.get("kpi_remark") + "EVABASIS");
                        pstmt.setString(13, SecureUtil.getUserSelectProvince());
                        pstmt.setString(14, PerfUtil.getYear());
                        pstmt.setString(15, (String) temp.get("creater"));
                        pstmt.setString(16, (String) temp.get("create_time"));
                        pstmt.setString(17, (String) temp.get("creater"));
                        pstmt.setString(18, (String) temp.get("update_time"));
                        pstmt.setString(19, (String) temp.get("bgt_pmain_id"));
                        pstmt.setString(20, (String) temp.get("pro_code"));
                        pstmt.setString(21, (String) temp.get("kpi_remark") + "EVABASIS");
                        pstmt.addBatch();
                    }
                    pstmt.executeBatch();
                } catch (SQLException e) {
                    logger.error(e.getMessage(), e);
                } finally {
                    if (pstmt != null) {
                        pstmt.close();
                    }
                }
                return null;
            }
        });
    }

    /**
     *  河北省贵州校验绩效指标目标目标.
     * @param checktype --校验类型
     * @param province -- 预算传递过来的区划
     * @param year -- 预算传递的年度
     * @return  list.
     */
    public List checkHBPerfindex(final String checktype, final String province, final String year) {
        return (List) getJdbcTemplate().execute(new ConnectionCallback() {
            public Object doInConnection(Connection conn) throws SQLException {
                String sql = "{call PKG_PERF_CHECKINDEX.checkHBProIndex(?,?,?,?)}";
                CallableStatement cstmt = null;
                ResultSet rs = null;
                List vchList = new ArrayList();
                try {
                    cstmt = conn.prepareCall(sql);
                    cstmt.setString(1, checktype);
                    cstmt.setString(2, province);
                    cstmt.setString(3, year);
                    cstmt.registerOutParameter(4, OracleTypes.CURSOR);
                    cstmt.execute();
                    rs = (ResultSet) cstmt.getObject(4);
                    while (rs.next()) {
                        HashMap map = getHashMapByReS(rs);
                        vchList.add(map);
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
                return vchList;
            }
        });
    }



}
