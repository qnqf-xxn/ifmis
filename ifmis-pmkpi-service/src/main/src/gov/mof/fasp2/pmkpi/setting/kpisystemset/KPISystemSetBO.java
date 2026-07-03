package gov.mof.fasp2.pmkpi.setting.kpisystemset;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.Map;

public class KPISystemSetBO extends PmkpiBO {
	
	private KPISystemSetDAO kpiSystemSetDAO;

	public void setKpiSystemSetDAO(KPISystemSetDAO kpiSystemSetDAO) {
		this.kpiSystemSetDAO = kpiSystemSetDAO;
	}

	@Override
	public String getVodSql(Map sqlmap) throws AppException {
		String tablecode = (String)sqlmap.get("tablecode");
		String tablesql = (String)sqlmap.get("tablesql");
		String querySql = (String) sqlmap.get("querySql");
		StringBuffer sql = new StringBuffer();
		sql.append("select * from ").append(tablecode).append(" t ");
		StringBuffer wsql = new StringBuffer();
		if (!StringUtil.isEmpty(tablesql)) {
			wsql.append(tablesql).append(" and ");
		}
		if (!StringUtil.isEmpty(querySql)) {
			wsql.append(querySql).append(" and ");
		}
		if (wsql.length() > 0) {
			sql.append(" where ").append(wsql.substring(0, wsql.length() - 4));
		}
		sql.append(" order by paramcode");
		return sql.toString();
	}

	/**
	 * 保存.
	 * @param params
	 * @throws Exception 
	 */
	public void saveSystem(HashMap<String, Object> params) throws Exception {
		//表名
        String tablecode = (String) params.get("tablecode");
        String guid = (String) params.get("guid");
        //全部数据
        Map<String, Object> infodata = (Map<String, Object>) params.get("infodata");
		Map<String, Object> dataMap = this.getDataMap(tablecode, " guid ='" + guid + "'");
		dataMap.putAll(infodata);
		dataMap.put("appid", "pmkpi");
		kpiSystemSetDAO.updateByPK(dataMap, "guid", tablecode);
		String code = (String) dataMap.get("paramcode");
		String status = (String) dataMap.get("status");
		if ("1".equals(status)) { //启用参数，更新缓存信息
			PerfUtil.reflashSystemSetCache(code, false);
		} else { //不启用缓存，删除缓存中参数信息
			PerfUtil.reflashSystemSetCache(code, true);
		}
	}

}
