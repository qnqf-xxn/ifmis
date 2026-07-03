package gov.mof.fasp2.pmkpi.randomComment.tab;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class RandomQualityEditDAO extends PmkpiDAO {

	public List<Map<String, Object>> getDataIndex(String tabcode,
			String wheresql, String string) {
		String sql = "select t.guid,t.SUPERID,t.MEASURESNAME as name,t.LEVELNO,t.ISLEAF from "+tabcode+"" +
				" t where 1=1 and DELSTATUS = '0' and EVALUATEOBJECT like '%01%'";
		return this.queryForList(sql);
	}
	
    public List<Map<String, Object>> getDataList(String tablecode, String wheresql) {
        String sql = "select * from " + tablecode + " t where 1=1 ";
        if (!StringUtil.isEmpty(wheresql)) {
            sql += " and " + wheresql;
        }
        return this.queryForList(sql);
    }
}
