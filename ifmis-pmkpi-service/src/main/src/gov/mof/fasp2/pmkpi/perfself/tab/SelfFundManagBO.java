package gov.mof.fasp2.pmkpi.perfself.tab;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class SelfFundManagBO extends PmkpiBO {
    private SelfFundManagDAO selfFundManagDAO;

    public void setSelfFundManagDAO(SelfFundManagDAO selfFundManagDAO) {
        this.selfFundManagDAO = selfFundManagDAO;
    }

	/**
	 * 查询数据方法
	 * @param params -- 参数集合.
	 * @return
	 * @throws AppException ---自定义异常.
	 */
	public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
		Map<String, Object> backMap = new HashMap<String, Object>();
		String procode = (String)params.get("procode"); //项目编码
		String tablesql = (String)params.get("tablesql");
		String tablecode = (String)params.get("tablecode"); //表
		String bustype = (String) params.get("bustype");
		String mainguid = (String)params.get("mainguid");
		String saveAgency = (String)params.get("saveAgency"); //单位.
		String viewtype = (String) params.get("viewtype");//查询状态
		String sql = " mainguid='" + mainguid + "' ";
		if (!StringUtil.isEmpty(tablesql)) {
			sql += " and " + tablesql;
		}
		List<Map<String, Object>> bgtfundList = selfFundManagDAO.getDatas(tablecode, sql, " order by code");
		//存在业务数据直接进行返回
		if (bgtfundList != null && bgtfundList.size() > 0) {
			backMap.put("data", bgtfundList);
			backMap.put("hidButtons", "暂存");
			return backMap;
		}
		if(!"query".equals(viewtype)) {//查询状态不加载暂存数据
			//业务表无数据，查询有暂存返回暂存
			PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
			Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
			if(midsavedata!=null && midsavedata.get("result")!=null){
				backMap.put("data", midsavedata.get("result"));
				return backMap;
			}
		}
		StringBuffer sqlbufer = new StringBuffer();
		//视图取数
        List<Map<String, Object>>  data = selfFundManagDAO.getDatas("v_perf_enum", "t.elementcode='FUNDMANAG'", " order by ordernum");
		backMap.put("data", data);
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
		String pro_code = (String) params.get("pro_code");
		String bgtget1 = params.get("bgtget") + "";
		BigDecimal bgtget = new BigDecimal(StringUtil.isNullOrEmpty(bgtget1) ? "0.00" : bgtget1);
		String sbgtget = bgtget.toString();
		List<Map<String, Object>> fundList = new ArrayList<>();
		List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
		int j = 0;
		for (Map<String, Object> map : datas) {
			j++;
			map.put("province", CommonUtil.getProvince());
			map.put("guid", this.getCreateguid());
			map.put("creater", SecureUtil.getCurrentUser().getGuid());
			map.put("year", CommonUtil.getYear());
			map.put("mainguid", mainguid);
			map.put("pro_code", pro_code);
			map.put("create_time", PerfUtil.getServerTimeStamp());
			map.put("update_time", PerfUtil.getServerTimeStamp());
			map.put("mof_div_code", SecureUtil.getUserSelectProvince());
			map.put("fiscal_year", CommonUtil.getYear());
			map.put("is_deleted", 2);
			fundList.add(map);
		}
		//删除保存
		String delsql = " mainguid='" + mainguid + "'";
		selfFundManagDAO.delDatas(tablecode, delsql);
		selfFundManagDAO.saveAll(fundList, tablecode);
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
