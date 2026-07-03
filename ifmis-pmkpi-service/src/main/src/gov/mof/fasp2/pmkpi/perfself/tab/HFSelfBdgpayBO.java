package gov.mof.fasp2.pmkpi.perfself.tab;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
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
public class HFSelfBdgpayBO extends PmkpiBO {
    private HFSelfBdgpayDAO hfSelfBdgpayDAO;

    public void setHFSelfBdgpayDAO(HFSelfBdgpayDAO hfSelfBdgpayDAO) {
        this.hfSelfBdgpayDAO = hfSelfBdgpayDAO;
    }

	/**
	 * 查询数据方法
	 * @param params -- 参数集合.
	 * @return
	 * @throws AppException ---自定义异常.
	 */
	public Map<String, Object> getPayDatas(HashMap<String, Object> params) throws AppException {
		Map<String, Object> backMap = new HashMap<String, Object>();
		//String proguid = (String)params.get("projguid");
		String procode = (String)params.get("procode"); //项目编码
		String tablesql = (String)params.get("tablesql");
		String tablecode = (String)params.get("tablecode"); //表
		String bustype = (String) params.get("bustype");
		String mainguid = (String)params.get("mainguid");
		String viewtype = (String) params.get("viewtype");//查询状态
		String queryYear = (String)params.get("queryYear");//跨年查询查询年度
		String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
		if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
			hfSelfBdgpayDAO.setYearAndProvince(queryYear, queryProvince);
		}
		String sql = " mainguid='" + mainguid + "'";
		if (!StringUtil.isEmpty(tablesql)) {
			sql += " and " + tablesql;
		}
		List<Map<String, Object>> bgtfundList = hfSelfBdgpayDAO.getDatas("v_perf_t_selfprofund", sql, " order by ordernum");
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
		//合肥需求：项目支出从中间表取数，并且页面可编辑。部门整体不从中间表取数，页面手动录入
		if (bustype != null && "program".equals(bustype)) {
			StringBuffer sqlbufer = new StringBuffer();
			sqlbufer.append(" PERF_FUNDPAY_VIEW.set_month('12') = '12' and PERF_FUNDPAY_VIEW.set_procode('").append(procode).append("')='").append(procode).append("'");
			//视图取数
			tablecode = "V_PERF_SELFBDGPAY_project_hf";  //合肥：自评填报预算执行取数视图(项目)
			bgtfundList = hfSelfBdgpayDAO.getDatas(tablecode, sqlbufer.toString(), " order by ordernum");
		}
		backMap.put("data", bgtfundList);
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
		String pro_code = (String) params.get("pro_code");
		String bustype = (String) params.get("bustype");
		String bgtget = params.get("bgtget") == null || params.get("bgtget") == "" ?"0.00" : (String) params.get("bgtget");
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
			map.put("mainguid", mainguid);
			map.put("create_time", PerfUtil.getServerTimeStamp());
			map.put("update_time", PerfUtil.getServerTimeStamp());
			map.put("agency_code", saveAgency);
			map.put("pro_code", pro_code);
			map.put("mof_div_code", SecureUtil.getUserSelectProvince());
			map.put("fiscal_year", CommonUtil.getYear());
			map.put("is_deleted", 2);
			fundList.add(map);
		}
		//删除保存
		String delsql = " mainguid='" + mainguid + "'";
		hfSelfBdgpayDAO.delDatas(tablecode, delsql);
		hfSelfBdgpayDAO.saveAll(fundList, tablecode);
		if ("program".equals(bustype)) {
			//项目更新指标完成情况
			hfSelfBdgpayDAO.updateSelfIndex(Float.parseFloat(bgtget), mainguid);
		}
		SelfDescDAO selfDescDAO = (SelfDescDAO) PerfServiceFactory.getBean("pmkpi.perfSelf.SelfDescDAO");
		//更新得分
		selfDescDAO.updateDescScore(mainguid, bustype);
		//项目更新指标完成情况
		selfDescDAO.updateBgtget(bgtget, mainguid);
		//保存业务数据结束删除暂存数据
		PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
		perfMidsaveBO.delTabData(params);
		return this.auditdefine(fundList, busguid,"perf", null);
	}
    
}
