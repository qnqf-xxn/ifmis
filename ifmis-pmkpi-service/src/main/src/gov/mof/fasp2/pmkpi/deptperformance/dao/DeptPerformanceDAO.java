package gov.mof.fasp2.pmkpi.deptperformance.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

public class DeptPerformanceDAO extends PmkpiDAO {

	/**
	 * 部门整体的绩效目标。
	 */
	public static final String BGT_TABLE_GOAL = "V_BGT_PERF_GOAL_INFO";
	/**
	 * 部门整体的绩效指标.
	 */
	public static final String BGT_TABLE_INDICATOR = "V_BGT_PERF_INDICATOR";

	/**
	 * 获取模板数据
	 * @param mainguid --
	 * @return
	 */
    public List<Map<String, Object>> getTempdatas(String mainguid) {
    	String sql = "select guid,t.superid,t.code,t.name,levelno,isleaf from " + PMKPI_TABLE_T_FRAME + " t where frametype='DEPT' order by ordernum";
		List<Map<String, Object>> flist = queryForList(sql);
    	sql = " select guid, f.findex,f.guid sindex,f.code,f.name from perf_t_deptfunction f where f.mainguid='" + mainguid + "' order by ordernum";
		List<Map<String, Object>> slist = queryForList(sql);
		List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
		for (Map<String, Object> map : flist) {
			map.put("rowtype", "mod");
			String guid = (String) map.get("guid");
			String superid = (String) map.get("superid");
			String levelno = map.get("levelno") + "";
			if (!"1".equals(levelno)) {
				map.put("findex", superid);
				map.put("sindex", guid);
			}
			temps.add(map);
			if ("1".equals(levelno)) {
				for (Map<String, Object> m : slist) {
					String findexguid = (String) m.get("findex");
					if (guid.equals(findexguid)) {
						m.put("sindex", m.get("guid"));
						m.put("levelno", "2");
						m.put("superid", findexguid);
						temps.add(m);
					}
				}
			}
		}
    	return temps;
    }

	/**
	 * 获取默认模板数据
	 * @param modelguid
	 * @return
	 */
	public List<Map<String, Object>> getModeldatas(String modelguid, String tablecode, String mainguid) {
		String sql = "select t.*,'add' as rowtype from perf_t_casemodelindex t where t.mainguid='" + modelguid + "'" +
				" and not exists (select 1 from " + tablecode + " d where d.tindex = t.guid and d.mainguid='" + mainguid + "')";
		return this.queryForList(sql);
    }
}
