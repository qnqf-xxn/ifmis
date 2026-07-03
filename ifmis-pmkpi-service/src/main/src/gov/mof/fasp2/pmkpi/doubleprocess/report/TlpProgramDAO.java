package gov.mof.fasp2.pmkpi.doubleprocess.report;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class TlpProgramDAO extends PmkpiDAO {

	public void updateislast(String pro_code){
		String sql = "update v_perf_t_review t set  t.islast = 0 where t.type='goal' and t.pro_code = '"+pro_code+"'";
		this.update(sql);
	}

	public int findReviewNum(String pro_code){
		String sql = "select NVL(max(t.reviewnum), 0) from v_perf_t_review t where t.type='goal' and t.islast = 1 and t.pro_code = '"+pro_code+"'";
		return this.queryForInt(sql);
	}
	/**
	 * 获取预算单位与项目的对应状态.
	 * @return
	 */
	public List<Map<String, Object>> findPBdmWf(){
		String sql = "select t.bdmwf,t.perfwf,t.beforewf from v_perf_bdmwfstatus t";
		return this.queryForList(sql);
	}

	/**
	 * 更新单位下的状态
	 * @param agencyid
	 */
	public void updateislastByAgency(String agencyid){
		String sql = "update v_perf_t_review t set  t.islast = 0 where t.type='goal' and t.agencyguid = '"+agencyid+"'";
		this.update(sql);
	}

	/**
	 * 查询项目基本信息
	 * @param mainguid
	 */
	public List<Map<String, Object>> getProInfo(String mainguid){
		String sql = "select * from v_pm_project_info where guid = '"+mainguid+"'";
		return this.queryForList(sql);
	}
}
