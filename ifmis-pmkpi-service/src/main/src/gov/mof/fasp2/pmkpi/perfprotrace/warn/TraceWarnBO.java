package gov.mof.fasp2.pmkpi.perfprotrace.warn;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TraceWarnBO extends PmkpiBO {
    private TraceWarnDAO traceWarnDAO;

    public void setTraceWarnDAO(TraceWarnDAO traceWarnDAO) {
        this.traceWarnDAO = traceWarnDAO;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        String tablecode = (String)parms.get("tablecode");
        String tablesql = (String) parms.get("tablesql"); //页签过滤sql
        String mainguid = (String) parms.get("mainguid");
        String proguid = (String) parms.get("proguid");
        String taskguid = (String) parms.get("taskguid");
        String bustype = (String) parms.get("bustype");
        String saveAgency = (String) parms.get("saveAgency");
        String procode = (String) parms.get("procode");
        String viewtype = (String) parms.get("viewtype");//查询状态
        String queryYear = (String)parms.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)parms.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            traceWarnDAO.setYearAndProvince(queryYear, queryProvince);
        }
        String type = "";
        if ("depttrace".equals(bustype)) {
            type = "dept";
        } else if ("protrace".equals(bustype)) {
            type = "project";
        }
        String sql = " mainguid='" + mainguid + "'";
        if (!StringUtil.isEmpty(tablesql)) {
            sql += " and " + tablesql;
        }
        List<Map<String, Object>> bgtfundList = traceWarnDAO.getDatas(tablecode, sql, " order by ordernum");
        float taskstage = 0;
        Map<String, Object> taskMap = traceWarnDAO.getTaskData(taskguid);
        taskstage = Float.parseFloat((String) taskMap.get("taskstage"));
        if(!"query".equals(viewtype)) {//查询状态不加载暂存数据
            //业务表无数据，查询有暂存返回暂存
            if (bgtfundList == null || bgtfundList.size() <= 0) {
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                Map<String, Object> param2 = new HashMap<>();
                param2.put("mainguid",mainguid);
                param2.put("url",parms.get("url2"));
                param2.put("compconfigid",parms.get("compconfigid2"));
                Map<String, Object> midsavedata = perfMidsaveBO.getMidData(param2);
                if(midsavedata!=null && midsavedata.get("result")!=null){
                    bgtfundList = (List<Map<String, Object>>) midsavedata.get("result");
                }
            }else{
                backMap.put("hidButtons", "暂存");
            }
        }
        //业务表无数据，视图取数
        if (bgtfundList == null || bgtfundList.size() <= 0) {
            //视图取数
            String month = (String) taskMap.get("taskstage");
            StringBuffer sqlbufer = new StringBuffer();
            if ("project".equals(type)) {
                sqlbufer.append(" PERF_FUNDPAY_VIEW.set_month('").append(month).append("') = '").append(month)
                        .append("' and PERF_FUNDPAY_VIEW.set_procode('").append(procode).append("')='").append(procode).append("'");
            } else if ("dept".equals(type)) {
                sqlbufer.append(" PERF_FUNDPAY_VIEW.set_month('").append(month).append("') = '").append(month)
                        .append("' and PERF_FUNDPAY_VIEW.set_agencyguid('").append(saveAgency).append("')='").append(saveAgency).append("'");
            }
            bgtfundList = traceWarnDAO.getDatas("v_perf_fund_" + type, sqlbufer.toString() , " order by ordernum");
        }
        if (bgtfundList.size()>0) {
            backMap.put("data", bgtfundList);
        }
        float num = PerfUtil.rideTwoNum(PerfUtil.delTwoNum(taskstage, 12, 4), 100);
        backMap.put("standard", num);
        tablecode = "";
        String wheresql = "mainguid='" + proguid + "'";
        if ("depttrace".equals(bustype)) {
            tablecode = "v_bgt_perf_goal_info";
        } else if (PerfUtil.getIsHbei() && "protrace".equals(bustype)) {
            tablecode = "v_pm_perf_goal_info";
        } else if ("protrace".equals(bustype)) {
            tablecode = "v_pm_perf_goal_info";
            wheresql = "pro_code='" + procode + "'";
        }
        if ("protrace".equals(bustype)) {
            wheresql += " and yearflag='0' ";
        }
        Map<String, Object> goalMap = traceWarnDAO.getDataMap(tablecode, wheresql);
        String ndgoal = (String) goalMap.get("kpi_target");
        Map<String, Object> analysisMap = this.getAnalysisinfo("v_perf_t_protraceanalysis", mainguid);
        //业务表无数据，查询有暂存返回暂存
        if(!"query".equals(viewtype)) {//查询状态不加载暂存数据
            //业务表无数据，查询有暂存返回暂存
            if(analysisMap.isEmpty()){
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                Map<String, Object> param1 = new HashMap<>();
                param1.put("mainguid",mainguid);
                param1.put("url",parms.get("url1"));
                param1.put("compconfigid",parms.get("compconfigid1"));
                Map<String, Object> midsavedata = perfMidsaveBO.getMidData(param1);
                if(midsavedata!=null && midsavedata.get("result")!=null){
                    analysisMap = (Map<String, Object>) midsavedata.get("result");
                }
            }
        }
        analysisMap.put("ndgoal", ndgoal);
        backMap.put("goalinfo", analysisMap);
        return backMap;
    }

    /**
     * 最终保存方法.
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveData(HashMap<String, Object> params) throws AppException {
        String mainguid = (String) params.get("mainguid");
        String busguid = (String) params.get("busguid");
        String tablecode = (String) params.get("tablecode");
        String saveAgency = (String) params.get("saveAgency");
        String bustype = (String) params.get("bustype");
        String protype = (String) params.get("protype");
        List<Map<String, Object>> fundList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        Map<String, Object> infodata = (Map<String, Object>) params.get("infodata");
        params.put("isperfgoal", infodata.get("isgoal") + "");
        int j = 0;
        for (Map<String, Object> map : datas) {
            j++;
            map.put("ordernum", j);
            map.put("province", CommonUtil.getProvince());
            map.put("guid", this.getCreateguid());
            map.put("creater", SecureUtil.getCurrentUser().getGuid());
            map.put("year", CommonUtil.getYear());
            map.put("agencyguid", saveAgency);
            map.put("agency_code", saveAgency);
            map.put("mainguid", mainguid);
            map.put("create_time", PerfUtil.getServerTimeStamp());
            map.put("update_time", PerfUtil.getServerTimeStamp());
            map.put("mof_div_code", SecureUtil.getUserSelectProvince());
            map.put("fiscal_year", CommonUtil.getYear());
            map.put("is_deleted", 2);
            fundList.add(map);
        }
        //删除保存
        String delsql = " mainguid='" + mainguid + "'";
        traceWarnDAO.delDatas(tablecode, delsql);
        traceWarnDAO.saveAll(fundList, tablecode);
        tablecode = "v_perf_t_protraceanalysis";
        Map<String, Object> analysisMap = this.getAnalysisinfo(tablecode, mainguid);
        if (analysisMap.isEmpty()) {
            analysisMap.putAll(infodata);
            analysisMap.put("province", CommonUtil.getProvince());
            analysisMap.put("guid", this.getCreateguid());
            analysisMap.put("creater", SecureUtil.getCurrentUser().getGuid());
            analysisMap.put("year", CommonUtil.getYear());
            analysisMap.put("agencyguid", saveAgency);
            analysisMap.put("mainguid", mainguid);
            analysisMap.put("create_time", PerfUtil.getServerTimeStamp());
            analysisMap.put("update_time", PerfUtil.getServerTimeStamp());
            analysisMap.put("agency_code", saveAgency);
            analysisMap.put("mof_div_code", SecureUtil.getUserSelectProvince());
            analysisMap.put("fiscal_year", CommonUtil.getYear());
            analysisMap.put("is_deleted", 2);
            traceWarnDAO.save(analysisMap, tablecode);
        } else {
            analysisMap.putAll(infodata);
            traceWarnDAO.update(analysisMap, tablecode);
        }
        if ("ordprogram".equals(protype)) {
            //预警规则进行处理
            if ("depttrace".equals(bustype)) {
                params.put("warmtype", "depttracewarn");
            } else if ("protrace".equals(bustype)) {
                params.put("warmtype", "protracewarn");
            }
            String bgtwarn = this.getWarn(params);
            traceWarnDAO.update("update " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " t set t.bgtwarn='" + bgtwarn + "' where t.guid='" + mainguid + "'");
        }
        //保存业务数据结束删除暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delTabData2(params);
        return this.auditdefine(fundList, busguid,"perf", null);
    }

    /**
     * 获取监控分析数据.
     * @return
     */
    public Map<String, Object> getAnalysisinfo(String tablecode, String mainguid) {
        return traceWarnDAO.getDataMap(tablecode, " mainguid='" + mainguid + "'");
    }
}
