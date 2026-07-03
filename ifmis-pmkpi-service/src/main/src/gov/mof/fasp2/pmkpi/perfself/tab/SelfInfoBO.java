package gov.mof.fasp2.pmkpi.perfself.tab;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.datacommon.common.util.StringUtils;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 */
public class SelfInfoBO extends PmkpiBO {
    private SelfInfoDAO selfInfoDAO;

    public void setSelfInfoDAO(SelfInfoDAO selfInfoDAO) {
        this.selfInfoDAO = selfInfoDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String)params.get("mainguid");
        String tablecode = "v_perf_t_evaluateinfo";
        String bustype = (String)params.get("bustype");
        String wheresql = " t.mainguid = '" + mainguid + "'";
        String selfwheresql = " t.guid = '" + mainguid + "'";
        String saveAgency = (String)params.get("saveAgency");
        String viewtype = (String) params.get("viewtype");//查询状态
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            selfInfoDAO.setYearAndProvince(queryYear, queryProvince);
        }
        Map<String, Object>  selfdata = selfInfoDAO.getDataMap("V_PERF_T_SELFEVALTASK", selfwheresql);
        Map<String, Object>  data = selfInfoDAO.getDataMap(tablecode, wheresql);
        if(!"query".equals(viewtype)) {//查询状态不加载暂存数据
            //业务表无数据，查询有暂存返回暂存
            if(data.isEmpty()){
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
                if(midsavedata!=null && midsavedata.get("result")!=null){
                    data = (Map<String, Object>) midsavedata.get("result");
                }
            }else{
                backMap.put("hidButtons", "暂存");
            }
        }
        HashMap<String, Object> selfMap = new HashMap<>();
        selfMap.put("mainguid", mainguid);
        // 自评结论
        selfMap.put("warmtype", "selfresult" + bustype);
        String selfresult = this.getWarn(selfMap);
        if (StringUtils.isNotEmpty(selfresult)) {
            data.put("grade", selfresult);
        }
        //自评得分
        SelfIndexBO selfIndexBO = (SelfIndexBO) ServiceFactory.getBean("pmkpi.perfSelf.SelfIndexBOTX");
        //判断当前是否启用了权重比例模式
        if("program".equals(bustype) && selfIndexBO.isRatio()){
            selfMap.put("warmtype", "selfratioscore" + bustype);
        }else{
            selfMap.put("warmtype", "selfscore" + bustype);
        }
        selfMap.put("agencyguid", saveAgency);
        String score = this.getWarn(selfMap);
        if (StringUtils.isNotEmpty(score)) {
            data.put("score", score);
        }
        //百分位值
        selfMap.put("warmtype", "selfpercentile" + bustype);
        String percentile = this.getWarn(selfMap);
        if (StringUtils.isNotEmpty(percentile)) {
            data.put("percentile", percentile);
        }
        //项目名称/部门名称
        data.put("name", selfdata.isEmpty() ? null : selfdata.get("name"));
        //资金性质
        selfMap.put("warmtype", "selffundtype" + bustype);
        String fund_type_code = this.getWarn(selfMap);
        if (StringUtils.isNotEmpty(fund_type_code) && !"null".equals(fund_type_code)) {
            data.put("fund_type_code", fund_type_code);
        }
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //表名
        String busguid = (String) params.get("busguid");
        String projguid = (String)params.get("projguid");
        String mainguid = (String)params.get("mainguid");
        String tablecode = (String)params.get("tablecode"); //保存的数据表
        String procode = (String) params.get("procode"); //项目code
        String bustype = (String) params.get("bustype");
        //全部数据
        Map<String, Object> datas = (Map<String, Object>) params.get("datas");
        String wheresql = " t.mainguid = '" + mainguid + "'";
        Map<String, Object>  map = selfInfoDAO.getDataMap(tablecode, wheresql);
        if (!map.isEmpty()) {//修改
            map.putAll(datas);
            map.put("updatetime", PerfUtil.getServerTimeStamp());
            map.put("pro_code", procode); //项目code
            selfInfoDAO.update(map, tablecode);
        } else { //新增
            datas.put("guid", this.getCreateguid());
            datas.put("creater", SecureUtil.getCurrentUserID());
            datas.put("province", SecureUtil.getUserSelectProvince());
            datas.put("year", CommonUtil.getYear());
            datas.put("createtime", PerfUtil.getServerTimeStamp());
            datas.put("updatetime", PerfUtil.getServerTimeStamp());
            datas.put("mainguid", mainguid);
            datas.put("projguid", projguid);
            datas.put("pro_code", procode); //项目code
            datas.put("is_deleted", 2);
            datas.put("bustype", bustype);
            selfInfoDAO.save(datas, tablecode);
        }
        List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
        list.add(datas);
        return this.auditdefine(list, busguid,"perf", null);
    }
}
