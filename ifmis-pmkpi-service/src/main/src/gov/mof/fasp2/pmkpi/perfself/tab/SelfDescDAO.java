package gov.mof.fasp2.pmkpi.perfself.tab;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:45 2020/8/24  chongdayong
 */
public class SelfDescDAO extends PmkpiDAO {

	/**
	 * 修改得分
	 * @param mainguid
	 */
	public void updateDescScore(String mainguid, String bustype) throws AppException {
		String type = bustype;
		if ("transprogram".equals(bustype) || "parentprogram".equals(bustype)) {
			type = "program";
		}
		//更新自评得分
		HashMap<String, Object> selfMap = new HashMap<>();
		selfMap.put("mainguid",mainguid);
		// 自评结论
		selfMap.put("warmtype", "selfresult" + type);
		String selfresult = this.getWarn(selfMap);
		//自评得分
		SelfIndexBO selfIndexBO = (SelfIndexBO) ServiceFactory.getBean("pmkpi.perfSelf.SelfIndexBOTX");
		//判断当前是否启用了权重比例模式
		if("program".equals(type) && selfIndexBO.isRatio() && PerfUtil.getIS_HUBEI()){
			selfMap.put("warmtype", "selfratioscore" + type);
		}else {
			selfMap.put("warmtype", "selfscore" + type);
		}
		String score = this.getWarn(selfMap);
		String sql = "update v_perf_t_selfperfdesc t set t.score ='" + score + "', t.selfresult='" + selfresult + "' where t.mainguid='" + mainguid + "'";
		this.execute(sql);
		//评价基本信息(湖北特殊需求)
		if(PerfUtil.getIS_HUBEI()){
			//百分位值
			selfMap.put("warmtype", "selfpercentile" + bustype);
			String percentile = this.getWarn(selfMap);
			String hbsql = "update v_perf_t_evaluateinfo t set t.score ='" + score + "', t.grade='" + selfresult + "', t.percentile='" + percentile + "' where t.mainguid='" + mainguid + "'";
			this.execute(hbsql);
		}
	}

	/**
	 * 预警规则.
	 * @param params
	 * @return
	 */
	public String getWarn(HashMap<String, Object> params) {
		String warmtype = (String) params.get("warmtype");//预警类型
		String mainguid = (String) params.get("mainguid");//主单guid
		//缓存中获取预警sql
		String cacheKey = this.PMKPI_CACHE_WARN + warmtype;
		String cacheData = PerfUtil.getCacheData(cacheKey);
		if ("unwarn".equals(cacheData)) {
			return "";
		}
		String warnsql = "";
		List<Map<String, Object>> warnData;
		if (cacheData != null) {
			warnsql = cacheData;
		} else {
			warnData = this.getDatas(this.PMKPI_TABLE_T_WARNSET, "type='" + warmtype + "'", null);
			if (warnData.size() > 0) {
				warnsql = (String) warnData.get(0).get("warnsql");
			}
			PerfUtil.reflashCacheData(cacheKey, StringUtil.isEmpty(warnsql) ? "unwarn" : warnsql, false);
		}
		if (!StringUtil.isEmpty(warnsql)) {
			if (!StringUtil.isEmpty(mainguid)) {
				warnsql = warnsql.replace("#mainguid#", mainguid);
			}
			warnData = this.queryForList(warnsql);
			if (warnData != null && warnData.size() > 0) {
				return warnData.get(0).get("value") + "";
			}
		}
		return "";
	}

	/**
	 * 更新指标执行率数据
	 * @param bgtget
	 * @param mainguid
	 */
	public void updateBgtget(String bgtget, String mainguid){
		String sql = "update v_perf_t_selfevaltask t set t.bgtget = '" + bgtget + "' where t.guid='" + mainguid + "'";
		this.execute(sql);
	}
}
