package gov.mof.fasp2.pmkpi.perfprotrace.report;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ProTraceTaskDAO extends PmkpiDAO {

    public static final String PERF_T_MONITORING_IMPORT = "V_PERF_T_MONITORING_IMPORT";

    public static final String PERF_TABLE_PROBGTFUND = "V_PERF_T_PROBGTFUND";

    public static final String PERF_TABLE_PROINDEXTRACE = "PERF_T_PROINDEXTRACE";

    public static final String PERF_TABLE_T_INDICATOR = "PM_PERF_INDICATOR";

    public static final String PERF_TABLE_T_PROMONITOR = "PERF_T_PROMONITOR";

    public static final String PERF_TABLE_T_PROBGTFUND = "PERF_T_PROBGTFUND";

    /**
     * 获取项目数据
     * @param whersql
     * @return
     */
    public List<Map<String, Object>> getProgramList(String whersql) {
        StringBuffer sql = new StringBuffer("select b.*,c.name as mofdepname,d.code||'-'||d.name as agencyname,e.name as prokindname from (select t.* from ");
        sql.append(this.PMKPI_TABLE_PROJECT_INFO).append("  t where ").append(whersql).append(" )b");
        sql.append(" left join ").append(this.PMKPI_TABLE_PUBDEPARTMENT).append(" c on c.guid=b.mof_dep_code");
        sql.append(" left join ").append(this.PMKPI_TABLE_T_AGENCY).append(" d on d.guid=b.agencyguid");
        sql.append(" left join v_pm_t_projectkind e on e.guid=b.pro_cat_code");
        return  this.queryForList(sql.toString());
    }

    /**
     * 获取项目绩效目标
     * @param procode
     * @return
     */
    public String getProgramGoal(String procode) {
        StringBuffer sql = new StringBuffer("select F_Z_SET_PERF_UNION('");
        sql.append(procode).append("') as ndgoal from dual");
        List<Map<String, Object>> ndgoal= this.queryForList(sql.toString());
        if (ndgoal.size() > 0) {
            return (String) ndgoal.get(0).get("ndgoal");
        }
        return "";
    }

    public Map<String, Object> getAnalysisinfo(String mainguid){
        StringBuffer sql = new StringBuffer("select b.*,decode(b.isgoal,'0','0-否','1','1-是',null)as isgoalname,decode(b.reasontype,null,'',c.code||'-'||c.name) as reasontypename from (select t.* from ");
        sql.append(" v_perf_t_protraceanalysis t where mainguid='").append(mainguid).append("' )b");
        sql.append(" left join v_perf_t_datasource c on c.elementcode ='REASONTYPE' and c.guid=b.reasontype");
        List list = this.queryForList(sql.toString());
        if (list.size()>0){
            return (Map<String, Object>) list.get(0);
        }
        return null;
    }

    /**
     * 查询主单数据
     * @return
     */
    public List<Map<String, Object>> getTraceMainData(String wheresql, String taskstage){
        StringBuffer sql = new StringBuffer("select t.* from ");
        sql.append(ProTraceManageDAO.PERF_TABLE_TRACEMANAGE).append(" t ,v_perf_t_taskset b");
        sql.append(" where b.guid = t.taskguid and b.taskstage ='").append(taskstage).append("'");
        sql.append(" and t.depttask='1' and t.provincetask='2'").append(wheresql);
        logger.info("查询主单数据++++++" + sql.toString());
        return this.queryForList(sql.toString());
    }

    /**
     * 根据项目，年度，查询年度明细指标.
     * @param tablecode -- 查询案例表或项目指标表
     * @param  filter -- 过滤条件.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> findIndexs(String tablecode, String filter, String type) {
        StringBuffer sql = new StringBuffer("select t.*,a.name as findexname,b.name as sindexname, c.name as computesignname ");
        if ("V_PERF_T_PROINDEXTRACE".equals(tablecode)) {
            sql.append(" , decode(t.completeanalysis, null,'', d.code ||'-'||d.name) as completeanalysisname ");
        }
        sql.append(" from ").append(tablecode).append(" t ");
        sql.append(" left join v_perf_t_frame a on a.guid = t.findex and a.frametype='").append(type).append("'");
        sql.append(" left join v_perf_t_frame b on b.guid = t.sindex and b.frametype='").append(type).append("'");
        sql.append(" left join v_perf_enum c on c.code = t.computesign and c.elementcode='PMKPIZBXS' ");
        if ("V_PERF_T_PROINDEXTRACE".equals(tablecode)) {
            sql.append(" left join v_perf_enum d on d.elementcode ='completeanalysis' and t.completeanalysis=d.guid");
        }
        if (!StringUtil.isEmpty(filter)) {
            sql.append(" where ").append(filter);
        }
        sql.append(" order by t.sindex,t.findex,t.ordernum");
        logger.info("监控指标查sql+++++++++++++++++" + sql.toString());
        return this.queryForList(sql.toString());
    }

    /**
     * 获取模板数据
     * @param type --
     * @return
     */
    public List<Map<String, Object>> getTempdatas(String type) {
        String sql = "select t.guid,t.superid,t.code,t.name,t.levelno,t.isleaf,t.ordernum,b.name as findexname from " + PMKPI_TABLE_T_FRAME + " t left join "+PMKPI_TABLE_T_FRAME+" b on b.guid=t.superid and b.frametype='" + type + "' where t.frametype='" + type + "' order by t.ordernum";
        List<Map<String, Object>> flist = queryForList(sql);
        List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : flist) {
            map.put("rowtype", "mod");
            String guid = (String) map.get("guid");
            String superid = (String) map.get("superid");
            String levelno = map.get("levelno") + "";
            if ("1".equals(levelno)) {
                map.put("findex", guid);
                map.put("sindex", "");
                map.put("findexname", map.get("name"));
            } else if ("2".equals(levelno)) {
                map.put("findex", superid);
                map.put("sindex", guid);
                map.put("sindexname", map.get("name"));
                map.put("findexname", map.get("findexname"));
            }
            temps.add(map);
        }
        return temps;
    }

}
