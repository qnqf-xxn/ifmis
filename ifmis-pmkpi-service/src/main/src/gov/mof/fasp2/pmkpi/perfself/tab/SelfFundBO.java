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

/**
 * @Description:
 * @Revision History:
 * @Revision 16:45 2020/8/24  chongdayong
 */
public class SelfFundBO extends PmkpiBO {
    private SelfFundDAO selfFundDAO;

    public void setSelfFundDAO(SelfFundDAO selfFundDAO) {
        this.selfFundDAO = selfFundDAO;
    }

	/**
	 * 查询数据方法
	 * @param params -- 参数集合.
	 * @return
	 * @throws AppException ---自定义异常.
	 */
	public Map<String, Object> getPayDatas(HashMap<String, Object> params) throws AppException {
		String  isZJ = PerfUtil.getSystemSet("isZJ");
		String isSX = PerfUtil.getSystemSet("isSX");
		Map<String, Object> backMap = new HashMap<String, Object>();
		String proguid = (String)params.get("projguid");
		String procode = (String)params.get("procode"); //项目编码
		String tablesql = (String)params.get("tablesql");
		String tablecode = (String)params.get("tablecode"); //表
		String bustype = (String) params.get("bustype");
		String mainguid = (String)params.get("mainguid");
		String saveAgency = (String)params.get("saveAgency"); //单位.
		String viewtype = (String) params.get("viewtype");//查询状态
		String queryYear = (String)params.get("queryYear");//跨年查询查询年度
		String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
		if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
			selfFundDAO.setYearAndProvince(queryYear, queryProvince);
		}
		String type = "";
		String sql = " mainguid='" + mainguid + "' ";
		String bgtsource = (String) params.get("bgtsource");
		if (!StringUtil.isEmpty(tablesql)) {
			sql += " and " + tablesql;
		}
		if("1".equals(isSX) && "dept".equals(bustype)){
			sql += " and bgtsource = '"+bgtsource+"' ";
		}
		List<Map<String, Object>> bgtfundList = selfFundDAO.getDatas("v_perf_t_selfprofund", sql, " order by ordernum");
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
		selfFundDAO.setProfundParams(procode, proguid, saveAgency, "12");
		StringBuffer sqlbufer = new StringBuffer();
		if ("program".equals(bustype) || "transprogram".equals(bustype)) { //项目支出
			if ("transprogram".equals(bustype)) {
				type = "transprogram";
			} else {
				type = "project";
			}
		} else if ("dept".equals(bustype)) {//部门整体
			type = "dept";
			if("1".equals(isSX)) {
				sqlbufer.append(" bgtsource = '").append(bgtsource).append("'");
			}
		} else if("parentprogram".equals(bustype)) {
			type = "parentprogram";
		}
		//视图取数
		tablecode = "V_PERF_SELFBDGPAY_"+ type;
        List<Map<String, Object>>  data = selfFundDAO.getDatas(tablecode, sqlbufer.toString(), " order by ordernum");
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
			map.put("ordernum", j);
			map.put("province", CommonUtil.getProvince());
			map.put("guid", this.getCreateguid());
			map.put("creater", SecureUtil.getCurrentUser().getGuid());
			map.put("year", CommonUtil.getYear());
			map.put("agencyguid", saveAgency);
			map.put("mainguid", mainguid);
			map.put("pro_code", pro_code);
			map.put("create_time", PerfUtil.getServerTimeStamp());
			map.put("update_time", PerfUtil.getServerTimeStamp());
			map.put("agency_code", saveAgency);
			map.put("mof_div_code", SecureUtil.getUserSelectProvince());
			map.put("fiscal_year", CommonUtil.getYear());
			map.put("is_deleted", 2);
			fundList.add(map);
		}
		//删除保存
		String delsql = " mainguid='" + mainguid + "'";
		selfFundDAO.delDatas(tablecode, delsql);
		selfFundDAO.saveAll(fundList, tablecode);
		SelfDescDAO selfDescDAO = (SelfDescDAO) PerfServiceFactory.getBean("pmkpi.perfSelf.SelfDescDAO");
		//更新得分
		selfDescDAO.updateDescScore(mainguid, bustype);
		//项目更新指标完成情况
		selfDescDAO.updateBgtget(sbgtget, mainguid);
		// 新增天津模式需要调用单独的更新方法
		if(PerfUtil.getIsTianJin()){
			TjSelfIndexBO tjSelfIndexBO = (TjSelfIndexBO) PerfServiceFactory.getBean("pmkpi.perfself.TjSelfIndexBOTX");
			tjSelfIndexBO.updateDescScore(mainguid, bustype);
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
