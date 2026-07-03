package gov.mof.fasp2.pmkpi.evalcase;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;

public class EvalCaseDAO extends PmkpiDAO {

	/**
	 * 根据guid查询数据
	 * @param guid -- mainguid/guid.
	 * @param  -- 页面类型.
	 * @return
	 */
	public List getByGuid(String tablecode, String guid, String iswf){
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from ");
		sql.append(tablecode).append(" where ");
		if (iswf != null && "true".equals(iswf)) {
			sql.append(" guid = '");
		} else {
			sql.append(" mainguid = '");
        }
		sql.append(guid).append("'");
		return this.queryForList(sql.toString());
	}

}
