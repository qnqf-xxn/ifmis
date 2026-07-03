package gov.mof.fasp2.pmkpi.adjust.audit;

import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.client.RestTemplate;

import java.text.DecimalFormat;
import java.util.*;
import java.util.stream.Collectors;

public class AdjustAuditBO extends PmkpiBO {
    private AdjustAuditDAO adjustAuditDAO;

    public void setAdjustAuditDAO(AdjustAuditDAO adjustAuditDAO) {
        this.adjustAuditDAO = adjustAuditDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tabfilter1 = (String) sqlmap.get("tabfilter1"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        StringBuffer returnsql = new StringBuffer("select t.* from ").append(tablecode).append(" t ");
        returnsql.append(" where bustype='").append(lefttabtype).append("'");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (wheresql != null && ! wheresql.isEmpty()){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && ! tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter1 != null && ! tabfilter1.isEmpty()){
            returnsql.append(" and ").append(tabfilter1);
        }
        if (tabfilter != null && ! tabfilter.isEmpty()){
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && ! wfsql.isEmpty()) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, adjustAuditDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        return returnsql.toString();
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = "v_perf_t_adjust";
        String lefttabtype = (String) params.get("lefttabtype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype='" + lefttabtype + "' ";
        return adjustAuditDAO.getLeftTree(tablecode, datarule);
    }


    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String bustype = (String) params.get("bustype"); //项目编码
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String goaltablecode = "";
        String indextablecode = "";
        String wheresql = "";
        String busguid = (String) params.get("busguid");
        if (bustype != null && "program".equals(bustype)) {
            goaltablecode = "v_pm_perf_goal_info";
            indextablecode = "v_pm_perf_indicator";
        } else if (bustype != null && "dept".equals(bustype)) {
            goaltablecode = "v_bgt_perf_goal_info";
            indextablecode = "v_bgt_perf_indicator";
        }
        if ("audit".equals(actioncode) || "auditbatch".equals(actioncode)) {
            this.wfAuditbatch(datas,params);
        } else {
            if ("cancelaudit".equals(actioncode)) {//取消审核，申报数据是否终审改为不必填
                List<String> guids = new ArrayList<>();
                for (Map<String, Object> data : datas){
                    String wfstatus = (String) data.get("wfstatus");
                    if("011".equals(wfstatus)){
                        if (PerfUtil.getIsHbei() || "dept".equals(bustype)) {
                            guids.add((String) data.get("proguid"));
                        }else{
                            guids.add((String) data.get("pro_code"));
                        }
                    }
                }
                if (guids.size() > 0) {
                    String upsql = " is_last_inst = 2 ";
                    String keycol = "";
                    wheresql = " is_last_inst = 1 ";
                    if ("program".equals(bustype)) {
                        wheresql += " and yearflag = '0' ";
                    }
                    if (PerfUtil.getIsHbei() || "dept".equals(bustype)) {
                        keycol = "mainguid";
                    }else{
                        keycol = "pro_code";
                    }
                    if (guids.size() > 0) {//更新规范表数据为终审
                        adjustAuditDAO.updateAllByColumn(keycol, guids, goaltablecode, upsql, null);
                        adjustAuditDAO.updateAllByColumn(keycol, guids, indextablecode, upsql, wheresql);
                    }
                }
            }
            this.workflow(actioncode, workflow, remark, "v_perf_t_adjust", datas);
        }
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    public void wfAuditbatch(List<Map<String, Object>> datas, HashMap<String, Object> params) throws AppException {
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String goaltablecode = "";
        String indextablecode = "";
        String wheresql = "";
        List<String> maingList = new ArrayList<>();
        List<String> proguidList = new ArrayList<>();
        List<String> procodeList = new ArrayList<>();
        this.workflow(actioncode, workflow, remark, "v_perf_t_adjust", datas);
        for (Map<String, Object> data : datas) {
            maingList.add((String) data.get("guid"));
            proguidList.add((String) data.get("proguid"));
            procodeList.add((String) data.get("pro_code"));
        }
        Map<String, Object> auditMap = new HashMap<>();
        String ids = "";
        for (Map<String, Object> data : datas) {
            ids = (String) data.get("guid");
            auditMap.put(ids, data);
        }
        String wfstatus = (String) datas.get(0).get("wfstatus");
        if (wfstatus != null && "011".equals(wfstatus)) {
            String isNoticeOA = PerfUtil.getSystemSet("isNoticeOA"); //是否更新通知OA参数，默认0关闭，开启需要配置成接口的url
            if(isNoticeOA != null && !"0".equals(isNoticeOA)){
                this.sendProInfo2OA(isNoticeOA,adjustAuditDAO.createInSql("pro_code", procodeList));
            }
            wheresql = adjustAuditDAO.createInSql("mainguid", maingList);
            wheresql += " and nvl(status,4) <> 1 ";
            String ordersql = "order by update_time";
            if(PerfUtil.getIS_HUBEI()){
                ordersql = "order by mainguid,ordernum";
            }
            List<Map<String, Object>> goaldata = adjustAuditDAO.getDatas("v_perf_t_adjustallgoal", wheresql, ordersql);
            List<Map<String, Object>> indexdata = adjustAuditDAO.getDatas("v_perf_t_adjustallindex", wheresql, ordersql);
            String bustype = (String) datas.get(0).get("bustype");
            String frametype = "";
            if (bustype != null && "program".equals(bustype)) {
                goaltablecode = PerfConstant.PMKPI_BACKUP_GOAL_INFO;
                indextablecode = PerfConstant.PMKPI_BACKUP_INDICATOR;
                frametype = "PM001";
            } else if (bustype != null && "dept".equals(bustype)) {
                goaltablecode = PerfConstant.BGT_V_TABLE_GOAL;
                indextablecode = PerfConstant.BGT_V_TABLE_INDICATOR;
                frametype = "DEPT";
            }

            //对项目指标目标进行替换
            Map<String, Object> objectMap = null;
            String date = PerfUtil.getServerTimeStamp();
            String mainguid = "";
            HashMap<String,String> goalguidMap = new HashMap<String,String>(); //记录
            HashMap<String,Integer> goalnumMap = new HashMap<String,Integer>(); //记录更新目标名称
            String yearflag = "";
            String goalnumkey = "";
            String goalproguid = "";
            int k = 1;
            List<String> goalpros = new ArrayList<>(); //目标涉及的项目信息
            List<String> indexpros = new ArrayList(); //指标涉及的项目信息
            List<String> goalcodepros = new ArrayList<>(); //目标涉及的项目信息
            List<String> indexcodepros = new ArrayList(); //指标涉及的项目信息
            for (Map<String, Object> goal : goaldata) {
                mainguid = (String) goal.get("mainguid");
                String adjustndgoal = (String) goal.get("adjustndgoal");
                objectMap = (Map<String, Object>) auditMap.get(mainguid);
                if (!StringUtil.isNullOrEmpty(adjustndgoal)) {
                    goal.put("kpi_target", adjustndgoal);
                    goal.put("ndgoal", adjustndgoal);
                }
                String newguid = this.getCreateguid();
                if (!goalpros.contains(goal.get("proguid"))){
                    goalpros.add((String)goal.get("proguid"));
                }
                if (!goalcodepros.contains(goal.get("pro_code"))){
                    goalcodepros.add((String)goal.get("pro_code"));
                }
                if(PerfUtil.getIS_HUBEI()){//湖北模式
                    String oldgoalguid = (String) goal.get("guid");
                    goalguidMap.put(oldgoalguid,newguid);
                    goalproguid = (String) goal.get("proguid"); //项目id
                    yearflag = (String) goal.get("yearflag");
                    goalnumkey =  goalproguid+"#"+yearflag;
                    if (goalnumMap.containsKey(goalnumkey)){
                        k = goalnumMap.get(goalnumkey);
                    } else {
                        k = 0;
                    }
                    if ("1".equals(yearflag)){ //中长期
                        goal.put("goalname", "长期目标"+(k+1));
                        goal.put("yearflag", 1);
                    } else {
                        goal.put("goalname", "年度目标"+(k+1));
                        goal.put("yearflag", 0);
                    }
                    goalnumMap.put(goalnumkey,k+1);
                } else {
                    goal.put("yearflag", 0);
                }
                goal.put("pro_code", objectMap.get("pro_code"));
                goal.put("guid", newguid);
                goal.put("status", "");
                this.setData(goal);
            }
            for (Map<String, Object> index : indexdata) {
                mainguid = (String) index.get("mainguid");
                String adjustindexval = (String) index.get("adjustindexval");
                Object adjustweight = index.get("adjustweight");
                objectMap = (Map<String, Object>) auditMap.get(mainguid);
                if (!StringUtil.isNullOrEmpty(adjustindexval)) {
                    index.put("indexval", index.get("adjustindexval"));
                    index.put("kpi_val", index.get("adjustindexval"));
                }
                if (adjustweight !=null){
                    double b = Double.valueOf(String.valueOf(adjustweight));
                    DecimalFormat df = new DecimalFormat("#.00");
                    String temp = df.format(b);
                    index.put("weight", temp);
                }
                if (!indexpros.contains(index.get("proguid"))){
                    indexpros.add((String)index.get("proguid"));
                }
                if (!indexcodepros.contains(index.get("pro_code"))){
                    indexcodepros.add((String)index.get("pro_code"));
                }
                if(PerfUtil.getIS_HUBEI()){
                    String oldgoalguid = (String) index.get("goalguid");
                    if (oldgoalguid != null && ! oldgoalguid.isEmpty()) {
                        String newGoalguid = goalguidMap.get(oldgoalguid);
                        index.put("goalguid", newGoalguid);
                    }
                    yearflag = (String) index.get("yearflag");
                    if ("1".equals(yearflag)){ //中长期
                        index.put("yearflag", 1);
                    } else {
                        index.put("yearflag", 0);
                    }
                } else {
                    index.put("yearflag", 0);
                }
                String newguid = this.getCreateguid();
                index.put("guid", newguid);
                index.put("pro_code", objectMap.get("pro_code"));
                this.setData(index);
                String status = index.get("status") + "";
                if (status != null && "1".equals(status)) {
                    index.put("is_deleted", "1");
                }
                index.put("status", "");
            }
            StringBuffer delsql = null;
            String upsql = " is_deleted=1";
            if ("program".equals(bustype)) {
                upsql += ",fromguid=null ";
            }
            if (goaldata != null && goaldata.size() > 0) {
                delsql = new StringBuffer();
                if (PerfUtil.getIsHbei() || "dept".equals(bustype)) {
                    delsql.append(adjustAuditDAO.createInSql("mainguid", goalpros));
                } else {
                    delsql.append("(");
                    List<Map<String, Object>> goalList = null;
                    for (String procode : goalcodepros) {
                        goalList = goaldata.stream().filter(m-> procode.equals(m.get("pro_code"))).collect(Collectors.toList());
                        if (delsql.length() > 1) {
                            delsql.append(" or ");
                        }
                        delsql.append("(pro_code='").append(procode).append("' and (sub_mof_div_code is null").append("");
                        HashSet<String> indexsubs = new HashSet<>();
                        goalList.stream().forEach(m->
                                indexsubs.add((String) m.get("sub_mof_div_code"))
                        );
                        for (String submofdivcode : indexsubs) {
                            if (!StringUtil.isNullOrEmpty(submofdivcode)) {
                                int j = goalList.stream().filter(m-> submofdivcode.equals(m.get("sub_mof_div_code"))).collect(Collectors.toList()).size();
                                if (j > 0) {
                                    delsql.append(" or sub_mof_div_code='").append(submofdivcode).append("'");
                                }
                            }
                        }
                        delsql.append("))");
                    }
                    delsql.append(")");
                }
                if ("program".equals(bustype) || PerfUtil.getIS_HUBEI()) {
                    delsql.append(" and yearflag = '0'");
                }
                //追加逻辑判断部门整体申报数据是否存在批复终审is_last_inst=1 根据申报数据重新赋值(20240411)
                int is_last_inst = 2;
                delsql.append(PerfUtil.yearProvinceSql("t")).append(" and is_backup=2 ");
                List<Map<String, Object>> querygoaldata = adjustAuditDAO.getDatas(goaltablecode, delsql + " and is_last_inst=1 and is_deleted=2", null);
                if(querygoaldata.size()>0){
                    is_last_inst = 1;
                }
                int finalIs_last_inst = is_last_inst;
                goaldata.forEach(e -> {e.put("is_last_inst", finalIs_last_inst);});
                if ("dept".equals(bustype)) {
                    delsql.append(" and is_deleted=2");
                } else {
                    delsql.append(" and (is_deleted=2 or (is_deleted = 1 and fromguid is not null))");
                }
                adjustAuditDAO.updateAllByColumn(null, null, goaltablecode, upsql, delsql.toString());
                adjustAuditDAO.saveAll(goaldata, goaltablecode);
            }
            if (indexdata != null && indexdata.size() > 0) {
                delsql = new StringBuffer();
                if (PerfUtil.getIsHbei() || "dept".equals(bustype)) {
                    delsql.append(adjustAuditDAO.createInSql("mainguid", indexpros));
                } else {
                    delsql.append("(");
                    List<Map<String, Object>> indexList = null;
                    for (String procode : goalcodepros) {
                        indexList = indexdata.stream().filter(m-> procode.equals(m.get("pro_code"))).collect(Collectors.toList());
                        if (delsql.length() > 1) {
                            delsql.append(" or ");
                        }
                        delsql.append("(pro_code='").append(procode).append("' and (sub_mof_div_code is null").append("");
                        HashSet<String> indexsubs = new HashSet<>();
                        indexList.stream().forEach(m->
                                indexsubs.add((String) m.get("sub_mof_div_code"))
                        );
                        for (String submofdivcode : indexsubs) {
                            if (!StringUtil.isNullOrEmpty(submofdivcode)) {
                                int j = indexList.stream().filter(m-> submofdivcode.equals(m.get("sub_mof_div_code"))).collect(Collectors.toList()).size();
                                if (j > 0) {
                                    delsql.append(" or sub_mof_div_code='").append(submofdivcode).append("'");
                                }
                            }
                        }
                        delsql.append("))");
                    }
                    delsql.append(")");
                }
                if ("program".equals(bustype) || PerfUtil.getIS_HUBEI()) {
                    delsql.append(" and yearflag = '0'");
                }
                //追加逻辑判断部门整体申报数据是否存在批复终审is_last_inst=1 根据申报数据重新赋值 (20240411)
                int is_last_inst = 2;
                delsql.append(PerfUtil.yearProvinceSql("t")).append(" and is_backup=2 ");
                List<Map<String, Object>> queryindexdata = adjustAuditDAO.getDatas(indextablecode, delsql + " and is_last_inst=1 and is_deleted=2", null);
                if(queryindexdata.size()>0){
                    is_last_inst = 1;
                }
                int finalIs_last_inst = is_last_inst;
                indexdata.forEach(e -> {e.put("is_last_inst", finalIs_last_inst);});
                if ("dept".equals(bustype)) {
                    delsql.append(" and is_deleted=2");
                } else {
                    delsql.append(" and (is_deleted=2 or (is_deleted = 1 and fromguid is not null))");
                }
                //删除项目目标指标数据
                adjustAuditDAO.updateAllByColumn(null, null, indextablecode, upsql, delsql.toString());
                this.setIndexDatas(indexdata, frametype, false);
                adjustAuditDAO.saveAll(indexdata, indextablecode);
            }
            //湖北的部门整体绩效中部门资金和部门基本信息要调整终审替换
            if(PerfUtil.getIS_HUBEI() && "dept".equals(bustype)){
                wheresql = adjustAuditDAO.createInSql("guid", maingList) + " and bustype = 'dept'";
                List<Map<String, Object>> adjinfos = adjustAuditDAO.getDatas("v_perf_t_adjust", wheresql, null);
                wheresql = adjustAuditDAO.createInSql("guid", proguidList);
                List<Map<String, Object>> deptinfos = adjustAuditDAO.getDatas("v_perf_t_deptperfdeclare", wheresql, null);
                if (adjinfos.size() > 0 && deptinfos.size() > 0){
                    String tempproguid = "";
                    String deptguid = "";
                    for (Map map : deptinfos) {
                        deptguid = (String) map.get("guid");
                        for (Map adjmap : adjinfos) {
                            tempproguid = (String) adjmap.get("proguid");
                            if (deptguid.equals(tempproguid)){
                                if (adjmap.get("endyear") != null){
                                    map.put("endyear", adjmap.get("endyear"));
                                }
                                if (adjmap.get("linkman") != null){
                                    map.put("linkman", adjmap.get("linkman"));
                                }
                                if (adjmap.get("telephone") != null){
                                    map.put("telephone", adjmap.get("telephone"));
                                }
                                if (adjmap.get("funcdesc") != null){
                                    map.put("funcdesc", adjmap.get("funcdesc"));
                                }
                                if (adjmap.get("perfgoal") != null){
                                    map.put("perfgoal", adjmap.get("perfgoal"));
                                }
                                break;
                            }
                        }
                        map.put("updatetime", PerfUtil.getServerTimeStamp());
                    };
                    //更新
                    List<String> cols = new ArrayList<String>();
                    cols.add("endyear");
                    cols.add("linkman");
                    cols.add("telephone");
                    cols.add("funcdesc");
                    cols.add("perfgoal");
                    cols.add("updatetime");
                    adjustAuditDAO.updateAll(cols,deptinfos,"v_perf_t_deptperfdeclare");
                }
                wheresql = this.createInSql("mainguid", maingList);
                List<Map<String, Object>> deptamts = adjustAuditDAO.getDatas("v_perf_t_adjdeptamt", wheresql, "order by ordernum");
                if (deptamts.size() > 0){
                    StringBuffer amtmains = new StringBuffer(); //申报资金.
                    deptamts.forEach(r->{
                        r.put("mainguid",r.get("proguid"));
                        r.put("updatetime",PerfUtil.getServerTimeStamp());
                        r.put("createtime",PerfUtil.getServerTimeStamp());
                        amtmains.append(",'").append(r.get("proguid")).append("'");
                    });
                    String delsql1 = " mainguid in (" + amtmains.toString().substring(1) + ")";
                    adjustAuditDAO.updateIsDeleteDatas("V_PERF_T_DEPTAMT", delsql1);
                    adjustAuditDAO.saveAll(deptamts,"V_PERF_T_DEPTAMT");
                }
            }

            //广西部门职能概述页签中的数据调整终审时要替换
            if (PerfUtil.getIsGuangXi() && "dept".equals(bustype)) {
                wheresql = this.createInSql("mainguid", maingList);
                String delsql1 = this.createInSql("mainguid", proguidList);
                List<Map<String, Object>> fundata = adjustAuditDAO.getDatas("v_perf_t_adjustfunction", wheresql, null);
                if (fundata != null && fundata.size() > 0) {
                    for (Map<String, Object> dataMap : fundata) {
                        Map<String, Object> mainMap = (Map<String, Object>) auditMap.get(dataMap.get("mainguid"));
                        dataMap.put("mainguid", mainMap.get("proguid"));
                        dataMap.put("guid",this.getCreateguid());
                        dataMap.put("updatetime",date);
                    }
                    //删除部门职能数据
                    adjustAuditDAO.delDatas("v_perf_t_deptfunction", delsql1);
                    adjustAuditDAO.saveAll(fundata, "v_perf_t_deptfunction");
                }
            }

            //部门整体调整 - 年度任务页签数据终审时替换
            if ("dept".equals(bustype)) {
                wheresql = this.createInSql("mainguid", maingList);
                String delsql1 = this.createInSql("mainguid", proguidList);
                List<Map<String, Object>> taskdatas = adjustAuditDAO.getDatas("v_perf_t_adjdepttask", wheresql, null);
                if (taskdatas != null && taskdatas.size() > 0) {
                    for (Map<String, Object> dataMap : taskdatas) {
                        Map<String, Object> mainMap = (Map<String, Object>) auditMap.get(dataMap.get("mainguid"));
                        dataMap.put("mainguid", mainMap.get("proguid"));
                        dataMap.put("guid",this.getCreateguid());
                        dataMap.put("updatetime",date);
                    }
                    //删除部门职能数据
                    adjustAuditDAO.delDatas("v_perf_t_depttask",delsql1);
                    adjustAuditDAO.saveAll(taskdatas, "v_perf_t_depttask");
                    //部门整体调整终审 - 部门主表金额字段更新
                    String querysql = "select t.tasktoalamt,a.proguid as guid from (select sum(t.totalamt) as tasktoalamt, mainguid as adjguid from v_perf_t_adjdepttask t where " + wheresql + "group by t.mainguid) t left join v_perf_t_adjust a on t.adjguid = a.guid where a.bustype = 'dept'";
                    List<Map<String,Object>> listdata = adjustAuditDAO.queryForList(querysql);
                    List<String> cols = new ArrayList<>();
                    cols.add("tasktoalamt");
                    adjustAuditDAO.updateAll(cols, listdata, "v_perf_t_deptperfdeclare");
                }
            }
        }
    }

    private void setData(Map data){
        data.put("mainguid", data.get("proguid"));
        data.put("is_last_inst", 1);
        data.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
        this.getBasMap(data, "add");
    }

    /**
     * 当年度绩效目标终审（调整终审）时，需按项目编码将绩效目标调用OA系统接口
     * @param procodes -- 参数
     * @throws AppException
     */
    public void sendProInfo2OA(String isNoticeOA,String procodes) {
        //整理项目信息封装
        String wheresql = " pro_code in (" + procodes + ")";
        List<Map<String, Object>> proinfoList = adjustAuditDAO.getDatas("v_perf_queryProperf_info", wheresql, null);
        try {
            if(proinfoList!=null && proinfoList.size()>0){
                List<Map<String, Object>> indexList = adjustAuditDAO.getDatas("v_perf_queryProperf_index", wheresql, "order by t.pro_code");
                if(indexList.size() == 0){
                    proinfoList.forEach(r->{r.put("guid",r.get("pro_code"));});
                    adjustAuditDAO.saveAll(proinfoList,"PERF_TMP_GUIDS");
                    PrjIndexDAO prjIndexDAO = (PrjIndexDAO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexDAO");
                    indexList = prjIndexDAO.getQueryPerfIndex(CommonUtil.getProvince(),CommonUtil.getYear());
                }
                Map<String,List<Map<String, Object>>> map = indexList.stream().collect(Collectors.groupingBy(x -> (String)x.get("pro_code")));
                proinfoList.forEach(m -> {
                    m.remove("guid");
                    String procode = (String) m.get("pro_code");
                    m.put("indexs",map.get(procode));
                });
            }
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            MediaType type = MediaType.parseMediaType("application/json; charset=UTF-8");
            headers.setContentType(type);
            headers.add("Accept", MediaType.APPLICATION_JSON.toString());
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("data",proinfoList);
            jsonObject.put("sendTime",PerfUtil.getServerTimeStamp());
            jsonObject.put("projectCount",proinfoList.size());
            HttpEntity<String> formEntity = new HttpEntity<String>(jsonObject.toString(), headers);
            logger.info("==============OA系统接口更新推送开始"+formEntity.toString()+"===========");
            String json = restTemplate.postForObject(isNoticeOA,formEntity, String.class);
            logger.info("==============OA系统接口更新推送返回"+json+"===========");
            Map<String, Object> jsonMap = PerfUtil.parseObj2Map(JSONObject.parse(json));
            logger.info("==============OA系统接口更新推送返回解析：：："+jsonMap.toString()+"===========");
            boolean statusCode = (boolean) jsonMap.get("success");
            if (!statusCode){
                String message = (String) jsonMap.get("message");
                throw new AppException("OA接口报错：" + message);
            }
        } catch (AppException e) {
            logger.error("OA接口报错：" + e.getMessage(), e);
        }
    }

}
