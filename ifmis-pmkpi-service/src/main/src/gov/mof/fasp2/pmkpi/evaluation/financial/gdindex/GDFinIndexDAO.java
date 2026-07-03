package gov.mof.fasp2.pmkpi.evaluation.financial.gdindex;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class GDFinIndexDAO extends PmkpiDAO {

	/**
	 * 指标树级获取指标.
	 * @param mainguid -- 项目guid.
	 * @param frametype -- 指标体系
	 * @return list.
	 */
	public List<Map<String, Object>> getTempdatas(String mainguid, String frametype) {
		StringBuffer sql = new StringBuffer("select guid,'");
		sql.append(mainguid).append("' mainguid,t.superid,t.code,t.name,to_char(levelno) as levelno,'0' as isleaf, '1' as rowtype,weight, ordernum,'0' isedit, null as filename,'' as NCINDEXVAL from ");
		sql.append(PMKPI_TABLE_T_FRAME ).append(" t where frametype='").append(frametype).append("' order by ordernum");
		List<Map<String, Object>> flist = queryForList(sql.toString());
		List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
		for (Map<String, Object> map : flist) {
			String guid = (String) map.get("guid");
			String superid = (String) map.get("superid");
			String levelno = map.get("levelno") + "";
			if (!"1".equals(levelno)) {
				map.put("findex", superid);
				map.put("sindex", guid);
			}
			map.put("_isleaf", "0");
			temps.add(map);
		}
		return temps;
	}

}
