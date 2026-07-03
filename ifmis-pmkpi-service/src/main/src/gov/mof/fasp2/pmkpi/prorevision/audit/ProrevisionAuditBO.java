package gov.mof.fasp2.pmkpi.prorevision.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.prorevision.report.ProrevisionReportDAO;

import java.util.*;

public class ProrevisionAuditBO extends PmkpiBO {
    private ProrevisionAuditDAO revisionAuditDAO;

    public void setRevisionAuditDAO(ProrevisionAuditDAO revisionAuditDAO) {
        this.revisionAuditDAO = revisionAuditDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select t.* from ");
        returnsql.append(tablecode);
        returnsql.append(" t where ");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1"); //数据权限
        returnsql.append(datarule);
        if (wheresql != null && !wheresql.isEmpty()){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, revisionAuditDAO.PMKPI_TABLE_T_AGENCY));
        return returnsql.toString();
    }

    /**
     * 查询左侧树。
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = ProrevisionReportDAO.PERF_TABLE_PROVISIONDECLARE;
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        return revisionAuditDAO.getLeftTree(tablecode, datarule);
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String bustype = (String) params.get("bustype");
        String goaltablecode = "v_pm_perf_goal_info";
        String indextablecode = "v_pm_perf_indicator";
        String wheresql = "";
        String busguid = (String) params.get("busguid");
        if ("audit".equals(actioncode)) {
            String mainguid = (String) datas.get(0).get("guid"); //主单guid
            String proguid = (String) datas.get(0).get("proguid"); //项目guid
            String procode = (String) datas.get(0).get("pro_code"); //项目code
            this.workflow(actioncode, workflow, remark, ProrevisionReportDAO.PERF_TABLE_PROVISIONDECLARE, datas);
            String wfstatus = (String) datas.get(0).get("wfstatus");
            if (wfstatus != null && !wfstatus.isEmpty() && "011".equals(wfstatus)) {//终审处理
                wheresql = " mainguid='" + mainguid + "' and yearflag = '0'";
                List<Map<String, Object>> goaldata = revisionAuditDAO.getDatas(ProrevisionReportDAO.PERF_T_TABLE_REVISIONGOAL, wheresql, "order by update_time");
                List<Map<String, Object>> indexdata = revisionAuditDAO.getDatas(ProrevisionReportDAO.PERF_TABLE_PROVISIONDINDEX, wheresql, "order by update_time");
                //删除项目目标指标数据
                String delindex = "";
                if (PerfUtil.getIsHbei()) {
                    delindex = " mainguid='" + proguid + "'";
                } else {
                    delindex = " pro_code='" + procode + "'";
                }
                delindex += " and yearflag = '0'";
                //对项目指标目标进行替换
                String yearflag = "";
                int m = 1;
                int n = 1;
                HashMap<String,String> goalguidMap = new HashMap<String,String>();
                for (Map<String, Object> goal : goaldata) {
                    String adjustndgoal = (String) goal.get("kpi_target");
                    if (adjustndgoal != null && !"".equals(adjustndgoal)) {
                        goal.put("kpi_target", adjustndgoal);
                        goal.put("ndgoal", adjustndgoal);
                    }
                    String newguid = this.getCreateguid();
                    if(PerfUtil.getIS_HUBEI()){//湖北模式
                        String oldgoalguid = (String) goal.get("guid");
                        goalguidMap.put(oldgoalguid,newguid);
                        yearflag = (String) goal.get("yearflag");
                        if ("1".equals(yearflag)){ //中长期
                            goal.put("goalname", "长期目标"+m);
                            goal.put("yearflag", 1);
                            m++;
                        } else {
                            goal.put("goalname", "年度目标"+n);
                            goal.put("yearflag", 0);
                            n++;
                        }
                    } else {
                        goal.put("yearflag", 0);
                    }
                    goal.put("guid", newguid);
                    goal.put("pro_code", procode);
                    goal.put("status", "");
                    this.setData(goal);
                }
                for (Map<String, Object> index : indexdata) {
                    if (index.get("indexval") != null) {
                        index.put("kpi_val", index.get("indexval"));
                    }
                    //湖北模式 目标生成新的id后  指标关联的goalguid也要相应改变
                    if(PerfUtil.getIS_HUBEI()){
                        String oldgoalguid = (String) index.get("goalguid");
                        if (oldgoalguid != null && ! oldgoalguid.isEmpty()) {
                            String newGoalguid = goalguidMap.get(oldgoalguid);
                            index.put("kpi_dep_id", newGoalguid);
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
                    index.put("pro_code", procode);
                    this.setData(index);
                    String status = index.get("status") + "";
                    if (status != null && "1".equals(status)) {
                        index.put("is_deleted", "1");
                    }
                    index.put("status", "");
                }
                if (goaldata != null && goaldata.size()>0) {
                    //删除项目目标指标数据
                    revisionAuditDAO.updateIndexDelStuts(goaltablecode, delindex);
                    revisionAuditDAO.saveAll(goaldata, goaltablecode);
                }
                if (indexdata != null && indexdata.size()>0) {
                    //删除项目目标指标数据
                    revisionAuditDAO.updateIndexDelStuts(indextablecode, delindex);
                    this.setIndexDatas(indexdata, "PM001", false);
                    revisionAuditDAO.saveAll(indexdata, indextablecode);
                }
            }
        } else if (actioncode !=null && "auditbatch".equals(actioncode)){
            this.wfAuditbatch(datas,params);
        } else {
            if ("cancelaudit".equals(actioncode)) {//取消审核，申报数据是否终审改为不必填
                List<String> procodeList = new ArrayList<>();
                for (Map<String, Object> data : datas) {
                    String wfstatus = (String) data.get("wfstatus");
                    if("011".equals(wfstatus)){
                        String pro_code = (String) data.get("pro_code");
                        procodeList.add(pro_code);
                    }
                }
                if (procodeList.size() > 0) {
                    String upsql = " is_last_inst = 2 ";
                    wheresql = " is_last_inst = 1 and yearflag='0' ";
                    revisionAuditDAO.updateAllByColumn("pro_code", procodeList, PerfConstant.PMKPI_VPM_GOAL_INFO, upsql, wheresql);
                    revisionAuditDAO.updateAllByColumn("pro_code", procodeList, PerfConstant.PMKPI_VPM_INDICATOR, upsql, wheresql);
                }
            }
            this.workflow(actioncode, workflow, remark, ProrevisionReportDAO.PERF_TABLE_PROVISIONDECLARE, datas);
        }
        return this.auditdefine(datas, busguid, actioncode, null);
    }



    /**
     * 送审/审核/退回/取消审核
     *
     * @param datas
     * @param params --
     * @return --
     */
    public void wfAuditbatch(List<Map<String, Object>> datas, HashMap<String, Object> params) throws AppException {
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String goaltablecode = "v_pm_perf_goal_info";
        String indextablecode = "v_pm_perf_indicator";
        String wheresql ="";
        this.workflow(actioncode, workflow, remark, ProrevisionReportDAO.PERF_TABLE_PROVISIONDECLARE, datas);
        StringBuffer bufferid = new StringBuffer();
        StringBuffer bufferproguid = new StringBuffer();
        StringBuffer bufferprocode = new StringBuffer();
        Map imptemp = new HashMap();
        int len = datas.size();
        for (int i = 0; i < len; i++) {
            imptemp = datas.get(i);
            if (i != 0){
                bufferid.append(",");
                bufferproguid.append(",");
            }
            bufferid.append("'").append(imptemp.get("guid")).append("'");
            bufferproguid.append(imptemp.get("proguid"));
            bufferprocode.append(imptemp.get("pro_code"));
        }
        Map<String, Object> auditMap = new HashMap<>();
        String ids = "";
        for (Map<String, Object> data : datas) {
            ids = (String) data.get("guid");
            auditMap.put(ids, data);
        }
        String wfstatus = (String) datas.get(0).get("wfstatus");
        if ("011".equals(wfstatus)) {
            wheresql = " mainguid in(" + bufferid.toString() + ")";
            List<Map<String, Object>> goaldata = revisionAuditDAO.getDatas(ProrevisionReportDAO.PERF_T_TABLE_REVISIONGOAL, wheresql, "order by update_time");
            List<Map<String, Object>> indexdata = revisionAuditDAO.getDatas(ProrevisionReportDAO.PERF_TABLE_PROVISIONDINDEX, wheresql, "order by update_time");
            //对项目指标目标进行替换
            Map<String, Object> objectMap = null;
            String mainguid = "";
            List<String> goalpros = new ArrayList<>(); //目标涉及的项目信息
            List<String> indexpros = new ArrayList(); //指标涉及的项目信息
            List<String> goalcodepros = new ArrayList<>(); //目标涉及的项目信息
            List<String> indexcodepros = new ArrayList(); //指标涉及的项目信息
            for (Map<String, Object> goal : goaldata) {
                String adjustndgoal = (String) goal.get("kpi_target");
                mainguid = (String) goal.get("mainguid");
                objectMap = (Map<String, Object>) auditMap.get(mainguid);
                if (adjustndgoal != null && !"".equals(adjustndgoal)) {
                    goal.put("kpi_target", adjustndgoal);
                    goal.put("ndgoal", adjustndgoal);
                }
                if (!goalpros.contains(goal.get("proguid"))){
                    goalpros.add((String)goal.get("proguid"));
                }
                if (!goalcodepros.contains(goal.get("pro_code"))){
                    goalcodepros.add((String)goal.get("pro_code"));
                }
                String newguid = this.getCreateguid();
                goal.put("guid", newguid);
                goal.put("pro_code", objectMap.get("pro_code"));
                goal.put("status", "");
                this.setData(goal);
            }

            for (Map<String, Object> index : indexdata) {
                mainguid = (String) index.get("mainguid");
                objectMap = (Map<String, Object>) auditMap.get(mainguid);
                if (index.get("indexval") != null) {
                    index.put("kpi_val", index.get("indexval"));
                }
                if (!indexpros.contains(index.get("proguid"))){
                    indexpros.add((String)index.get("proguid"));
                }
                if (!indexcodepros.contains(index.get("pro_code"))){
                    indexcodepros.add((String)index.get("pro_code"));
                }
                String newguid = this.getCreateguid();
                index.put("guid", newguid);
                index.put("pro_code", objectMap.get("pro_code"));
                this.setData(index);
                String status = index.get("status") + "";
                if (status != null && !status.isEmpty() && "1".equals(status)) {
                    index.put("is_deleted", "1");
                }
                index.put("status", "");
            }
            String delindex = "";
            if (goaldata != null && goaldata.size() > 0) {
                if (PerfUtil.getIsHbei()) {
                    delindex = revisionAuditDAO.createInSql("mainguid", goalpros);
                } else {
                    delindex = revisionAuditDAO.createInSql("pro_code", goalcodepros);
                }
                delindex += " and yearflag = '0'";
                //删除项目目标指标数据
                revisionAuditDAO.updateIndexDelStuts(goaltablecode, delindex);
                revisionAuditDAO.saveAll(goaldata, goaltablecode);
            }
            if (indexdata != null && indexdata.size() > 0) {
                if (PerfUtil.getIsHbei()) {
                    delindex = revisionAuditDAO.createInSql("mainguid", indexpros);
                } else {
                    delindex = revisionAuditDAO.createInSql("pro_code", indexcodepros);
                }
                delindex += " and yearflag = '0'";
                revisionAuditDAO.updateIndexDelStuts(indextablecode, delindex);
                this.setIndexDatas(indexdata, "PM001", false);
                revisionAuditDAO.saveAll(indexdata, indextablecode);
            }
        }
    }

    private void setData(Map data){
        data.put("mainguid", data.get("proguid"));
        data.put("is_last_inst", 1);
        data.put("version_name", PerfConstant.PMKPI_VERSION_NAME_XDRCDTWH);
        this.getBasMap(data, "add");
    }

}
