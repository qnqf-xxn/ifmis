package gov.mof.fasp2.pmkpi.randomComment.tab;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class RandomProblemEditDAO extends PmkpiDAO {

	public List<Map<String, Object>> getDataIndex(String tabcode,
			String wheresql, String string) {
		String sql = "select t.guid,t.SUPERID,t.MEASURESNAME as name,t.LEVELNO,t.ISLEAF from "+tabcode+"" +
				" t where 1=1 and DELSTATUS = '0' and EVALUATEOBJECT like '%01%'";
		return this.queryForList(sql);
	}
}
