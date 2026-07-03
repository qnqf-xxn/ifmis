package gov.mof.fasp2.pmkpi.deptZJformanceadjust.query;

import java.util.List;
import java.util.Map;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

public class DeptPerfQueryDAO extends PmkpiDAO {

	/**
	 * 根据权限获取单位或部门
	 * @param wheresql
	 * @return
	 */
	public List<Map<String, Object>> getTreeList(String wheresql, String elementcode) {
		String sql=null;
		wheresql = wheresql.replace( "t.guid","t.agencyguid");
		if("PMKPIAGENCYALLPAY".equals(elementcode)){//单位
			sql = "select * from PMKPI_FASP_T_PUBAGENCY m where 1=1 and exists "
				+ "(select 1 from (select * from PERF_T_DEPTPERFDECLARE t where " 
				+ wheresql 
				+ " ) n where m.guid = n.agencyguid ) ";
		}else if ("PMKPIDEPT".equals(elementcode)){//部门
			sql = "select * from PMKPI_FASP_T_PUBAGENCY m where isleaf = 0 and exists "
				+ "(select 1 from (select * from PERF_T_DEPTPERFDECLARE t where " 
				+ wheresql 
				+ " ) n where m.guid = n.agencyguid ) ";
		}
		return this.queryForList(sql);
	}

}
