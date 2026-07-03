package gov.mof.fasp2.pmkpi.probleamtask;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfcommon.smssend.SmsService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Pattern;

public class ProblemTaskBO extends PmkpiBO {

    private ProblemTaskDAO problemTaskDAO;

    public void setProblemTaskDAO(ProblemTaskDAO problemTaskDAO) {
        this.problemTaskDAO = problemTaskDAO;
    }

    @Override
    public String getVodSql(Map params) throws AppException {
        String tablecode;
        String tablesql = (String)params.get("tablesql");
        String wheresql = (String)params.get("querySql");
        String menuid = (String) params.get("menuid");
        String pagetype = (String) params.get("pagetype");//页面类型，下达：issue、反馈：feedback、反馈审核：audit、延期审核：delayaudit、方案上报：planreport、方案审核：planaudit
        String workflow = (String) params.get("workflow");
        String tabcode = (String) params.get("tabcode");
        String tabfilter = (String) params.get("tabfilter");
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
        String wfsql = this.getWfSql(tabcode, workflow);
        if(!StringUtil.isNullOrEmpty(pagetype) && "issue".equals(pagetype)){
            tablecode = problemTaskDAO.PERF_TABLE_PROBLEMTASK;
        }else {
            tablecode = problemTaskDAO.PERF_TABLE_PROBLEMTASKQUERY;
        }
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where");
        if(!StringUtil.isNullOrEmpty(tabcode) && "senddelay".equals(tabcode)){//审批中的延期申请
            sql.append(" extension_status = 1 ");
        } else if(!StringUtil.isNullOrEmpty(tabcode) && "auditdelay".equals(tabcode)){///已审批通过的延期申请
            sql.append(" extension_status = 2 ");
        } else if(!StringUtil.isNullOrEmpty(tabcode) && "tobeissue".equals(tabcode)){///待下达
            sql.append(" issue = 2 ");
        } else if(!StringUtil.isNullOrEmpty(tabcode) && "issued".equals(tabcode)){///已下达
            sql.append(" issue = 1 ");
        } else if(!StringUtil.isNullOrEmpty(tabcode) && "end".equals(tabcode)){//已销号
            sql.append(" is_end = 1 ");
        } else if(!StringUtil.isNullOrEmpty(tabcode) && "all".equals(tabcode)){//全部
            sql.append(" 1=1 ");
        } else {//流程页签条件
            if (wfsql != null && !wfsql.isEmpty()) {
                sql.append(" ( ").append(wfsql);
                if (!StringUtil.isNullOrEmpty(tabcode) && "waitaudit".equals(tabcode) && !StringUtil.isNullOrEmpty(pagetype) && "planreport".equals(pagetype)){
                    sql.append(" or wfstatus is null ");
                }
                sql.append(" )");
            }
        }
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            sql.append(" and (").append(tablesql).append(")");
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            sql.append(" and (").append(tabfilter).append(")");
        }
        sql.append(datarule);
        return sql.toString();
    }

    /**
     * 下达/撤回 不走流程
     * @param params --
     * @return --
     */
    public Map<String, Object> issue(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backmap = new HashMap<String, Object>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        problemTaskDAO.saveAll(datas, problemTaskDAO.PMKPI_TABLE_TMP_GUIDS);
        String actioncode = (String) params.get("actioncode");
        int issue = 2;
        if("issue".equals(actioncode)){//下达
            issue = 1;
            List<Map<String, Object>> tasklist = new ArrayList<Map<String, Object>>();//需要处理数据的总和
            Map<String, Object> taskMap;
            String timestamp = PerfUtil.getServerTimeStamp();
            for (Map<String, Object> map : datas) {
                String agencyStr = (String) map.get("lead_agency");
                String[] agencys = agencyStr.split(",");
                String mainguid = (String) map.get("guid");
                for (String lead_agency : agencys){
                    String newguid = this.getCreateguid();
                    taskMap = new HashMap<>();
                    taskMap.putAll(map); //任务信息放到表中
                    taskMap.put("guid", newguid);
                    taskMap.put("mainguid", mainguid);
                    taskMap.put("createtime", timestamp);
                    taskMap.put("updatetime", timestamp);
                    taskMap.put("creater", SecureUtil.getCurrentUserID());
                    taskMap.put("province", SecureUtil.getUserSelectProvince());
                    taskMap.put("year",SecureUtil.getUserSelectYear());
                    taskMap.put("issue",1);
                    taskMap.put("is_end",2);
                    taskMap.put("agency_code",lead_agency);
                    taskMap.put("lead_agency",lead_agency);
                    //处理 整改时限
                    String start_time = timestamp.substring(0,8);
                    String problemtype = (String) taskMap.get("problemtype");
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
                    LocalDate startDate = LocalDate.parse(start_time, formatter);
                    if(!StringUtil.isNullOrEmpty(problemtype) && "01".equals(problemtype)){
                        LocalDate endDate = startDate.plusDays(60);
                        taskMap.put("rectify_time",endDate.format(formatter));
                    } else if(!StringUtil.isNullOrEmpty(problemtype) && "02".equals(problemtype)){
                        LocalDate endDate = startDate.plusYears(1);
                        taskMap.put("rectify_time",endDate.format(formatter));
                    } else if(!StringUtil.isNullOrEmpty(problemtype) && "03".equals(problemtype)){
                        LocalDate endDate = startDate.plusYears(3);
                        taskMap.put("rectify_time",endDate.format(formatter));
                    }
                    tasklist.add(taskMap);
                }
            }
            //保存反馈数据
            problemTaskDAO.saveAll(tasklist, problemTaskDAO.PERF_TABLE_PROBLEMFEEDBACK);
        }else if("cancelissue".equals(actioncode)){//撤回
            String delsql = " exists(select 1 from " + problemTaskDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.mainguid)";
            problemTaskDAO.delDatas(problemTaskDAO.PERF_TABLE_PROBLEMFEEDBACK, delsql);
        }
        //更新任务数据为已下达
        problemTaskDAO.update("update " + problemTaskDAO.PERF_TABLE_PROBLEMTASK + " t set issue = "+ issue +" where  exists(select 1 from " + problemTaskDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid) ");
        backmap.put("flg","1");
        return backmap;
    }

    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String pagetype = (String) params.get("pagetype");//页面类型，下达：issue、反馈：feedback、反馈审核：audit、延期审核：delayaudit
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = ProblemTaskDAO.PERF_TABLE_PROBLEMFEEDBACK;
        String busguid = (String) params.get("busguid");
        problemTaskDAO.saveAll(datas, problemTaskDAO.PMKPI_TABLE_TMP_GUIDS);
        if ("sendaudit".equals(actioncode) && !StringUtil.isNullOrEmpty(pagetype) && "feedback".equals(pagetype)){//送审 更新上报时间
            problemTaskDAO.update("update " + tablecode + " t set report_time = " + PerfUtil.getServerTimeStamp().substring(0,8) + " where  exists(select 1 from " + problemTaskDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid) ");
        } else if ("cancelaudit".equals(actioncode)) {
            String beforewfstatus = (String) datas.get(0).get("wfstatus");//流程前状态
            if (beforewfstatus != null && "011".equals(beforewfstatus)) {//取消终审 更新销号2
                problemTaskDAO.update("update " + tablecode + " t set is_end = 2 where exists(select 1 from " + problemTaskDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid) ");
            }
        }
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        String wfstatus = (String) datas.get(0).get("wfstatus");//流程后状态
        if (wfstatus != null && "011".equals(wfstatus)) {//终审 更新销号1
            problemTaskDAO.update("update " + tablecode + " t set is_end = 1 where exists(select 1 from " + problemTaskDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid) ");
        }
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        //删除主表数据
        problemTaskDAO.saveAll(deldatas, problemTaskDAO.PMKPI_TABLE_TMP_GUIDS);
        String delsql = " exists(select 1 from " + problemTaskDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
        problemTaskDAO.delDatas(problemTaskDAO.PERF_TABLE_PROBLEMTASK, delsql);
        //删除对应的附件数据
        delsql = " exists(select 1 from " + problemTaskDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.billguid )";
        problemTaskDAO.delDatas(problemTaskDAO.PERF_TABLE_FILE, delsql);
        backMap.put("flg","1");
        return backMap;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String pagetype = (String) params.get("pagetype");//页面类型，下达：issue、反馈：feedback、方案：plan
        String taskguid = (String)params.get("taskguid");
        String mainguid = (String)params.get("mainguid");
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            problemTaskDAO.setYearAndProvince(queryYear, queryProvince);
        }
        if (!StringUtil.isNullOrEmpty(pagetype) && "issue".equals(pagetype)) {//问题页
            mainguid = !StringUtil.isNullOrEmpty(taskguid) ? taskguid : mainguid;
            Map<String, Object>  data = problemTaskDAO.getDataMap(problemTaskDAO.PERF_TABLE_PROBLEMTASK, " t.guid = ? ",new String[]{mainguid});
            if(data.isEmpty()){
                data.put("lead_department",SecureUtil.getCurrentUser().getDivision());
            }
            backMap.put("data", data);
        }else if (!StringUtil.isNullOrEmpty(pagetype) && ("feedback".equals(pagetype) || "plan".equals(pagetype))) {//反馈页、方案页
            Map<String, Object>  data = problemTaskDAO.getDataMap(problemTaskDAO.PERF_TABLE_PROBLEMFEEDBACK, " t.guid = ? ",new String[]{mainguid});
            backMap.put("data", data);
        }
        return backMap;
    }

    /**
     * 保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        String pagetype = (String) params.get("pagetype");//页面类型，下达：issue、反馈：feedback、方案：plan
        String busguid = (String) params.get("busguid");
        String mainguid = (String)params.get("mainguid");
        String workflow = (String)params.get("workflow");
        Map<String, Object> datas = (Map<String, Object>) params.get("datas");
        List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
        String timestamp = PerfUtil.getServerTimeStamp();
        if (!StringUtil.isNullOrEmpty(pagetype) && "issue".equals(pagetype)) {//问题页
            Map<String, Object>  updata = problemTaskDAO.getDataMap(problemTaskDAO.PERF_TABLE_PROBLEMTASK, " t.guid = ? ",new String[]{mainguid});
            if(!updata.isEmpty()){//修改
                updata.putAll(datas);
                updata.put("update_time", timestamp);
                list.add(datas);
                problemTaskDAO.updateByPK(updata, "guid", problemTaskDAO.PERF_TABLE_PROBLEMTASK);
            } else { //新增
                datas.put("guid", mainguid);
                datas.put("creater", SecureUtil.getCurrentUserID());
                datas.put("province", SecureUtil.getUserSelectProvince());
                datas.put("year", SecureUtil.getUserSelectYear());
                datas.put("create_time", timestamp);
                datas.put("update_time", timestamp);
                datas.put("finintorgguid", datas.get("lead_department"));
                list.add(datas);
                problemTaskDAO.save(datas, problemTaskDAO.PERF_TABLE_PROBLEMTASK);
            }
        }else if (!StringUtil.isNullOrEmpty(pagetype) && ("feedback".equals(pagetype) || "plan".equals(pagetype))) {//反馈页、方案页
            Map<String, Object>  updata = problemTaskDAO.getDataMap(problemTaskDAO.PERF_TABLE_PROBLEMFEEDBACK, " t.guid = ? ",new String[]{mainguid});
            if(!updata.isEmpty()){//修改
                updata.putAll(datas);
                updata.put("update_time", timestamp);
                list.add(datas);
                problemTaskDAO.updateByPK(updata, "guid", problemTaskDAO.PERF_TABLE_PROBLEMFEEDBACK);
                String wfid = (String) updata.get("wfid");
                if (StringUtil.isEmpty(wfid) && !StringUtil.isNullOrEmpty(workflow)) {
                    this.workflow("createnosave", workflow, "", problemTaskDAO.PERF_TABLE_PROBLEMFEEDBACK, list);
                }
            }
        }
        return this.auditdefine(list, busguid,"perf", null);
    }

    /**
     * 更新延期.
     * @param params --
     * @return --
     */
    public Map<String, Object> delayupdate(HashMap<String, Object> params) throws AppException {
        String busguid = (String) params.get("busguid");
        String tablecode = problemTaskDAO.PERF_TABLE_PROBLEMFEEDBACK;
        String actioncode = (String)params.get("actioncode");
        int extension_status = 0;//默认不延期
        if(!StringUtil.isNullOrEmpty(actioncode) && "senddelay".equals(actioncode)){//发起延期申请
            extension_status = 1;
        } else if(!StringUtil.isNullOrEmpty(actioncode) && "pass".equals(actioncode)){//延期申请审核通过
            extension_status = 2;
        } else if(!StringUtil.isNullOrEmpty(actioncode) && "back".equals(actioncode)){//延期申请退回
            extension_status = 3;
        } else if(!StringUtil.isNullOrEmpty(actioncode) && "cancelsenddelay".equals(actioncode)){//撤回延期申请
            extension_status = 0;
        }
        Map<String, Object> datas = (Map<String, Object>) params.get("infodata");
        List<Map<String, Object>> selDatas = (List<Map<String, Object>>) params.get("selDatas");
        problemTaskDAO.saveAll(selDatas, problemTaskDAO.PMKPI_TABLE_TMP_GUIDS);
        String selsql = " exists(select 1 from " + problemTaskDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
        List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
        List<Map<String, Object>> updatas = problemTaskDAO.getDatas(tablecode, selsql,null);
        if (updatas != null && updatas.size() > 0) {//修改
            List columns = new ArrayList();
            columns.add("extension_status");
            columns.add("update_time");
            if(!StringUtil.isNullOrEmpty(actioncode) && "senddelay".equals(actioncode)){
                columns.add("extension_reason");
                columns.add("extension_time");
            }
            if(!StringUtil.isNullOrEmpty(actioncode) && "pass".equals(actioncode)){
                columns.add("rectify_time");
            }
            for (Map updata : updatas) {
                Map map = new HashMap();
                map.put("guid", updata.get("guid"));
                if(!StringUtil.isNullOrEmpty(actioncode) && "senddelay".equals(actioncode)){//发起申请时保存原因和延期时间
                    map.put("extension_reason", datas.get("extension_reason"));
                    map.put("extension_time", datas.get("extension_time"));
                } else if(!StringUtil.isNullOrEmpty(actioncode) && "pass".equals(actioncode)){//审核通过更新整改期限
                    map.put("rectify_time", updata.get("extension_time"));
                }
                map.put("extension_status", extension_status);
                map.put("update_time", PerfUtil.getServerTimeStamp());
                list.add(map);
            }
            problemTaskDAO.updateAllByPK(columns, list, "guid", tablecode);//只更新延期字段
        }
        return this.auditdefine(list, busguid,"perf", null);
    }

    /**
     * 查询获取已申报的任务反馈数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getreportdatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        problemTaskDAO.saveAll(datas, problemTaskDAO.PMKPI_TABLE_TMP_GUIDS);
        String checksql = " exists(select 1 from " + problemTaskDAO.PERF_TABLE_PROBLEMFEEDBACK + " a where a.mainguid = t.guid and  a.wfstatus is not null and exists(select 1 from " + problemTaskDAO.PMKPI_TABLE_TMP_GUIDS + " b where a.mainguid=b.guid))";
        List<Map<String, Object>> reportdatas = problemTaskDAO.getDatas(problemTaskDAO.PERF_TABLE_PROBLEMTASK, checksql,null);
        backMap.put("reportdatas", reportdatas);
        return backMap;
    }

    public void smsSendTask() throws AppException {
        // 查询送审上报时间为空（未送审），整改时间距离当前系统时间小于10天的带催办数据
        String checksql = " report_time is null and rectify_time is not null and ABS(to_date(rectify_time,'YYYYMMDD') - SYSDATE) < 10";
        if("polardb".equalsIgnoreCase(DbTypeUtil.getPhysicsDbType())){
            checksql = " report_time is null and rectify_time is not null and date_part('day',to_date(rectify_time,'yyyymmdd') - to_date(to_char(sysdate, 'yyyymmdd'), 'yyyymmdd')) < 10";
        }
        List<Map<String, Object>> reportdatas = problemTaskDAO.getDatas("PERF_T_PROBLEMFEEDBACK", checksql,null);
        logger.info("-----------待催办数："+reportdatas.size());
        // 固定短信话术
        String message = "您在财政预算管理一体化系统中存在还未报送整改结果的整改问题，请您尽快登录系统完成填报。";
        List<Map<String, Object>> smsdatas = new ArrayList<>();// [{userId userCode phoneNumber message}]
        String userId = SecureUtil.getCurrentUser()!= null ? SecureUtil.getCurrentUser().getGuid() : "";
        String userCode = SecureUtil.getCurrentUser()!= null ? SecureUtil.getCurrentUser().getCode() : "";
        for (Map<String, Object> data: reportdatas) {
            Map<String, Object> smsdata = new HashMap<>();
            String phoneNumber = (String) data.get("evaluated_contact");// 联系方式-手机号
            if(!StringUtil.isNullOrEmpty(phoneNumber) && Pattern.matches("^\\d{11}$", phoneNumber)){// 11位数字手机号校验
                smsdata.put("phoneNumber",phoneNumber);
                smsdata.put("message",message);
                smsdata.put("userId",userId);
                smsdata.put("userCode",userCode);
                smsdatas.add(smsdata);
            }
        }
        SmsService smsService = (SmsService) PerfServiceFactory.getBean("pmkpi.perfcommon.smssend.SmsService");
        smsService.smsSend(smsdatas);
    }

}
