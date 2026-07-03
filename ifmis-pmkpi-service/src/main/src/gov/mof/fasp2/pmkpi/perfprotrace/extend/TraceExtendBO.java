package gov.mof.fasp2.pmkpi.perfprotrace.extend;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TraceExtendBO extends PmkpiBO {
    private TraceExtendDAO traceExtendDAO;

    public void setTraceExtendDAO(TraceExtendDAO traceExtendDAO) {
        this.traceExtendDAO = traceExtendDAO;
    }

    /**
     * 查询数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        String orderby = (String) params.get("orderby");
        String wheresql = "";
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        String tablesql = (String) params.get("tablesql");
        String viewtype = (String) params.get("viewtype");//查询状态
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            traceExtendDAO.setYearAndProvince(queryYear, queryProvince);
            wheresql = " t.mainguid = '" + mainguid + "' ";
        }else{
            wheresql = " t.mainguid = '" + mainguid + "' and province = '"+province+"' and year = "+year+"";
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            wheresql += tablesql;
        }
        if (tablecode != null && !tablecode.isEmpty()) {
            tablecode = "V_PERF_T_SXPROTRACEEXTEND";
        }
        List<Map<String, Object>> data = traceExtendDAO.getDatas(tablecode, wheresql, orderby);
        if(!"query".equals(viewtype)) {//查询状态不加载暂存数据
            if(data == null || data.size() == 0){
                //业务表无数据，查询有暂存返回暂存
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
                if(midsavedata!=null && midsavedata.get("result")!=null){
                    data = (List<Map<String, Object>>) midsavedata.get("result");
                }
            }else{
                backMap.put("hidButtons", "暂存");
            }
        }
        if (data == null || data.size() == 0) {//无数据则取模板数据
            String sql = "select t.GUID,t.CONTENT,t.SITUATION,t.PROBLEM,t.REASON,t.CREATETIME,t.UPDATETIME,t.CREATER, '"+province+"' as PROVINCE, "+year+" as YEAR, '"+mainguid+"' as MAINGUID,'add' as rowtype from PERF_T_SXPROTRACEEXTEND t where province = '87' and year = 2016";
            logger.info("查询sql输出--无数据取模板数据--------" + sql);
            data = traceExtendDAO.queryForList(sql);
        }
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");

        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("guid",this.getCreateguid());
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("mainguid", mainguid);
                addlist.add(map);
            } else {
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            traceExtendDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            traceExtendDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            traceExtendDAO.saveAll(deldatas, traceExtendDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + traceExtendDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            traceExtendDAO.delDatas(tablecode, delsql);
        }
        //保存业务数据结束删除暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delTabData(params);
        return this.auditdefine(datas, busguid,"perf", null);
    }
}
