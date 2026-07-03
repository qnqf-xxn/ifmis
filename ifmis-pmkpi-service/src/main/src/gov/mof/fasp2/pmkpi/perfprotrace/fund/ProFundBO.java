package gov.mof.fasp2.pmkpi.perfprotrace.fund;

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

public class ProFundBO extends PmkpiBO {
    private ProFundDAO proFundDAO;

    public void setProFundDAO(ProFundDAO proFundDAO) {
        this.proFundDAO = proFundDAO;
    }

    /**
     * 查询数据方法
     * @param parms -- 参数集合.
     * @return
     * @throws AppException ---自定义异常.
     */
    public Map<String, Object> getPayDatas(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode = (String)parms.get("tablecode");
        String tablesql = (String) parms.get("tablesql"); //页签过滤sql
        String mainguid = (String) parms.get("mainguid");
        String proguid = (String) parms.get("proguid"); //项目的guid 匹配有误，改为用procode
        String procode = (String) parms.get("procode"); //项目编码.
        String taskguid = (String) parms.get("taskguid");
        String bustype = (String) parms.get("bustype");
        String saveAgency = (String) parms.get("saveAgency");
        String viewtype = (String) parms.get("viewtype");//查询状态
        String type = "";
        String isZJ = PerfUtil.getSystemSet("isZJ");
        String isSX = PerfUtil.getSystemSet("isSX");
        String bgtsource = (String) parms.get("bgtsource");
        String queryYear = (String)parms.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)parms.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            proFundDAO.setYearAndProvince(queryYear, queryProvince);
        }
        if (bustype != null && "depttrace".equals(bustype)) {
            type = "dept";
        } else if (bustype != null && "protrace".equals(bustype)) {
            type = "project";
        }
        String sql = " mainguid='" + mainguid + "'";
        if (!StringUtil.isEmpty(tablesql)) {
            sql += " and " + tablesql;
        }
        if("1".equals(isSX) && "dept".equals(type)){
            sql += " and bgtsource = '"+bgtsource+"' ";
        }
        List<Map<String, Object>> bgtfundList = proFundDAO.getDatas(tablecode, sql, " order by ordernum");
        //存在业务数据直接进行返回
        if (bgtfundList != null && bgtfundList.size() > 0) {
            bgtfundList.get(0).put("hidButtons", "暂存");
            backMap.put("data", bgtfundList);
            backMap.put("hidButtons","暂存");
            return backMap;
        }
        if(!"query".equals(viewtype)) {//查询状态不加载暂存数据
            //业务表无数据，查询有暂存返回暂存
            PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
            Map<String, Object> midsavedata = perfMidsaveBO.getMidData(parms);
            if(midsavedata!=null && midsavedata.get("result")!=null){
                backMap.put("data", (List<Map<String, Object>>) midsavedata.get("result"));
                return backMap;
            }
        }
        //视图取数
        Map<String, Object> taskMap = proFundDAO.getTaskData(taskguid);
        //取数月份.
        String month = (String) taskMap.get("taskstage");
        StringBuffer sqlbufer = new StringBuffer();
        Boolean flag = PerfUtil.getIsHbei();
        proFundDAO.setProfundParams(procode, proguid, saveAgency, month);
        if ("project".equals(type)) {
            if (flag) { // 河北按照proguid
                sqlbufer.append(" proguid='" ).append(proguid).append("' ");
            }else if("1".equals(isZJ)){
                sqlbufer.append(" taskguid ='").append(taskguid).append("' and pro_code = '").append(procode).append("'");
            }
        } else if ("dept".equals(type)) {
            if("1".equals(isZJ)){
                sqlbufer.append(" month <=").append(month).append(" and agencyguid = '").append(saveAgency).append("'");
            }else if(flag){
                sqlbufer.append(" agencyguid='").append(saveAgency).append("' ");
            }else if("1".equals(isSX)){
                sqlbufer.append(" bgtsource = '").append(bgtsource).append("'");
            }
        }
        bgtfundList = proFundDAO.getDatas("v_perf_fund_" + type, sqlbufer.toString() , " order by ordernum");
        if("1".equals(isZJ) && bgtfundList.size() == 0){
            bgtfundList = proFundDAO.getDatas("PERF_T_PROBGTFUND", "guid = 'zjjcsj330000000' ", "order by ordernum");
            backMap.put("data", bgtfundList);
            return backMap;
        }
        backMap.put("data", bgtfundList);
        return backMap;
    }

    /**R
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
        List<Map<String, Object>> fundList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
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
        proFundDAO.delDatas(tablecode, delsql);
        proFundDAO.saveAll(fundList, tablecode);
        //预警规则进行处理
        params.put("warmtype","bgttracewarn");
        String bgtwarn = this.getWarn(params);
        proFundDAO.update("update " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " t set t.bgtwarn='" + bgtwarn + "' where t.guid='" + mainguid + "'");
        //偏离度
        params.put("warmtype","gzfunddeviate");
        String gzfunddeviate = this.getWarn(params);
        proFundDAO.update("update " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " t set t.gzfunddeviate='" + gzfunddeviate + "' where t.guid='" + mainguid + "'");
        if(PerfUtil.getIsHbei()){
            proFundDAO.update("update V_PERF_T_PROTRACEANALYSIS t set t.bgtdeviate='" + gzfunddeviate + "' where t.mainguid='" + mainguid + "'");
            proFundDAO.update("update V_PERF_T_PROTRACEANALYSIS t set t.bgtwarn='" + bgtwarn + "' where t.mainguid='" + mainguid + "'");
        }
        //保存业务数据结束删除暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        String ismidsave2 = (String) params.get("ismidsave2");
        if(ismidsave2!=null && "true".equals(ismidsave2)){
            perfMidsaveBO.delTabData2(params);
        }else{
            perfMidsaveBO.delTabData(params);
        }
        return this.auditdefine(fundList, busguid,"perf", null);
    }

}
