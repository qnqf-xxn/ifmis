package gov.mof.fasp2.pmkpi.assessQuery;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class AssessQueryDAO extends PmkpiDAO {

	public List<Map<String, Object>> getFileMag(String proguid) {
		String sql = "select t.proguid,t.pro_code,t1.name as attachname,t2.attachguid,t2.filename,t.province,t.year from PM_ATTACHMENT t " +
				" left join pm_t_dicattachtype t1 on t.attachtype = t1.guid " +
				" left join PM_FILECONTENTS t2 on t.guid = t2.attachguid " +
				" where t1.guid = 'DE9176' and proguid = '"+proguid+"'";
		return this.queryForList(sql);
	}
}
