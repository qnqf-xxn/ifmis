package gov.mof.fasp2.pmkpi.perfprotrace.audit;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.datacommon.workflow.dao.WorkflowStepDAO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProTraceAuditBO extends PmkpiBO {

    private ProTraceAuditDAO proTraceAuditDAO;

    public void setProTraceAuditDAO(ProTraceAuditDAO proTraceAuditDAO) {
        this.proTraceAuditDAO = proTraceAuditDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String) sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String) sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
//        String prolev = (String) sqlmap.get("prolev"); //项目级别：一二三级项目
        String tasktype = (String) sqlmap.get("tasktype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String deptwfststus = (String) sqlmap.get("deptwfststus");
        String jxwfststus = (String) sqlmap.get("jxwfststus");
        if (PerfUtil.getIsHbei() && ProTraceManageDAO.PERF_VIEW_TRACEMANAGE.equals(tablecode)) {
            tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE_HB;
        }
        String columncodes = proTraceAuditDAO.getColumncodes(tablecode, "t");
        if (!StringUtil.isEmpty(columncodes)) {
            columncodes += ",case when depttask='1' and provincetask='2' and wfstatus='" + deptwfststus + "' then '011'";
            if (PerfUtil.getIsGuangXi()) {
                columncodes += " when provincetask='1' and nvl(audittype,0) <> '2' and wfstatus='" + jxwfststus + "' then '011'";
            }
            columncodes += " else wfstatus end wfstatus";
        } else {
            columncodes = "t.*";
        }
        StringBuffer returnsql = new StringBuffer("select ");
        returnsql.append(columncodes).append(" from ");
        returnsql.append(tablecode).append(" t ");
        returnsql.append(" where t.tasktype='").append(tasktype).append("'");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (!StringUtil.isEmpty(wheresql)) {
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (!StringUtil.isEmpty(tablesql)) {
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (!StringUtil.isEmpty(wfsql)) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }
        //天津监控审核是绩效处、业务处并行审核，某一岗审完数据还在待审核页签下，两岗都审核通过后数据是终审状态
        //其中一岗审核完后，待审核页签过滤掉这条数据
        if (PerfUtil.getIsTianJin()) {
            //过滤会签表数据
            String userID = SecureUtil.getCurrentUserID();
            List<Map<String, Object>> rolelist = proTraceAuditDAO.queryForList("select roleguid from fasp_t_causerrole a, fasp_t_carole t where t.status = 1 and t.guid = a.roleguid and a.userguid = '" + userID + "'");
            String roleguid = "";
            for (Map<String, Object> map : rolelist) {
                roleguid += "'" + map.get("roleguid") + "',";
            }
            roleguid = roleguid.substring(0, roleguid.length() - 1);
            returnsql.append(" and not exists (" +
                    "select * from " + WorkflowStepDAO.COUNTERSIGN_TABLE + " cc where cc.is_deleted <> 1 and cc.isdo = 1 " +
                    "and cc.wfid = t.wfid and cc.billid = t.guid and cc.roleguid in(" + roleguid + ")" +
                    ")");
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, proTraceAuditDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        if ("alreadyaudit".equals(tabcode) && StringUtil.isEmpty(orderby)) {
            returnsql.append(" order by t.lastupdatetime desc");
        }
        return returnsql.toString();
    }

    /**
     * 查询左侧树数据
     *
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE;
        if (PerfUtil.getIsHbei()) {
            tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE_HB;
        }
        String tasktype = (String) params.get("tasktype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and t.tasktype = '" + tasktype + "'";
        return proTraceAuditDAO.getLeftTree(tablecode, datarule);
    }

    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String bustype = (String) params.get("bustype");
        String procode = (String) params.get("procode");
        String remark = (String) params.get("remark");
        String busguid = (String) params.get("busguid");
        String audittype = (String) params.get("audittype");
        String goaltablecode = "";
        String indextablecode = "";
        if ("audit".equals(actioncode)) {
            String proguid = (String) datas.get(0).get("proguid"); //项目guid
            String mainguid = (String) datas.get(0).get("guid");
            if (!StringUtil.isNullOrEmpty(audittype)) {
                params.put("mainguid", mainguid);
                this.updateaudittype(params);
            }
            //河北双流程
            this.workflow(actioncode, workflow, remark, ProTraceManageDAO.PERF_TABLE_TRACEMANAGE, datas);
            String hbprodualwfstatus = PerfUtil.getSystemSet("hbprodualwfstatus");
            if(!StringUtil.isEmpty(hbprodualwfstatus)){
                proTraceAuditDAO.saveAll(datas, proTraceAuditDAO.PMKPI_TABLE_TMP_GUIDS);
                String hbwheresql = " exists(select 1 from "+proTraceAuditDAO.PMKPI_TABLE_TMP_GUIDS+" a where a.guid=t.guid) ";
                List<Map<String, Object>> hbdatas = proTraceAuditDAO.getDatas(ProTraceManageDAO.PERF_TABLE_TRACEMANAGE,hbwheresql,null);
                Map<String, Object> wfstatusmap = PerfUtil.parseString2Map(hbprodualwfstatus);
                String startwfstatus = (String) wfstatusmap.get("startwfstatus");
                List<Map<String, Object>> hbauditdata = new ArrayList<>();
                for (Map map : hbdatas) {
                    String produalwfstatus = (String) map.get("wfstatus");
                    if(!StringUtil.isEmpty(startwfstatus) && startwfstatus.equals(produalwfstatus)){
                        String traceguid = (String) map.get("guid");
                        map.put("mainguid", traceguid);
                        map.put("guid", CommonUtil.createGUID());
                        map.remove("wfid");
                        map.remove("wfstatus");
                        hbauditdata.add(map);
                    }
                }
                if(hbauditdata.size()>0){
                    String delsql = " exists(select 1 from " + proTraceAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid) ";
                    proTraceAuditDAO.saveAll(hbauditdata, proTraceAuditDAO.PMKPI_TABLE_TMP_GUIDS);
                    proTraceAuditDAO.delDatas("V_PERF_T_HBPROMONITOR", delsql);
                    this.workflow("create", "2E7488F7ACE647C3ADC32B17546E8414", remark, "V_PERF_T_HBPROMONITOR", hbauditdata);
                }
            }
            String istraceinitiateadjust = PerfUtil.getSystemSet("ISTRACEINITIATEADJUST");//调整是否走工作流
            Map<String, Object> mm = PerfUtil.parseString2Map(istraceinitiateadjust);
            String iswfadjust = (String) mm.get("iswfadjust");
            String deptwfststus = (String) mm.get("deptwfststus");
            String wfstatus = (String) datas.get(0).get("wfstatus");
            String provincetask = (String) datas.get(0).get("provincetask");
            String depttask = (String) datas.get(0).get("depttask");
            //不走工作流进行数据替换 终审时替换,重点监控不替换
            if ((iswfadjust != null && "1".equals(iswfadjust)) &&
                    !"1".equals(provincetask) &&
                    //状态终审
                    ((wfstatus != null && "011".equals(wfstatus)) ||
                            //一般监控 并且是状态相同时
                            (("1".equals(depttask) && "2".equals(provincetask))
                                    && (deptwfststus != null && deptwfststus.equals(wfstatus))))) {
                if (bustype != null && "protrace".equals(bustype)) {
                    goaltablecode = "v_pm_perf_goal_info";
                    indextablecode = "v_pm_perf_indicator";
                } else if (bustype != null && "depttrace".equals(bustype)) {
                    goaltablecode = "v_bgt_perf_goal_info";
                    indextablecode = "v_bgt_perf_indicator";
                }
                StringBuffer wheresql = new StringBuffer();
                String col = "";
                String value = "";
                String delindex = "";
                if (PerfUtil.getIsHbei() || "depttrace".equals(bustype)) {
                    col = " mainguid ";
                    value = proguid;
                } else {
                    col = " pro_code ";
                    value = procode;
                }
                delindex = col + "='" + value + "'";
                wheresql.append(" mainguid='").append(mainguid).append("' ");
                if ("program".equals(bustype) || "protrace".equals(bustype)){
                    delindex += " and yearflag = '0'";
                }
                List<Map<String, Object>> goaldata = proTraceAuditDAO.getDatas("v_perf_t_adjustgoal", wheresql.toString(), "order by update_time");
                wheresql.append(" and nvl(status,4) <> 1 ");
                List<Map<String, Object>> indexdata = proTraceAuditDAO.getDatas("v_perf_t_adjustindex", wheresql.toString(), "order by update_time");
                //对项目指标目标进行替换
                for (Map<String, Object> goal : goaldata) {
                    String adjustndgoal = (String) goal.get("adjustndgoal");
                    if (adjustndgoal != null && !"".equals(adjustndgoal)) {
                        goal.put("kpi_target", adjustndgoal);
                        goal.put("ndgoal", adjustndgoal);
                    }
                    String newguid = this.getCreateguid();
                    goal.put("guid", newguid);
                    this.setData(goal);
                }
                for (Map<String, Object> index : indexdata) {
                    if (index.get("adjustindexval") != null) {
                        index.put("indexval", index.get("adjustindexval"));
                        index.put("kpi_val", index.get("adjustindexval"));
                    }
                    String newguid = this.getCreateguid();
                    index.put("guid", newguid);
                    this.setData(index);
                    String status = index.get("status") + "";
                    if (status != null && "1".equals(status)) {
                        index.put("is_deleted", "1");
                    }
                    index.put("status", "");
                }
                if (goaldata != null && goaldata.size() > 0) {
                    //删除项目目标指标数据
                    proTraceAuditDAO.updateIsDeleteDatas(goaltablecode, delindex);
                    proTraceAuditDAO.saveAll(goaldata, goaltablecode);
                }
                if (indexdata != null && indexdata.size() > 0) {
                    //删除项目目标指标数据
                    proTraceAuditDAO.updateIsDeleteDatas(indextablecode, delindex);
                    proTraceAuditDAO.saveAll(indexdata, indextablecode);
                }
                logger.debug("监控调整完成+++++++++++++++++++项目guid：" + proguid + "++++++++++项目编码：" + procode);
            }
        } else if (actioncode !=null &&"auditbatch".equals(actioncode)){
            this.wfAuditbatch(datas,params);
        } else {
            this.workflow(actioncode, workflow, remark, ProTraceManageDAO.PERF_TABLE_TRACEMANAGE, datas);
            if ("cancelaudit".equals(actioncode) || "cancelsendaudit".equals(actioncode)) {
                List<String> cols = new ArrayList<>();
                cols.add("audittype");
                cols.add("conaudittype");
                for (Map<String, Object> map: datas) {
                    map.put("audittype", null);
                    map.put("conaudittype", null);
                }
                proTraceAuditDAO.updateAll(cols, datas, ProTraceManageDAO.PERF_TABLE_TRACEMANAGE);
            }
        }
        //处理规范表数据
        this.updateTracePayTabelDatas(datas, actioncode, bustype);
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    public void wfAuditbatch(List<Map<String, Object>> datas, HashMap<String, Object> params) throws AppException {
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        StringBuffer wheresql= new StringBuffer();
        String goaltablecode = "";
        String indextablecode = "";
        this.workflow(actioncode, workflow, remark, ProTraceManageDAO.PERF_TABLE_TRACEMANAGE, datas);
        String istraceinitiateadjust = PerfUtil.getSystemSet("ISTRACEINITIATEADJUST");//调整是否走工作流
        Map<String, Object> mm = PerfUtil.parseString2Map(istraceinitiateadjust);
        String iswfadjust = (String) mm.get("iswfadjust");
        String deptwfststus = (String) mm.get("deptwfststus");
        String wfstatus = "";
        String provincetask = "";
        String depttask = "";
        String tasktype = (String) datas.get(0).get("tasktype");
        StringBuffer bufferid = new StringBuffer();
        StringBuffer bufferproguid = new StringBuffer();
        StringBuffer buffercode = new StringBuffer();
        List<String> list = new ArrayList<>();
        Map<String, Object> auditMap = new HashMap<>();
        for (Map<String, Object> data : datas) {
            String d = (String) data.get("depttask");
            String p = (String) data.get("provincetask");
            String w = (String) data.get("wfstatus");
            if (d != null && "1".equals(d) && p != null && "2".equals(p)
                    && deptwfststus != null && deptwfststus.equals(w)) {
                String guid = (String) data.get("guid");
                wfstatus = (String) data.get("wfstatus");
                provincetask = (String) data.get("provincetask");
                depttask = (String) data.get("depttask");
                bufferid.append("'").append(data.get("guid")).append("',");
                bufferproguid.append("'").append(data.get("proguid")).append("',");
                buffercode.append("'").append(data.get("pro_code")).append("',");
                list.add(guid);
                String code = (String) data.get("pro_code");
                auditMap.put(code,data);
            }
        }
        if (bufferid.length() > 0) {
            bufferid.deleteCharAt(bufferid.length() - 1);
        }
        if (bufferproguid.length() > 0) {
            bufferproguid.deleteCharAt(bufferproguid.length() - 1);
        }
        if (buffercode.length() > 0) {
            buffercode.deleteCharAt(buffercode.length() - 1);
        }
        //不走工作流进行数据替换 终审时替换
        if ((iswfadjust != null && "1".equals(iswfadjust)) &&
                //状态终审
                ((wfstatus != null && "011".equals(wfstatus)) ||
                        //重点监控绩效处审核后状态相同
//                            (wfaudittype != null && !"2".equals(wfaudittype) && (jxwfststus != null && jxwfststus.equals(wfstatus))) ||
                        //一般监控 并且是状态相同时
                        (depttask != null && "1".equals(depttask) && provincetask != null && "2".equals(provincetask)
                                && deptwfststus != null && deptwfststus.equals(wfstatus)))) {
            if (tasktype != null && "protrace".equals(tasktype)) {
                goaltablecode = "v_pm_perf_goal_info";
                indextablecode = "v_pm_perf_indicator";
            } else if (tasktype != null && "depttrace".equals(tasktype)) {
                goaltablecode = "v_bgt_perf_goal_info";
                indextablecode = "v_bgt_perf_indicator";
            }
            wheresql = new StringBuffer();
            String col = "";
            String value = "";
            String delindex = "";
            if (PerfUtil.getIsHbei() || "depttrace".equals(tasktype)) {
                col = " mainguid ";
                value = bufferproguid.toString();
            } else {
                col = " pro_code ";
                value = buffercode.toString();
            }
            delindex = col + "in(" + value + ")";
            StringBuffer buffer = new StringBuffer();
            if (list.size() > 0){
                for (int i = 0; i < list.size(); i++) {
                    if (i == 0){
                        buffer.append("'").append(list.get(i)).append("'");
                    }else {
                        buffer.append(",").append("'").append(list.get(i)).append("'");
                    }

                }
            }
            wheresql.append(" mainguid in (").append(buffer.toString()).append(") ");
            if ("program".equals(tasktype) || "protrace".equals(tasktype)){
                delindex += " and yearflag = '0'";
            }
            List<Map<String, Object>> goaldata = proTraceAuditDAO.getDatas("v_perf_t_adjustgoal", wheresql.toString(), "order by update_time");
            wheresql.append(" and nvl(status,4) <> 1 ");
            List<Map<String, Object>> indexdata = proTraceAuditDAO.getDatas("v_perf_t_adjustindex", wheresql.toString(), "order by update_time");
            //对项目指标目标进行替换
            Map<String, Object> objectMap = null;
            String proCode="";
            List<String> goalpros = new ArrayList<>(); //目标涉及的项目信息
            List<String> indexpros = new ArrayList(); //指标涉及的项目信息
            List<String> goalcodepros = new ArrayList<>(); //目标涉及的项目信息
            List<String> indexcodepros = new ArrayList(); //指标涉及的项目信息
            for (Map<String, Object> goal : goaldata) {
                String adjustndgoal = (String) goal.get("adjustndgoal");
                proCode = (String) goal.get("pro_code");
                objectMap = (Map<String, Object>) auditMap.get(proCode);
                if (adjustndgoal != null && !"".equals(adjustndgoal)) {
                    goal.put("kpi_target", adjustndgoal);
                    goal.put("ndgoal", adjustndgoal);
                }
                String newguid = this.getCreateguid();
                goal.put("guid", newguid);
                goal.put("pro_code", objectMap.get("pro_code"));
                this.setData(goal);
                if (!goalpros.contains(goal.get("proguid"))){
                    goalpros.add((String)goal.get("proguid"));
                }
                if (!goalcodepros.contains(goal.get("pro_code"))){
                    goalcodepros.add((String)goal.get("pro_code"));
                }
            }
            String codes = "";
            for (Map<String, Object> index : indexdata) {
                codes = (String) index.get("pro_code");
                objectMap = (Map<String, Object>) auditMap.get(codes);
                if (index.get("adjustindexval") != null) {
                    index.put("indexval", index.get("adjustindexval"));
                    index.put("kpi_val", index.get("adjustindexval"));
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
                if (!indexpros.contains(index.get("proguid"))){
                    indexpros.add((String)index.get("proguid"));
                }
                if (!indexcodepros.contains(index.get("pro_code"))){
                    indexcodepros.add((String)index.get("pro_code"));
                }
            }
            if (goaldata != null && goaldata.size() > 0) {
                if (PerfUtil.getIsHbei() || "depttrace".equals(tasktype)) {
                    delindex = proTraceAuditDAO.createInSql("mainguid", goalpros);
                } else {
                    delindex = proTraceAuditDAO.createInSql("pro_code", goalcodepros);
                }
                if ("program".equals(tasktype) || "protrace".equals(tasktype)) {
                    delindex += " and yearflag = '0'";
                }
                //删除项目目标指标数据
                proTraceAuditDAO.updateIsDeleteDatas(goaltablecode, delindex);
                proTraceAuditDAO.saveAll(goaldata, goaltablecode);
            }
            if (indexdata != null && indexdata.size() > 0) {
                if (PerfUtil.getIsHbei() || "depttrace".equals(tasktype)) {
                    delindex = proTraceAuditDAO.createInSql("mainguid", indexpros);
                } else {
                    delindex = proTraceAuditDAO.createInSql("pro_code", indexcodepros);
                }
                if ("program".equals(tasktype) || "protrace".equals(tasktype)) {
                    delindex += " and yearflag = '0'";
                }
                //删除项目目标指标数据
                proTraceAuditDAO.updateIsDeleteDatas(indextablecode, delindex);
                proTraceAuditDAO.saveAll(indexdata, indextablecode);
            }
            logger.debug("监控调整完成+++++++++++++++++++项目guid：" + bufferid.toString() + "++++++++++项目编码：" + buffercode);
        }
    }

    /**
     * 修改审核状态
     * @param param
     * @return
     * @throws AppException
     */
    public void updateaudittype(HashMap<String, Object> param) throws AppException {
        String guid = (String) param.get("mainguid");
        String audittype = (String) param.get("audittype");
        proTraceAuditDAO.updateaudittype(guid,audittype);
    }

    /**
     * <p></p >
     *
     * @param
     * @author hw
     * @date 2021/5/27 11:18
     */
    public void savePushremind(HashMap<String, Object> datas) throws AppException {
        List<HashMap<String, Object>> dataList = (List) datas.get("data");
        List<HashMap<String, Object>> pushList = new ArrayList<>();
        List<HashMap<String, Object>> adjustList = new ArrayList<>();
        UserDTO user = SecureUtil.getCurrentUser();
        for (HashMap<String, Object> oneMap : dataList) {
            String proguid = (String) oneMap.get("proguid"); // 获取项目id
            /**
             * 查询当前项目是否确认，未确认则不推送
             */
            List<Map<String, Object>> getOne = proTraceAuditDAO.queryForList("select t.* from  v_perf_t_adjustremind t where status = 0 and projguid =  '" + proguid + "'");
            if (getOne != null && !getOne.isEmpty()) {
                //如果这条数据不是监控推过来的要改为监控的
                List<Map<String, Object>> pushOne = proTraceAuditDAO.queryForList("select t.* from  v_perf_t_pushremind t where  proguid =  '" + proguid + "'");
                if (pushOne != null && !pushOne.isEmpty()) {
                    Map<String, Object> stringObjectMap = pushOne.get(0);
                    String isjk = (String) stringObjectMap.get("isjk");
                    String guid = (String) stringObjectMap.get("guid");
                    if (StringUtil.isEmpty(isjk) || !"1".equals(isjk)) {
                        String updateSql = "UPDATE v_perf_t_pushremind SET ISJK = '1' WHERE GUID = '" + guid + "'";
                        proTraceAuditDAO.update(updateSql);
                    }
                }
                continue;
            }
            HashMap<String, Object> params = new HashMap<>(); // 创建推送提醒对象
            String uuid = StringUtil.createUUID();
            params.put("guid", uuid);
            params.put("bgtge1t", null);
            params.put("amt1", null);
            params.put("amt2", null);
            params.put("amt3", null);
            params.put("amt4", null);
            params.put("proguid", proguid);
            params.put("isedit", null);
            params.put("update_time", null);
            params.put("startdate", null);
            params.put("ordernum", null);
            params.put("isjk", "1");
            params.put("status", "1");
            params.put("createtime", StringUtil.getSysDBDate());
            params.put("updatetime", StringUtil.getSysDBDate());
            params.put("province", CommonUtil.getProvince());
            params.put("year", CommonUtil.getYear());
            params.put("lastupdatetime", StringUtil.getSysDBDate());
            pushList.add(params);

            HashMap<String, Object> params1 = new HashMap<>();//创建关联对象
            params1.put("guid", this.getCreateguid());
            params1.put("projguid", proguid);
            params1.put("mainguid", uuid);
            params1.put("status", 0);
            params1.put("confirmtime", null);
            params1.put("agencyguid", null);
            params1.put("finintorgguid", null);
            params1.put("createtime", null);
            params1.put("updatetime", null);
            params1.put("lastupdatetime", null);
            params1.put("creater", user.getGuid());
            params1.put("province", user.getProvince());
            params1.put("year", CommonUtil.getYear());
            adjustList.add(params1);
        }
        proTraceAuditDAO.saveAll(pushList, "v_perf_t_pushremind"); // 推送提醒表入库
        proTraceAuditDAO.saveAll(adjustList, "v_perf_t_adjustremind"); // 关联表入库
    }
    /**
     * <p>字符串转sql</p >
     * 001,002 --->  '001','002'
     *
     * @param
     * @author hw
     * @date 2021/5/27 19:37
     */
    public static String strToSql(String str) {
        String[] strArray = str.split(",");
//        String resultStr = "";
        StringBuilder resultStr = new StringBuilder();
        for (String s : strArray) {
//            resultStr += "'" + s + "',";
            resultStr.append("'").append(s).append("',");
        }
        String result = resultStr.toString();
        return result.substring(0, result.length() - 1);
    }

    /**
     * 双流程，是否能继续审核
     * @param traceguid
     * @return
     */
    public Map<String, Object> isdualaudit(String traceguid){
        Map<String, Object> backmap = new HashMap<String, Object>();
        String wheresql = " t.mainguid = '"+ traceguid +"'";
        List<Map<String, Object>> data = proTraceAuditDAO.getDatas("V_PERF_T_HBPROMONITOR", wheresql, null);
        if(data != null && data.size()>0){
            String wfstatus = (String) data.get(0).get("wfstatus");
            if(!wfstatus.isEmpty() && "011".equals(wfstatus)){
                backmap.put("success",true);
            }
        }
        return backmap;
    }

    //判断发起整改的数据表中是否存在
    public Integer getDataByGuid(HashMap<String, Object> params){
        String lefttabtype = (String) params.get("lefttabtype");
        String projguid = (String) params.get("projguid");
        String rectype = (String) params.get("rectype");
        String pro_code = (String) params.get("pro_code");
        String taskguid = (String) params.get("taskguid");
        StringBuffer sql = new StringBuffer("select count(*) from V_PERF_T_RECTIFY t where 1=1 ");
        if ("protrace".equals(lefttabtype)) { //项目支出
            sql.append(" and pro_code = '"+pro_code+"'");
        } else if ("depttrace".equals(lefttabtype)) { //部门整体
            sql.append(" and proguid = '"+projguid+"'");
        }
        sql.append(" and rectype = '"+rectype+"' and taskguid = '"+taskguid+"' and wfstatus <> '011'");
        int i = proTraceAuditDAO.queryForInt(sql.toString());
        return i;
    }

    /**
     * 获取河北监控分支数据
     * @param traceguid
     * @return
     */
    public Map<String, Object> getHbpromonitor(String traceguid){
        Map<String, Object> backmap = new HashMap<String, Object>();
        String wheresql = " t.mainguid = '"+ traceguid +"'";
        List<Map<String, Object>> data = proTraceAuditDAO.getDatas("V_PERF_T_HBPROMONITOR", wheresql, null);
        backmap.put("datas",data);
        return backmap;
    }

    /**
     * 处理规范表数据
     * @param datas
     * @param actioncode
     * @param bustype
     * @throws AppException
     */
    public void updateTracePayTabelDatas (List<Map<String, Object>> datas, String actioncode, String bustype) throws AppException {
        proTraceAuditDAO.updateTracePayTabelDatas(datas, actioncode, bustype);
    }

    private void setData(Map data){
        data.put("mainguid", data.get("proguid"));
        data.put("is_last_inst", 1);
        data.put("yearflag", "0");
        data.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
        this.getBasMap(data, "add");
    }

}
