package gov.mof.fasp2.pmkpi.deptZJformanceadjust.report;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class DeptPerfDAO extends PmkpiDAO {

	public static final String PERF_DEPTP_ERFDECLARE = "v_perf_t_deptperfdeclare";

	public static final String PERF_ADJUST = "V_PERF_T_ADJUST";

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
		String sql = "select t.pro_id,t.indexguid,t.pro_code,t.pro_name,t.pro_total_amt from v_perf_bgt_indexpro t where t.mainguid = ?";
		return this.queryForList(sql, new String[]{mainguid});
	}

	public List<Map<String, Object>> findIndexProsadjust(String mainguid) {
		String sql = "select t.pro_id,t.indexguid,t.pro_code,t.pro_name,t.pro_total_amt from v_perf_bgt_indexproadjust t where t.mainguid = ?";
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
	 * 指标选择项目，可以选择的部门纳入预算的项目列表.
	 * @param agencyguid -- guid.
	 * @param indexguid -- 指标guid.
	 * @return list.
	 */
	/*public List<Map<String, Object>> findSelectPros(String agencyguid, String indexguid) {
		String sql = "select * from V_PERF_BGT_INDEXPRO t where t.agencyguid = ? and t.indexguid = ? order by t.pro_code";
		return this.queryForList(sql, new String[]{agencyguid, indexguid});
	}*/

	/**
	 * 查找二级指标编码.
	 * @param agencyguid -- 部门.
	 * @param  mainguid -- 主单据id.
	 * @return
	 */
	public int updateGroupSindx(String agencyguid,String mainguid) {
		String sql = "update v_perf_t_deptindexadjust c set c.lv2_perf_ind_code = (" +
				" select k.rn from (select '4'||row_number() over(order by sname desc) rn,t.sname from v_perf_t_deptindexadjust t" +
				" where t.mainguid= ? and t.agencyguid= ? group by t.sname,t.agencyguid) k where k.sname = c.sname)," +
				" c.sindex = (select k.rn from (select '4'||row_number() over(order by sname desc) rn,t.sname from v_perf_t_deptindexadjust t" +
				" where t.mainguid= ? and t.agencyguid= ? group by t.sname,t.agencyguid) k where k.sname = c.sname)," +
				" c.lv2_perf_ind_name = (select k.sname from (select '4'||row_number() over(order by sname desc) rn,t.sname from v_perf_t_deptindexadjust t" +
				" where t.mainguid= ? and t.agencyguid= ? group by t.sname,t.agencyguid) k where k.sname = c.sname)" +
				" where c.agencyguid = ? and  c.mainguid = ? ";
		return this.update(sql, new String[]{mainguid,agencyguid,mainguid,agencyguid,mainguid,agencyguid,agencyguid, mainguid});
	}

	/**
	 * 更新三级指标.
	 * @param agencyguid -- 部门.
	 * @param mainguid -- 主键.
	 * @return
	 */
	public int updateGroupTindx(String agencyguid,String mainguid) {
		String sql = "update v_perf_t_deptindexadjust c set c.code = c.lv2_perf_ind_code||LPAD(c.ordernum,8,'0'),c.lv3_perf_ind_code = c.lv2_perf_ind_code||LPAD(c.ordernum,8,'0'),c.lv3_perf_ind_name = c.name where c.agencyguid = ? and  c.mainguid = ?";
		return this.update(sql, new String[]{agencyguid, mainguid});
	}


	public String getFinintorByCode(String agencycode){
		StringBuffer sql = new StringBuffer("select * from PMKPI_FASP_T_PUBAGENCY where code = '");
		//sql.append(agencycode).append("001").append("'");
		sql.append(agencycode).append("'");
		return (String)this.queryForMap(sql.toString()).get("finintorgguid");
	}
}
