package gov.mof.fasp2.pmkpi.perfQuery.firstPro;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class FirstProgramQueryDAO extends PmkpiDAO {

	/**
	 * 根据权限获取单位
	 * @param wheresql
	 * @return
	 */
	public List<Map<String, Object>> getTreeList(String wheresql) {
		String sql = "select * from PMKPI_FASP_T_PUBAGENCY m where 1=1 and exists "
			+ "(select 1 from (select * from v_perf_project_info t where "
			+ wheresql 
			+ " ) n where m.guid = n.agencyguid ) ";
		return this.queryForList(sql);
	}

}
