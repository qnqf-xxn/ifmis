package gov.mof.fasp2.pmkpi.perfprotrace.manage;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class ProTraceManageDAO extends PmkpiDAO {

    /**
     * 监控项目来源.
     */
    public static final String PERF_TABLE_TRACEMANAGE = "V_PERF_T_PROMONITOR";

    /**
     * 监控分析表.
     */
    public static final String PERF_TABLE_PROTRACEANALYSIS = "V_PERF_T_PROTRACEANALYSIS";

    /**
     * 监控项目来源.
     */
    public static final String PERF_VIEW_TRACEMANAGE = "PERF_V_PROMONITOR";

    /**
     * 监控项目来源.
     */
    public static final String PERF_VIEW_TRACEMANAGE_HB = "PERF_V_PROMONITOR_HB";

    /**
     * 监控全年度历史.
     */
    public static final String PERF_VIEW_TRACEMANAGE_ALLYEAR = "PERF_V_PROMONITOR_ALLYEAR";

    /**
     * 整改全年度历史.
     */
    public static final String PERF_VIEW_RECTIFY_ALLYEAR = "PERF_V_RECTIFY_ALLYEAR";

    /**
     * 监控项目来源规范表.
     */
    public static final String PERF_TABLE_MANAGE_TASK = "V_PAY_PERF_MONITOR_TASK";

    /**
     * 监控指标规范表.
     */
    public static final String PERF_TABLE_MONITOR_INFO = "V_PAY_PERF_MONITOR_INFO";

    /**
     * 监控附件规范表
     */
    public static final String PERF_TABLE_MONITOR_ATTACH = "V_PAY_PERF_MONITOR_ATTACH";

    public static final String PERF_TYPE_PROVINCENAME = "财政重点监控";

    public static final String PERF_TYPE_DEPTNAME = "部门自行监控";

    /**
     * 对已下达的进行修改，修改部门，财政下达状态
     * @param tablecode --表名
     * @param pagetype --业务类型，部门，财政
     * @param taskguid --任务guid
     * @param datas --勾选数据
     */
    public void updateTasktype(String tablecode, String pagetype, String taskguid, String tasktype, List<Map<String, Object>> datas){
        //查询任务下项目是否已下达（部门或财政下达）
        StringBuffer wheresql = new StringBuffer(" exists(select 1 from ");
        wheresql.append(this.PMKPI_TABLE_TMP_GUIDS).append(" a where ");
        if (PerfUtil.getIsHbei() || "depttrace".equals(tasktype)) {
            wheresql.append(" t.proguid=a.guid ");
        } else {
            wheresql.append(" t.pro_code=a.guid ");
        }
        wheresql.append(") and t.taskguid='").append(taskguid).append("'");
        if ((pagetype != null && "dept".equals(pagetype))) {
            wheresql.append(" and (t.depttask<>'1' or t.depttask is null) ");
        } else if (pagetype != null && "province".equals(pagetype)){//财政菜单
            wheresql.append(" and ((t.provincetask<>'1' and t.provincetask<>'3') or t.provincetask is null) ");
        }
        List<Map<String, Object>> prolist = this.getDatas(tablecode, wheresql.toString(), " order by update_time");
        if (prolist != null && prolist.size() == 0) {
            return;
        }
        //过滤已有数据，其他新增
        List<Map<String, Object>> dellist = new ArrayList<>();
        StringBuffer upguids = new StringBuffer();
        for (Map<String, Object> map : datas){
            String proguid = "";
            if (PerfUtil.getIsHbei() || "depttrace".equals(tasktype)) {
                proguid = (String) map.get("guid");
            } else {
                proguid = (String) map.get("pro_code");
            }
            for (Map<String, Object> m : prolist){
                String taskproguid = "";
                if (PerfUtil.getIsHbei() || "depttrace".equals(tasktype)) {
                    taskproguid = (String) m.get("proguid");
                } else {
                    taskproguid = (String) m.get("pro_code");
                }
                if (!StringUtil.isEmpty(taskproguid) && proguid != null && taskproguid.equals(proguid)) {
                    dellist.add(map);
                    upguids.append("'").append(m.get("guid")).append("',");
                    break;
                }
            }
        }
        datas.removeAll(dellist);
        if (prolist != null && prolist.size() > 0) {
            if (upguids.length() > 0) {
                upguids = upguids.deleteCharAt(upguids.length() - 1);
            }
            String updatesql = "update " + tablecode + " a set ";
            String wsql = "";
            if (PerfUtil.getIsHbei() || "depttrace".equals(tasktype)) {
                wsql = " a.proguid=b.guid ";
            } else {
                wsql = " a.pro_code=b.guid ";
            }
            if ((pagetype != null && "dept".equals(pagetype))) {//部门菜单
                updatesql += " depttask='1' ";
            } else if (pagetype != null && "province".equals(pagetype)){//财政菜单
                if (PerfUtil.getIsSx()) {
                    updatesql += " provincetask = '3' "; //山西改为3，增加了部门重点监控下发流程
                }else{
                    updatesql += " provincetask = '1' ";
                }
                String upcols = " is_last_inst=2, perf_type_code='2', perf_type_name='" + this.PERF_TYPE_PROVINCENAME + "' ,update_time='" + PerfUtil.getServerTimeStamp() + "'";
                if ("protrace".equals(tasktype)) {
                    String sql = "update " + this.PERF_TABLE_MANAGE_TASK + " t set " + upcols + " where perf_task_id in(" + upguids + ")";
                    //同步修改规范表
                    this.update(sql);
                    //同步修改指标表状态，暂时注释
                    sql = " update " + this.PERF_TABLE_MONITOR_INFO + " t set " + upcols + " where perf_task_id in(" + upguids + ")";
                    this.update(sql);
                }
            }
            updatesql += ",update_time='" + PerfUtil.getServerTimeStamp() + "' where exists(select 1 from " + this.PMKPI_TABLE_TMP_GUIDS + " b where " + wsql + ") and taskguid='" + taskguid + "'";
            this.update(updatesql);
        }
    }

    /**
     * 对已下达的进行修改，修改部门，财政下达状态
     * @param tablecode --表名
     * @param pagetype --业务类型，部门，财政
     * @param delguids --取消下达任务监控guid
     */
    public void del(String tablecode, String tasktype, String pagetype, List<String> delguids) throws AppException {
        String guids = delguids.stream().collect(Collectors.joining(",")).replace(",","','");
        //查询任务下部门或财政同时下达项目
        String wheresql = " guid in('" + guids + "') and t.depttask ='1' and t.provincetask in ('1','3')";
        List<Map<String, Object>> prolist = this.getDatas(tablecode, wheresql, " order by update_time");
        if (prolist.size() == 0) {
            return;
        }
        List<String> uplist = new ArrayList<>();
        prolist.stream().forEach( map->{
            String guid = (String)map.get("guid");
            uplist.add(guid);
            delguids.remove(guid);
        });
        //对同时下达一般、重点的进行更新
        if (prolist != null && prolist.size() > 0) {
            String updatesql = "update " + tablecode + " t set ";
            if ((pagetype != null && "dept".equals(pagetype))) {//部门菜单
                updatesql += " t.depttask='2' ";
            } else if (pagetype != null && "province".equals(pagetype)){//财政菜单
                updatesql += " t.provincetask='2' ";
                if ("protrace".equals(tasktype)) {
                    String upcols = "perf_type_code='1', perf_type_name='" + this.PERF_TYPE_DEPTNAME + "' ,update_time='" + PerfUtil.getServerTimeStamp() + "'";
                    String sql = "update " + this.PERF_TABLE_MANAGE_TASK + " t set " + upcols + " where perf_task_id in('" + guids + "')";
                    //同步修改规范表
                    this.update(sql);
                    //同步修改指标表状态，暂时注释
                    sql = " update " + this.PERF_TABLE_MONITOR_INFO + " t set " + upcols + " where perf_task_id in('" + guids + "')";
                    this.update(sql);
                }
            }
            guids = uplist.stream().collect(Collectors.joining(",")).replace(",","','");
            updatesql += ",update_time='" + PerfUtil.getServerTimeStamp() + "' where guid in('" + guids + "')";
            this.update(updatesql);
        }
    }

    /**
     * 根据业务类型查询任务.
     * @param taskguid --任务guid
     * @return
     */
    public List<Map<String, Object>> getTaskByBusType(String taskguid) {
        String sql = " select t.guid itemid,t.name,'0' code,'1' levelno,'1' isleaf,'0' superitemid from " + PMKPI_TABLE_T_TAKSSET + " t where t.tasktype in (select a.tasktype from " + PMKPI_TABLE_T_TAKSSET + " a where a.guid='" + taskguid + "') and t.guid != '" + taskguid + "'";
        return this.queryForList(sql);
    }

    /**
     * 获取选中任务已纳入项目
     *
     * @param datarule --数据权限sql
     * @param seltaskguid --选中的复制任务guid
     * @param pagetype --类型
     * @param taskguid --任务guid
     * @param tablecode --任务类型
     * @return
     */
    public List<Map<String, Object>> getProgram(String seltaskguid, String pagetype, String taskguid, String tasktype, String datarule, String tablecode) {
        String wheresql = "";
        if (!PerfUtil.getTraceManageKeynote() && "dept".equals(pagetype)) {//部门菜单
            wheresql = " depttask='1' ";
        } else if (!PerfUtil.getTraceManageKeynote() && "province".equals(pagetype)) {//财政菜单
            wheresql = " provincetask='1' ";
        }
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where exists(select 1 from (select * from ");
        sql.append(this.PERF_TABLE_TRACEMANAGE).append(" c where not exists(select * from ");
        sql.append(this.PERF_TABLE_TRACEMANAGE).append(" b where b.taskguid='").append(taskguid).append("'");
        if (!StringUtil.isEmpty(wheresql)) {
            sql.append(" and ").append(wheresql);
        }
        if (PerfUtil.getIsHbei() || "depttrace".equals(tasktype)) {
            sql.append(" and c.proguid=b.proguid ");
        } else {
            sql.append(" and c.pro_code=b.pro_code ");
        }
        sql.append(")) a where a.taskguid='").append(seltaskguid).append("'");
        if (!StringUtil.isEmpty(wheresql)) {
            sql.append(" and ").append(wheresql);
        }
        if (PerfUtil.getIsHbei() || "depttrace".equals(tasktype)) {
            sql.append(" and t.guid=a.proguid ");
        } else {
            sql.append(" and t.pro_code=a.pro_code ");
        }
        sql.append(" ) and ").append(datarule);
        return this.queryForList(sql.toString());
    }

}
