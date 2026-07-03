package gov.mof.fasp2.pmkpi.perfprogrammiddle.midreport;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;

public class MidProgramDAO extends PmkpiDAO {

	/**
	 * 根据guid查询数据
	 * @param guid -- mainguid/guid.
	 * @param  -- 页面类型.
	 * @return
	 */
	public List getByGuidQuery(String tablecode,String procode, String guid, String iswf){
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from ");
		sql.append(tablecode).append(" where ");
		if (iswf != null && "true".equals(iswf)) {
			sql.append(" pro_code = '");
			sql.append(procode).append("'");
		} else {
			sql.append(" mainguid = '");
			sql.append(guid).append("'");
        }
		logger.info(sql.toString());
		return this.queryForList(sql.toString());
	}

}
