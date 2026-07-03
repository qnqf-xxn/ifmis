package gov.mof.fasp2.pmkpi.perfprotrace.manage;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ProTraceManageBO extends PmkpiBO {
    private ProTraceManageDAO proTraceManageDAO;

    public void setProTraceManageDAO(ProTraceManageDAO proTraceManageDAO) {
        this.proTraceManageDAO = proTraceManageDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        List<Map<String, Object>> data = null;
        String wheresql = (String) params.get("querySql");
        String isleaf = (String)params.get("isleaf");
        String orderby = (String) params.get("orderby");
        String tablecode = (String) params.get("tablecode");
        String tabfilter = (String) params.get("tablesql");
        String treeid = (String) params.get("treeid");
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t ");
        StringBuffer wsql = new StringBuffer();
        if (!StringUtil.isEmpty(wheresql)) {
            wsql.append(wheresql).append(" and ");
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            wsql.append(tabfilter).append(" and ");
        }
        if (!"treeroot".equals(treeid)) {
            if ("1".equals(isleaf)) {
                wsql.append(" t.tasktype='").append(treeid).append("' and ");
            } else {
                wsql.append(" t.bustype='").append(treeid).append("' and ");
            }
        }
        if (!StringUtil.isEmpty(wsql.toString())) {
            sql.append(" where ").append(wsql.delete(wsql.length() - 4, wsql.length()));
        }
        if (!StringUtil.isEmpty(orderby)) {
            sql.append(" ").append(orderby);
        }
        data = proTraceManageDAO.queryForList(sql.toString());
        backMap.put("data", data);
        return backMap;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tablesql");
        String menuid = (String) sqlmap.get("menuid");
        String pagetype = (String) sqlmap.get("pagetype");
        String tabcode = (String) sqlmap.get("tabcode");
        String taskguid = (String) sqlmap.get("taskguid");
        String tasktype = (String) sqlmap.get("tasktype");
        String isleaf = (String) sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String) sqlmap.get("saveAgency"); //节点id.
        String taskstage = (String) sqlmap.get("taskstage"); //任务阶段
        StringBuffer sql = null;
        String tabwheresql = "";
        String tablecols = "";
        if (PerfUtil.getIsHbei() || "depttrace".equals(tasktype)) {
            if ("waitaudit".equals(tabcode)) {//待纳入
                tabwheresql = " a.proguid=t.guid ";
            } else {
                tabwheresql = " t.proguid=a.guid ";
            }
        } else {
            tabwheresql = " a.pro_code=t.pro_code ";
        }
        if ("protrace".equals(tasktype)) {
            if (!"waitaudit".equals(tabcode)) {//待纳入
                tablecols = " ,t.pro_code as procode, nvl(t.name, a.pro_name) as proname";
            }
        }
        if ("waitaudit".equals(tabcode)) {//待纳入
            if(PerfUtil.getIS_HUBEI()){
                proTraceManageDAO.execute("select PERF_FUNDPAY_VIEW.set_month('"+taskstage+"') from dual");
            }
            sql = new StringBuffer("select t.* ").append(tablecols).append(" from ");
            sql.append(tablecode).append(" t left join ").append(proTraceManageDAO.PERF_TABLE_TRACEMANAGE).append(" a on ").append(tabwheresql).append(" and ");
            sql.append(" a.taskguid='").append(taskguid).append("' ");
            if(PerfUtil.getDismodel() && "dept".equals(pagetype)){
                sql.append(" and type = 'dept' ");
            } else if(PerfUtil.getDismodel() && "province".equals(pagetype)){
                sql.append(" and type = 'province' ");
            }
        } else {//已纳入
            if ("protrace".equals(tasktype)) {
                sql = new StringBuffer(" select t.*, t.guid as traceguid,a.pro_cat_code ").append(tablecols).append(" from ").append(proTraceManageDAO.PERF_TABLE_TRACEMANAGE).append(" t ");
                sql.append(" left join ").append(proTraceManageDAO.PMKPI_TABLE_PROJECT_INFO).append(" a on ").append(tabwheresql).append(" where ");
            } else {
                sql = new StringBuffer(" select t.*, t.guid as traceguid ").append(tablecols).append(" from ").append(proTraceManageDAO.PERF_TABLE_TRACEMANAGE).append(" t where ");
            }
            if (!PerfUtil.getTraceManageKeynote()) {
                if(PerfUtil.getDismodel() && "dept".equals(pagetype)){
                    sql.append(" type = 'dept' and ");
                } else if(PerfUtil.getDismodel() && "province".equals(pagetype)){
                    sql.append(" type = 'province' and ");
                }
            }
        }
        if ("waitaudit".equals(tabcode)) { //已纳入不走列表条件
            sql.append(" where perf_fundpay_view.set_month('").append(taskstage).append("') = '").append(taskstage).append("' and ");
            if (!StringUtil.isEmpty(tabfilter)) {
                sql.append(tabfilter).append(" and ");
            }
        } else {
            sql.append(" taskguid='").append(taskguid).append("' and ");
        }
        if (!StringUtil.isEmpty(wheresql)) {
            wheresql = PerfUtil.replaceAllIgnoreCase(wheresql, "pro_code", "t.pro_code");
            wheresql = PerfUtil.replaceAllIgnoreCase(wheresql, "pro_total_amt", "t.pro_total_amt");
            wheresql = PerfUtil.replaceAllIgnoreCase(wheresql, "bgtamt", "t.bgtamt");
            wheresql = PerfUtil.replaceAllIgnoreCase(wheresql, "pro_lev", "t.pro_lev");
            wheresql = PerfUtil.replaceAllIgnoreCase(wheresql, "procode", "t.pro_code");
            wheresql = PerfUtil.replaceAllIgnoreCase(wheresql, "proname", "pro_name");
            wheresql = PerfUtil.replaceAllIgnoreCase(wheresql, "agencyguid", "t.agencyguid");
            if ("depttrace".equals(tasktype) && !wheresql.contains("FASP_T_PUBDEPARTMENT")){
                wheresql = PerfUtil.replaceAllIgnoreCase(wheresql, "name","t.name");
            }
            //重点监控  已纳入页签
            if ("depttrace".equals(tasktype) && "alreadyaudit".equals(tabcode)) {
                wheresql = PerfUtil.replaceAllIgnoreCase(wheresql, "code", "t.agency_code");
            }
            if ("alreadyaudit".equals(tabcode)) {// 已纳入的pro_cat_code要从a表拿
                wheresql = PerfUtil.replaceAllIgnoreCase(wheresql, "t.pro_cat_code", "a.pro_cat_code");
            }
            sql.append(" (").append(wheresql).append(")  and ");
        }
        if ("dept".equals(pagetype)) {//一般监控
            if ("waitaudit".equals(tabcode)) {//未纳入
                sql.append(" (depttask = '2' or depttask is null) and ");
            } else if (!PerfUtil.getTraceManageKeynote()){
                sql.append(" depttask = '1' and ");
            }
        } else if ("province".equals(pagetype)) {//重点监控
            if ("waitaudit".equals(tabcode)) {//未纳入
                sql.append(" (provincetask = '2' or provincetask is null) and ");
            } else if (!PerfUtil.getTraceManageKeynote()){
                sql.append(" provincetask in ('1','3') and "); //山西多了一个下发流程状态
            }
        }
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1");
        sql.append(datarule);
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, proTraceManageDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }

    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIPERFTASK", "");
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("name", "任务类型");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", eledatas);
        leftconfig.put("outformart", "#name");
        leftconfig.put("expandlevel", 2);
        return leftconfig;
    }

    /**
     * 获取任务布置页面左侧树.
     * @return
     * @throws AppException
     */
    public Map<String, Object> getLeftData() {
        Map leftconfig = new HashMap();
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", new ArrayList<>());
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        return leftconfig;
    }

    /**
     * 获取任务布置页面左侧树数据
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap params) throws AppException {
        String menuid = (String) params.get("menuid");
        String taskstage = (String) params.get("taskstage");
        String tabfilter = (String) params.get("tabfilter");
        String tabcode = (String) params.get("tabcode");
        String taskguid = (String) params.get("taskguid");
        String pagetype = (String) params.get("pagetype");
        String datarule = getDataRuleByMenuguidNull(menuid, "t", "1=1");
        StringBuffer wheresql = new StringBuffer();
        wheresql.append(datarule);
        String tablecode = "";
        String wsql = "";
        if (PerfUtil.getIsHbei()) {
            wsql = " t.guid = a.proguid ";
        } else {
            wsql = " t.pro_code = a.pro_code ";
        }
        if ("waitaudit".equals(tabcode)) {
            if(PerfUtil.getIS_HUBEI()){
                proTraceManageDAO.execute("select PERF_FUNDPAY_VIEW.set_month('"+taskstage+"') from dual");
            }
            tablecode = proTraceManageDAO.PMKPI_TABLE_TRACEPROJECT_CHECK;
            if (!StringUtil.isEmpty(tabfilter)) {
                wheresql.append(" and ").append(tabfilter);
            }
            wheresql.append(" and perf_fundpay_view.set_month('").append(taskstage).append("') = '").append(taskstage).append("'");
            wheresql.append(" and not exists(select 1 from ").append(proTraceManageDAO.PERF_TABLE_TRACEMANAGE).append(" a where ").append(wsql);
            wheresql.append(" and taskguid='").append(taskguid).append("'");
        } else {
            tablecode = proTraceManageDAO.PERF_TABLE_TRACEMANAGE;
            wheresql.append(" and taskguid='").append(taskguid).append("'");
        }
        if ("dept".equals(pagetype)) {//一般监控
            wheresql.append(" and depttask = '1' ");
        } else if ("province".equals(pagetype)) {//重点监控
            wheresql.append(" and provincetask in ('1','3') "); //山西多了一个下发流程状态
        }
        if ("waitaudit".equals(tabcode)) {//未纳入
            wheresql.append(")");
        }
        return proTraceManageDAO.getLeftTree(tablecode, wheresql.toString());
    }

    /**
     * 保存绩效监控
     * @param parms --
     * @return
     */
    public Map<String, Object> save(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> backmap = new HashMap<String, Object>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) parms.get("datas");
        String tablecode = proTraceManageDAO.PERF_TABLE_TRACEMANAGE;
        String taskguid = (String) parms.get("taskguid");
        String pagetype = (String) parms.get("pagetype");
        String tasktype = (String) parms.get("tasktype");
        String taskstage = (String) parms.get("taskstage");
        String tasksname = (String) parms.get("tasksname");
        String tasksenddate = (String) parms.get("tasksenddate");
        List<Map<String, Object>> tasklist = new ArrayList<Map<String, Object>>();
        Map<String, Object> taskMap = null;
        List list = null;
        //对已下达的进行修改
        if ("protrace".equals(tasktype) && !PerfUtil.getIsHbei()) {
            list = new ArrayList();
            for (Map<String, Object> map : datas) {
                Map m = new HashMap();
                m.put("guid", map.get("pro_code"));
                list.add(m);
            }
        } else {
            list = datas;
        }
        //监控任务下发模式 1同阶段不同任务下发一笔监控项目 2同阶段不同任务下发两笔监控项目
        if (!PerfUtil.getDismodel()) {
            proTraceManageDAO.saveAll(list, proTraceManageDAO.PMKPI_TABLE_TMP_GUIDS);
            proTraceManageDAO.updateTasktype(tablecode, pagetype, taskguid, tasktype, datas);
        }
        if (datas.size() > 0) {
            for (Map<String, Object> map : datas) {
                String newguid = this.getCreateguid();
                String mainproguid = (String) map.get("guid");
                taskMap = new HashMap<String, Object>();
                taskMap.put("guid", newguid);
                taskMap.put("creater", SecureUtil.getCurrentUserID());
                taskMap.put("perf_task_id", taskMap.get("guid"));
                taskMap.put("perf_task_no", taskstage);
                taskMap.put("perf_task_title", tasksname);
                taskMap.put("perf_task_dsec", tasksname);
                taskMap.put("task_end_date", tasksenddate);
                taskMap.put("is_last_inst", 2);
                taskMap.put("is_deleted", 2);
                if ("protrace".equals(tasktype)) {
                    String name = (String) (StringUtil.isEmpty((String) map.get("pro_name")) ? map.get("name") : map.get("pro_name"));
                    taskMap.put("agencyguid", map.get("agency_code"));
                    taskMap.put("name", name);
                    taskMap.put("finintorgguid", map.get("mof_dep_code"));
                    taskMap.put("pro_name", name);
                    taskMap.put("pro_total_amt", map.get("pro_total_amt"));
                } else if ("depttrace".equals(tasktype)) {
                    taskMap.put("agencyguid", map.get("agencyguid"));
                    taskMap.put("name", map.get("name"));
                    taskMap.put("finintorgguid",map.get("finintorgguid"));
                } else if ("policytrace".equals(tasktype)) { //重大政策

                }
                taskMap.put("agency_code", taskMap.get("agencyguid"));
                taskMap.put("proguid", mainproguid);
                taskMap.put("status", 1);
                taskMap.put("taskguid", taskguid);
                taskMap.put("tracestatus", "1"); //已下达
                taskMap.put("islast", "1"); //标记最后一次
                if (!PerfUtil.getDismodel()) {
                    taskMap.put("depttask", map.get("depttask"));
                    taskMap.put("provincetask", map.get("provincetask"));
                } else{
                    taskMap.put("depttask", "2");
                    taskMap.put("provincetask", "2");
                }
                taskMap.put("pro_code", map.get("pro_code"));
                taskMap.put("manage_dept_code", map.get("manage_dept_code"));
                taskMap.put("manage_mof_dep_code", map.get("manage_mof_dep_code"));
                taskMap.put("mof_dep_code", map.get("mof_dep_code"));
                taskMap.put("dept_code", map.get("dept_code"));
                taskMap.put("projectkind",map.get("projectkind"));  //支出项目类别
                taskMap.put("pro_levone_code",map.get("pro_levone_code"));  //专项资金、一级项目编码
                taskMap.put("pro_lev",map.get("pro_lev"));
                taskMap.put("v_colk1",map.get("v_colk1"));
                taskMap.put("v_colk2",map.get("v_colk2"));
                taskMap.put("v_colk3",map.get("v_colk3"));
                taskMap.put("v_colk4",map.get("v_colk4"));
                taskMap.put("v_colk5",map.get("v_colk5"));
                String depttask = (String) taskMap.get("depttask");
                String provincetask = (String) taskMap.get("provincetask");
                if (StringUtil.isEmpty(depttask)) {
                    taskMap.put("depttask", "2");
                }
                if (StringUtil.isEmpty(provincetask)) {
                    taskMap.put("provincetask", "2");
                }
                if ("dept".equals(pagetype)) { //部门下达 1是2否
                    taskMap.put("depttask", "1");
                    taskMap.put("type", "dept");
                } else if ("province".equals(pagetype)) { //财政下达 1是2否3山西是
                    if (PerfUtil.getIsSx() && "protrace".equals(tasktype)) {
                        taskMap.put("provincetask", "3"); //山西改为3，增加了部门重点监控下发流程
                    } else {
                        taskMap.put("provincetask", "1");
                        taskMap.put("type", "province");
                    }
                }
                //既是一般又是重点，按重点监控
                if ("1".equals(taskMap.get("provincetask")) || "3".equals(taskMap.get("provincetask"))) {
                    taskMap.put("perf_type_code", "2");
                    taskMap.put("perf_type_name", proTraceManageDAO.PERF_TYPE_PROVINCENAME);
                } else {
                    taskMap.put("perf_type_code", "1");
                    taskMap.put("perf_type_name", proTraceManageDAO.PERF_TYPE_DEPTNAME);
                }
                this.getBasMap(taskMap,"add");
                int tracenum = this.mapGetInt(map, "tracenum") + 1;
                taskMap.put("tracenum", tracenum); //最后一次+1
                tasklist.add(taskMap);
            }
            proTraceManageDAO.saveAll(tasklist, tablecode);
            //项目支出同步保存到规范表
            if ("protrace".equals(tasktype)) {
                proTraceManageDAO.saveAll(tasklist, proTraceManageDAO.PERF_TABLE_MANAGE_TASK);
            }
            String isSx = PerfUtil.getSystemSet("isSX");
            if (!StringUtil.isEmpty(isSx) && "1".equals(isSx)) {//山西环境纳入数据时进入流程
                String workflow = "";
                if ("protrace".equals(tasktype)) {
                    workflow = "B7279B405D487EB4E0530100007FD738";
                } else if ("depttrace".equals(tasktype)) {
                    workflow = "BBC491112EDB3877E053B11FA8C041AA";
                } else if ("policytrace".equals(tasktype)) { //重大政策

                }
                StringBuffer sql = new StringBuffer("guid in (");
                for(int i = 0;i < tasklist.size();i++){
                    Map map = tasklist.get(i);
                    if (i < tasklist.size() - 1) {
                        sql.append("'").append(map.get("guid")).append("'").append(", ");
                    } else {
                        sql.append("'").append(map.get("guid")).append("'");
                    }
                }
                sql.append(")");
                List<Map<String, Object>> l = this.getDatas(tablecode,sql.toString(),null);
                this.workflow("createnosave", workflow, "", proTraceManageDAO.PERF_TABLE_TRACEMANAGE, l);
            }
        }
        backmap.put("flg","1");
        return backmap;
    }

    /**
     * 字符数字转换.
     * @param map -- map.
     * @param col -- 字段.
     * @return int.
     * @throws
     */
    public int mapGetInt(Map<String, Object> map, String col) {
        Object o = map.get(col);
        if (o == null) {
            return 0;
        }
        return Integer.parseInt(o.toString());
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) throws AppException{
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("datas");
        String tablecode = proTraceManageDAO.PERF_TABLE_TRACEMANAGE;
        String pagetype = (String) parms.get("pagetype");
        String tasktype = (String) parms.get("tasktype");
        String btntype = (String) parms.get("btntype");//取消标记重点项目
        List<String> deltables = (List<String>) parms.get("deltables");
        List<String> delcols = (List<String>) parms.get("delcols");
        List<String> delguids = new ArrayList<>();
        List<String> procodes = new ArrayList<>();
        for (Map<String, Object> map : deldatas) {
            //一般监控标记重点项目时，取消任务下达，同步删除重点标记的项目
            if (PerfUtil.getTraceManageKeynote() && PerfUtil.getDismodel() && !"province".equals(btntype)) {
                procodes.add((String) map.get("pro_code"));
            }
            delguids.add((String) map.get("traceguid"));
        }
        if (procodes.size() > 0) {
            List<Map<String, Object>> datas = this.getProDatas(parms);
            for (Map<String, Object> map : datas) {
                delguids.add((String) map.get("guid"));
            }
        }
        if (delguids.size() > 0) {
            //对同时下达部门，财政的项目进行处理和过滤
            if (!PerfUtil.getDismodel() && !"deltask".equals(btntype)) {
                proTraceManageDAO.del(tablecode, tasktype, pagetype, delguids);
            }
            //删除单个财政/部门下达的数据
            if (delguids != null && delguids.size() > 0) {
                String delsql = proTraceManageDAO.createInSql("guid", delguids);
                if (!PerfUtil.getTraceManageKeynote()) {
                    if (PerfUtil.getDismodel() && "province".equals(pagetype)) {
                        delsql += " and depttask = '2' and provincetask = '1' ";
                    } else if(PerfUtil.getDismodel() && "dept".equals(pagetype)) {
                        delsql += " and depttask = '1' and provincetask = '2' ";
                    }
                }
                proTraceManageDAO.delDatas(tablecode, delsql);
                if (deltables != null && deltables.size() > 0) {
                    String col = "mainguid";
                    int j = 0;
                    for (String deltable : deltables) {
                        if (delcols != null && delcols.size() > 0) {
                            col = delcols.get(j);
                        }
                        delsql = proTraceManageDAO.createInSql(col, delguids);
                        proTraceManageDAO.delDatas(deltable, delsql);
                        j++;
                    }
                }
                //假删除规范表数据
                if ("protrace".equals(tasktype)) {
                    delsql = proTraceManageDAO.createInSql("perf_task_id", delguids);
                    //删除规范表数据
                    proTraceManageDAO.updateIsDeleteDatas(proTraceManageDAO.PERF_TABLE_MANAGE_TASK, delsql);
                    proTraceManageDAO.updateIsDeleteDatas(proTraceManageDAO.PERF_TABLE_MONITOR_INFO, delsql);
                }
                //删除对应的暂存数据
                delsql = proTraceManageDAO.createInSql("mainguid", delguids);
                Map delparams = new HashMap();
                delparams.put("delsql", delsql);
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                perfMidsaveBO.delData(delparams);
            }
        }
        backMap.put("flg","1");
        return backMap;
    }

    /**
     * 根据业务类型查询任务.
     * @param taskguid --任务guid
     * @return
     */
    public List<Map<String, Object>> getTaskByBusType(String taskguid) {
        return proTraceManageDAO.getTaskByBusType(taskguid);
    }

    /**
     * 复制任务.
     * @param parms --
     * @return
     * @throws AppException
     */
    public Map<String, Object> taskCopy(HashMap<String, Object> parms) throws AppException {
        String taskguid = (String) parms.get("taskguid");
        String pagetype = (String) parms.get("pagetype");
        String seltaskguid = (String) parms.get("seltaskguid");
        String menuid = (String) parms.get("menuid");
        String tablecode = (String) parms.get("tablecode");
        String tasktype = (String) parms.get("tasktype");
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1");
        List<Map<String, Object>> datas = proTraceManageDAO.getProgram(seltaskguid, pagetype, taskguid, tasktype, datarule, tablecode);
        parms.put("datas", datas);
        return this.save(parms);
    }

    /**
     * 校验项目是否可取消任务
     * @param parms --
     * @return
     */
    public int checkdeltask(HashMap<String, Object> parms) {
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        try {
            proTraceManageDAO.saveAll(deldatas, proTraceManageDAO.PMKPI_TABLE_TMP_GUIDS);
            //添加校验wfstats可删除
            String delsql = " exists(select 1 from " + proTraceManageDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.taskguid) ";
            return proTraceManageDAO.getDataCount(proTraceManageDAO.PERF_TABLE_TRACEMANAGE, delsql);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return 0;
    }

    public List<Map<String, Object>> getProDatas(HashMap<String, Object> params) {
        String taskguid = (String) params.get("taskguid");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<String> procodes = new ArrayList<>();
        for (Map<String, Object> map : datas) {
            procodes.add((String) map.get("pro_code"));
        }
        String wheresql = proTraceManageDAO.createInSql("pro_code", procodes);
        wheresql += " and taskguid=? and type='province'";
        return proTraceManageDAO.getDatas(proTraceManageDAO.PERF_TABLE_TRACEMANAGE, wheresql, null, new String[]{taskguid});
    }
}
