package gov.mof.fasp2.pmkpi.deptTJformance.report;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class DeptTJPerfDAO extends PmkpiDAO {

	public static final String PERF_DEPTP_ERFDECLARE = "V_PERF_T_DEPTPERFDECLARE";

	public static final String PERF_DEPT_TASK = "V_PERF_T_DEPTTASK";
	public static final String PERF_DEPT_GOAL = "V_BGT_PERF_GOAL_INFO";
	public static final String PERF_DEPT_INDEX = "V_BGT_PERF_INDICATOR";
	public static final String PERF_DEPT_GOALTASK = "PERF_T_DEPTGOALTASK";
	public static final String PERF_DEPT_GOALTASKVIEW = "V_PERF_T_DEPTGOALTASK";

	/**
	 * 查询是当前部门是否存在数据.
	 * @param agencyguid -- 单位.
	 * @return
	 */
	public int findDeptPerformance(String agencyguid){
		String sql = "select count(*) from v_perf_t_deptperfdeclare t where t.agencyguid = ?";
		return  this.queryForInt(sql, new String[]{agencyguid});
	}

	/**
	 * 查询指标对应的项目.
	 * @param mainguid -- 主数据guid.
	 * @return
	 */
	public List<Map<String, Object>> findIndexPros(String mainguid) {
		String sql = "select t.pro_id,t.indexguid from v_perf_bgt_indexpro t where t.mainguid = ?";
		return this.queryForList(sql, new String[]{mainguid});
	}

	/**
	 * 指标选择项目，可以选择的部门纳入预算的项目列表.
	 * @param agencyguid -- guid.
	 * @return list.
	 */
	public List<Map<String, Object>> findWaitPros(String agencyguid) {
		String sql = "select * from v_perf_bgt_indexfrompros t where t.agencyguid = ?";
		return this.queryForList(sql, new String[]{agencyguid});
	}

	/**
	 * 获取模板数据
	 * @return
	 */
	public List<Map<String, Object>> getTempdatas() {
		String sql = "select guid,t.superid,t.code,t.name,levelno,isleaf,ordernum from " + PMKPI_TABLE_T_FRAME + " t where frametype='DEPT' order by ordernum";
		List<Map<String, Object>> flist = queryForList(sql);
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
		}
		return temps;
	}

	public String getFinintorByCode(String agencycode){
		StringBuffer sql = new StringBuffer("select * from PMKPI_FASP_T_PUBAGENCY where code = '");
		//sql.append(agencycode).append("001").append("'");
		sql.append(agencycode).append("'");
		return (String)this.queryForMap(sql.toString()).get("finintorgguid");
	}
}
