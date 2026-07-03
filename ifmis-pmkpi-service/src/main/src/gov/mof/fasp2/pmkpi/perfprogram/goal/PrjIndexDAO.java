/**
 * @Title: PrjIndexDAO.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfprogram.goal;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * @ClassName: PrjIndexDAO
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@szlongtu.com">GM</a>于 2020-1-6 上午10:42:14
 */

public class PrjIndexDAO extends PmkpiDAO {

    private static final String PMKPI_PERF_T_CASE_MODEL_GOAl = "V_PERF_T_CASEMODELGOAL";

    /**
     * 日志.
     */
    protected static Logger logger = Logger.getLogger(PrjIndexDAO.class);

    /**
     * 根据条件查询指标数据.
     * @param proguid -- 项目guid.
     * @param pdmsave -- 查询案例表或项目指标表
     * @param tempfilter -- 过滤条件.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> getGoalsByFilter(String proguid, String procode, String pdmsave, String[] tempfilter, String dataprovince) {
        String tablecode = "";
        StringBuffer wheresql = null;
        StringBuffer sql = null;
        String province = StringUtil.isNullOrEmpty(dataprovince) ? SecureUtil.getUserSelectProvince() : dataprovince;
        List<Map<String,Object>> list = new ArrayList<>();
        for (String yearflag : tempfilter) {
            wheresql = new StringBuffer();
            if ("20".equals(pdmsave)) {
                tablecode = "v_pm_perf_goal_temp";
            } else {
                if (yearflag != null && "1".equals(yearflag)) {//总体
                    tablecode = "pm_perf_goal_info";
                } else if (PerfUtil.getProgramIsyear() && "0".equals(yearflag)) {//项目库填报年度
                    tablecode = "pm_perf_goal_info";
                } else if ("0".equals(yearflag)) {//通版年度查询
                    tablecode = "v_pm_perf_goal_info";
                }
            }
            String wsql = "";
            if ("20".equals(pdmsave)) {
                wsql = " and is_deleted = 2 and t.mainguid ='" + proguid + "' and t.province='" + province + "'";
            }else{
                wsql = " and is_deleted = 2 and is_backup = 2 and t.mainguid ='" + proguid + "' and t.province='" + province + "'";
            }
            if ("1".equals(yearflag)) {
                wheresql.append(" yearflag = '1' ").append(wsql);
            } else if (PerfUtil.getProgramIsyear() && "0".equals(yearflag)) {//草稿查询年度绩效，pro_code空，根据项目guid查询
                wheresql.append(" yearflag = '0' ").append(wsql).append(" and year='").append(SecureUtil.getUserSelectYear()).append("'");
                wheresql.append(" and t.sub_mof_div_code is null");//追加条件，查询物理表时过滤掉转移支付数据
            } else if ("0".equals(yearflag)) {
                if("20".equals(pdmsave)){//草稿查询年度绩效，pro_code空，根据项目guid查询
                    wheresql.append(" yearflag = '0'").append(wsql);
                }else {
                    wheresql.append(" yearflag = '0' and t.pro_code='").append(procode).append("'");
                }
            }
            sql = new StringBuffer("select t.* from ").append(tablecode).append(" t ");
            if (!StringUtil.isEmpty(wheresql.toString())){
                sql.append(" where ");
                sql.append(wheresql);
            }
            if (!PerfUtil.getIS_HUBEI()) {
                sql.append(" and rownum=1 order by update_time desc");
            } else {
                sql.append(" order by goalname");
            }
            logger.info("查询绩效目标sql----------" + sql.toString());
            list.addAll(this.queryForList(sql.toString()));
        }
        return list;
    }

    public List<Map<String, Object>> findGoalByTempCode(String proguid, String tempcode, String[] tempfilter) {
        List<Map<String,Object>> list = new ArrayList<>();
        for (String yearflag:tempfilter) {
            List<Map<String,Object>> goallist = new ArrayList<>();
            StringBuffer sql = new StringBuffer();
            sql.append(" select '"+proguid+"' as mainguid, '"+yearflag+"' as yearflag, t.*,(case when "+yearflag+"=1 then ZQGOAL else NDGOAL end) as KPI_TARGET from ").append(PMKPI_PERF_T_CASE_MODEL_GOAl);
            sql.append(" t right join V_PERF_T_MODEL vptm on (t.mainguid = vptm.guid) where vptm.code = '").append(tempcode).append("' ");
            goallist = this.queryForList(sql.toString());
            logger.info("获取内置模板目标数据sql：-------------"+sql.toString());
            list.addAll(goallist);
        }
        for (Map<String, Object> map : list) {
            String guid = StringUtil.createUUID();
            map.put("guid", guid);
            map.put("kpi_per_id", guid);
        }
        return list;
    }

    /**
     * <p>绩效目标逻辑删除</p >
     *
     * @author hw
     * @date 2021/9/24 14:44
     * @param
     */
    public void updateDatasIsDelete(String tablecode, String wheresql) throws AppException {
        tablecode = "pm_perf_goal_info";
        String selectSql = "select * from " + tablecode + " t where t.is_deleted = 2 and t.is_backup = 2  and t.province='"+ CommonUtil.getProvince() +"' and t.sub_mof_div_code is null";
        if (wheresql != null && !wheresql.isEmpty()) {
            selectSql += " and " + wheresql;
            logger.info("---目标逻辑删除查询sql----------" + selectSql);
            List<Map<String, Object>> mapList = queryForList(selectSql);
            for(Map<String, Object> map : mapList){
                String uuid = StringUtil.createUUID();
                map.put("is_deleted", 1); // 删除
                map.put("updatetime", PerfUtil.getServerTimeStamp()); //UPDATETIME
                map.put("update_time", PerfUtil.getServerTimeStamp()); //UPDATETIME
            }
            this.updateAllByPK(mapList, "guid", tablecode); // 更新主键和删除状态
//            String sql = " update " + tablecode + " t set t.guid = t.kpi_per_id, is_deleted = 1 where t.is_deleted = 2 and t.is_backup= 2 and t.sub_mof_div_code is null and " +wheresql ;
//            logger.info("---目标逻辑删除sql----------" + sql);
//            this.execute(sql); //更新guid
        }
    }

