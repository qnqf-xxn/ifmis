package gov.mof.fasp2.pmkpi.prorevision.goal;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ProrevisionGoalDAO extends PmkpiDAO {
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

    public List<Map<String, Object>> getDataMaps(String tablecode, String wheresql) {
        String sql = "select t.* from " + tablecode + " t where 1=1 ";
        if (wheresql != null && !wheresql.isEmpty()) {
            sql += " and " + wheresql;
        }
        logger.info("查询sql输出----------" + sql);
        List<Map<String, Object>> list = (List) PerfUtil.lowMapKey(this.queryForList(sql));
        return list;
    }
    public String getUpMainguidByProguid(String mainguid,String proguid,String tablecode){
        String upmainguid = "";
        StringBuffer sql = new StringBuffer();
        sql.append(" select t.guid,t.proguid,t.revisionnum from ");
        sql.append(tablecode);
        sql.append(" t where proguid = '").append(proguid).append("' ");
        sql.append(" and t.guid != '").append(mainguid).append("' ");
        sql.append(" and t.modtype is null ");
        sql.append(" order by t.revisionnum desc ");
        List<Map<String,Object>> list = this.queryForList(sql.toString());
        if(list!=null&&list.size()>0){
            upmainguid = (String)list.get(0).get("guid");
        }
        return upmainguid;
    }

    /**
     * 根据条件查询指标数据.
     * @param proguid -- 项目guid.
     * @param tempfilter -- 过滤条件.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> getGoalsByFilter(String proguid, String procode, String[] tempfilter) {
        String tablecode = "";
        StringBuffer wheresql = null;
        StringBuffer sql = null;
        List<Map<String,Object>> list = new ArrayList<>();
        for (String yearflag : tempfilter) {
            if ("1".equals(yearflag)) {
                tablecode = "pm_perf_goal_info";
            } else if ("0".equals(yearflag)) {
                tablecode = "v_pm_perf_goal_info";
            }
            wheresql = new StringBuffer();
            if ("1".equals(yearflag)) {
                wheresql.append(" nvl(yearflag,'0') = '1' and is_deleted = 2 and  t.mainguid ='").append(proguid).append("'");
            wheresql.append(" and is_backup=2");
            } else if ("0".equals(yearflag)) {
                if(PerfUtil.getIsHbei()){
                    wheresql.append(" nvl(yearflag,'0') = '0' and  t.mainguid ='").append(proguid).append("'");
                }else {
                    wheresql.append(" nvl(yearflag,'3') = '0' and t.pro_code='").append(procode).append("'");
                }
            }
            sql = new StringBuffer("select t.* from ").append(tablecode).append(" t ");
            if (!StringUtil.isEmpty(wheresql.toString())){
                sql.append(" where ").append(wheresql);
            }
            sql.append(" order by yearflag");
            logger.info("查询绩效目标sql----------" + sql.toString());
            list.addAll(this.queryForList(sql.toString()));
        }
        return list;
    }
}
