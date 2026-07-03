package gov.mof.fasp2.pmkpi.perfSupervision;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class PerfSupervisionDAO extends PmkpiDAO {

	public static final String PERF_T_SUPERVISION = "reporthide";

	public String getFinintorg(String agencyguid) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select finintorg from Fasp_t_Pubagency ");
		sql.append(" where id = '").append(agencyguid).append("'");
		Map forMap = this.queryForMap(sql.toString());
		return (String) forMap.get("finintorg");
	}

	/**
	 * 根据权限获取单位
	 * @param wheresql
	 * @return
	 */
	public List<Map<String, Object>> getTreeList(String wheresql, String tablecode) {
		StringBuffer sql = new StringBuffer();
		sql.append("select * from PMKPI_FASP_T_PUBAGENCY m ")
				.append("inner join (SELECT AGENCYGUID FROM ").append(tablecode).append(" t where ")
				.append(wheresql).append("  group by AGENCYGUID ) n on m.guid = n.agencyguid  order by code");
		return this.queryForList(sql.toString());
	}

	public void updateOption(String tablecode,String adjoption,String options, String wsql) {
		StringBuffer sql = new StringBuffer();
		sql.append("update ").append(tablecode).append(" set adjoption ='")
				.append(adjoption).append("', options ='").append(options).append("' where ").append(wsql);
		this.execute(sql.toString());
	}

}