    /**
     * 删除树级指标带有删除的.
     *
     * @param tableCode -- 表格
     * @param guids     -- guids.
     */
    public void delIndexByguid(String tableCode, String guids) {
        String time = PerfUtil.getServerTimeStamp();
        String sql = "update " + tableCode + " t set t.is_deleted = 1,updatetime='" + time + "',update_time='" + time + "' where t.guid in (";
        sql += guids;
        sql += ")";
        logger.info("-----------指标删除sql----------"+sql);
        this.update(sql);
    }

    /**
     * <p>绩效指标逻辑删除</p >
     *
     * @author hw
     * @date 2021/9/24 14:44
     * @param
     */
    public void updateIndexIsDelete(String tablecode, String wheresql)  throws AppException {
        tablecode = "pm_perf_indicator";
        String selectSql = "select * from " + tablecode + " t where t.is_deleted=2 and t.is_backup=2 and t.province='" + CommonUtil.getProvince() + "'";
        if (wheresql != null && !wheresql.isEmpty()) {
            selectSql += " and " + wheresql;
            logger.info("---指标逻辑删除查询sql----------" + selectSql);
            List<Map<String, Object>> mapList = queryForList(selectSql);
            String time = PerfUtil.getServerTimeStamp();
            for(Map<String, Object> map : mapList){
                String uuid = StringUtil.createUUID();
                map.put("is_deleted", 1); // 删除
                map.put("updatetime", time); //UPDATETIME
                map.put("update_time", time); //UPDATETIME
            }
            this.updateAllByPK(mapList, "guid", tablecode); // 更新主键和删除状态
//            String sql = " update "+tablecode+" t set t.guid = t.kpi_id, is_deleted = 1 where t.is_deleted = 2 and " +wheresql;
//            logger.info("---指标逻辑删除sql----------" + sql);
//            this.execute(sql); //更新guid
        }
    }

    /**
     * 获取特殊项目目标数据
     * @param
     * @return
     */
    public List<Map<String, Object>> getSpecialGoal(){
        return this.queryForList("select sys_guid() as guid,'1' as yearflag,agencyguid,zqgoal as kpi_target,province,year,to_char(sysdate,'YYYYMMDDHH24MISS') as create_time from v_perf_t_casemodelgoal t where exists (select 1 from v_perf_T_model t1 where t.mainguid = t1.guid and t1.code = '13' ) union all " +
                "select sys_guid() as guid,'0' as yearflag,agencyguid,zqgoal as kpi_target,province,year,to_char(sysdate,'YYYYMMDDHH24MISS') as create_time from v_perf_t_casemodelgoal t where exists (select 1 from v_perf_T_model t1 where t.mainguid = t1.guid and t1.code = '13' ) ");
    }


}
