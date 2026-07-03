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

public class MergeIndexAdjustDAO extends PmkpiDAO {

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
     * 根据条件查询指标数据.
     * @param pro_code -- 项目code.
     * @param tablecode -- 查询案例表或项目指标表
     * @param wheresql -- 过滤条件.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> findIndexsByCodeFilter(String pro_code, String tablecode, String wheresql) {
        StringBuffer sql = new StringBuffer();
        sql.append("select 1 isleaf, '1' rowtype, t.* from ").append(tablecode).append(" t where t.pro_code = '");
        sql.append(pro_code).append("'");
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
     * 根据条件查询指标数据.
     * @param pro_code -- 项目code.
     * @param tablecode -- 查询案例表或项目指标表
     * @param wheresql -- 过滤条件.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> getGoalsByCodeFilter(String pro_code, String tablecode, String wheresql) {
        StringBuffer sql = new StringBuffer("select t.* from ").append(tablecode).append(" t where t.pro_code = '");
        sql.append(pro_code).append("'");
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
     * 更改is_deleted字段，改为删除状态
     * @param tablecode
     */
    public void updateIndexDelStuts(String tablecode, String wheresql) {
        StringBuilder sql = new StringBuilder("update ");
        sql.append(tablecode).append(" t set t.is_deleted = '1' ,updatetime='").append(PerfUtil.getServerTimeStamp());
        sql.append("', update_time='").append(PerfUtil.getServerTimeStamp()).append("'");
        if (!StringUtil.isEmpty(wheresql)) {
            sql.append(" where ").append(wheresql);
        }
        logger.debug("删除sql++++++++" + sql);
        this.execute(sql.toString());
    }


    public List<Map<String, Object>> getJustnums(String proguid) {
        String sql= "select max(adjustnum) adjustnum,proguid from (select proguid,adjustnum from V_PERF_T_ADJUST t where t.proguid='"+proguid+"') group by proguid";
        return this.queryForList(sql);
    }

    /**
     *  预算调整调剂校验绩效指标目标目标.
     * @param province -- 预算传递过来的区划
     * @param year -- 预算传递的年度
     * @return  list.
     */
    public List checkYearAdjperformance( final String province, final String year) {
        return (List) getJdbcTemplate().execute(new ConnectionCallback() {
            public Object doInConnection(Connection conn) throws SQLException {
                String sql = "{call PKG_PERF_CHECKPERFINDEX.checkBdmYearAdjperf(?)}";
                CallableStatement cstmt = null;
                ResultSet rs = null;
                List vchList = new ArrayList();
                try {
                    cstmt = conn.prepareCall(sql);
                    cstmt.registerOutParameter(1, OracleTypes.CURSOR);
                    cstmt.execute();
                    rs = (ResultSet) cstmt.getObject(1);
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
