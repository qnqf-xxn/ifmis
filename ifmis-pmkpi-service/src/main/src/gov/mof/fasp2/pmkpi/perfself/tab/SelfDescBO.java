package gov.mof.fasp2.pmkpi.perfself.tab;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:45 2020/8/24  chongdayong
 */
public class SelfDescBO extends PmkpiBO {
    private SelfDescDAO selfDescDAO;

    public void setSelfDescDAO(SelfDescDAO selfDescDAO) {
        this.selfDescDAO = selfDescDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String projguid = (String)params.get("projguid");
        String procode = (String)params.get("procode");
        String mainguid = (String)params.get("mainguid");
        String tablecode = "v_perf_t_selfperfdesc";
        String bustype = (String)params.get("bustype");
        String wheresql = " t.mainguid = '" + mainguid + "'";
        String saveAgency = (String)params.get("saveAgency");
        String viewtype = (String) params.get("viewtype");//查询状态
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            selfDescDAO.setYearAndProvince(queryYear, queryProvince);
        }
        String goaltablecode = "";
        StringBuffer querysql = new StringBuffer("");
        Boolean flag = PerfUtil.getIsHbei();
        if ("dept".equals(bustype) || flag || "parentprogram".equals(bustype)) {
            goaltablecode = "v_bgt_perf_goal_info";
            querysql.append(" t.mainguid = '").append(projguid).append("'");
        } else {
            goaltablecode = "v_pm_perf_goal_info";
            querysql.append(" t.pro_code = '").append(procode).append("'");
        }
        if ("program".equals(bustype) || "transprogram".equals(bustype)) {
            querysql.append(" and t.yearflag = '0'");
        }
        if ("parentprogram".equals(bustype)) {//一级项目，查询总体目标
            goaltablecode = "pm_perf_goal_info";
            querysql.append(" and t.yearflag = '1' and is_deleted=2 and is_backup=2 and province='").append(SecureUtil.getUserSelectProvince()).append("'");
        }
        Map<String, Object> goalMap = this.getDataMap(goaltablecode, querysql.toString());
        Map<String, Object>  data = selfDescDAO.getDataMap(tablecode, wheresql);
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
        String type = bustype;
        if ("transprogram".equals(bustype) || "parentprogram".equals(bustype)) {
            type = "program";
        }
        HashMap<String, Object> selfMap = new HashMap<>();
        selfMap.put("mainguid", mainguid);
        // 自评结论
        selfMap.put("warmtype", "selfresult" + type);
        String selfresult = this.getWarn(selfMap);
        data.put("selfresult", selfresult);
        //自评得分
        SelfIndexBO selfIndexBO = (SelfIndexBO) ServiceFactory.getBean("pmkpi.perfSelf.SelfIndexBOTX");
        //判断当前是否启用了权重比例模式
        if("program".equals(type) && selfIndexBO.isRatio() && PerfUtil.getIS_HUBEI()){
            selfMap.put("warmtype", "selfratioscore" + type);
        } else {
            selfMap.put("warmtype", "selfscore" + type);
        }
        selfMap.put("agencyguid", saveAgency);
        String score = this.getWarn(selfMap);
        data.put("score", score);
        if (PerfUtil.getIsGuangXi()) {
            selfMap.put("warmtype", "selfbgtrate" + type);
            String bgtrate = this.getWarn(selfMap);
            data.put("bgtrate", bgtrate);
        }
        data.put("yeargoal", goalMap.get("kpi_target"));
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
        //全部数据
        Map<String, Object> datas = (Map<String, Object>) params.get("datas");
        Map map = null;
        List<Map> updatas = selfDescDAO.getByGuid(tablecode, mainguid, null);
		if (updatas != null && updatas.size() > 0) {//修改
			map = updatas.get(0);
			map.putAll(datas);
			map.put("updatetime", PerfUtil.getServerTimeStamp());
            map.put("pro_code", procode); //项目code
			selfDescDAO.updateByPK(map, "guid", tablecode);
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
            selfDescDAO.save(datas, tablecode);
        }
        List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
        list.add(datas);
        //保存业务数据结束删除暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delTabData(params);
        return this.auditdefine(list, busguid,"perf", null);
    }

}
