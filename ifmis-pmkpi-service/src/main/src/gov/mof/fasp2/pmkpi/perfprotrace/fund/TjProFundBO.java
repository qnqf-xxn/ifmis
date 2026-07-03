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

public class TjProFundBO extends PmkpiBO {
    private TjProFundDAO tjProFundDAO;

    public void setTjProFundDAO(TjProFundDAO tjProFundDAO) {
        this.tjProFundDAO = tjProFundDAO;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public List<Map<String, Object>> getDatas(HashMap<String, Object> parms) throws AppException {
        String tablecode = (String)parms.get("tablecode");
        String tablesql = (String) parms.get("tablesql"); //页签过滤sql
        String mainguid = (String) parms.get("mainguid");
        String procode = (String) parms.get("procode"); //项目编码.
        String taskguid = (String) parms.get("taskguid");
        String saveAgency = (String) parms.get("saveAgency");
        String viewtype = (String) parms.get("viewtype");//查询状态
        String queryYear = (String)parms.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)parms.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            tjProFundDAO.setYearAndProvince(queryYear, queryProvince);
        }
        String sql = " mainguid='" + mainguid + "'";
        if (!StringUtil.isEmpty(tablesql)) {
            sql += " and " + tablesql;
        }
        List<Map<String, Object>> bgtfundList = tjProFundDAO.getDatas(tablecode, sql, " order by ordernum");
        //存在业务数据直接进行返回
        if (bgtfundList != null && bgtfundList.size() > 0) {
            bgtfundList.get(0).put("hidButtons", "暂存");
            return bgtfundList;
        }
        if(!"query".equals(viewtype)) {//查询状态不加载暂存数据
            //业务表无数据，查询有暂存返回暂存
            PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
            Map<String, Object> midsavedata = perfMidsaveBO.getMidData(parms);
            if(midsavedata!=null && midsavedata.get("result")!=null){
                return (List<Map<String, Object>>) midsavedata.get("result");
            }
        }
        //视图取数
        Map<String, Object> taskMap = tjProFundDAO.getTaskData(taskguid);
        //取数月份.
        String month = (String) taskMap.get("taskstage");
        tjProFundDAO.setProfundParams(procode, null, saveAgency, month);
        bgtfundList = tjProFundDAO.getDatas("v_perf_fund_tj", null , " order by ordernum");
        return bgtfundList;
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
                map.put("update_time", PerfUtil.getServerTimeStamp());
                map.put("create_time", PerfUtil.getServerTimeStamp());
                map.put("mof_div_code", SecureUtil.getUserSelectProvince());
                map.put("fiscal_year", CommonUtil.getYear());
                map.put("is_deleted", 2);
            fundList.add(map);
        }
        //删除保存
        String delsql = " mainguid='" + mainguid + "'";
        tjProFundDAO.delDatas(tablecode, delsql);
        tjProFundDAO.saveAll(fundList, tablecode);
        //预警规则进行处理
        params.put("warmtype","bgttracewarn");
        String bgtwarn = this.getWarn(params);
        tjProFundDAO.update("update " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " t set t.bgtwarn='" + bgtwarn + "' where t.guid='" + mainguid + "'");
        //偏离度
        params.put("warmtype","gzfunddeviate");
        String gzfunddeviate = this.getWarn(params);
        tjProFundDAO.update("update " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " t set t.gzfunddeviate='" + gzfunddeviate + "' where t.guid='" + mainguid + "'");
        //保存业务数据结束删除暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delTabData(params);
        return this.auditdefine(fundList, busguid,"perf", null);
    }

}
