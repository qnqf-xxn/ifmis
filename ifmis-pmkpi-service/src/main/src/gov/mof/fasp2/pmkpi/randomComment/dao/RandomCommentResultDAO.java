package gov.mof.fasp2.pmkpi.randomComment.dao;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class RandomCommentResultDAO extends PmkpiDAO {

	/**
	 * 获取模板数据
	 * @param mainguid --
	 * @return
	 */
    public List<Map<String, Object>> getTempdatas(String mainguid) {
    	String sql = "select guid,t.superid,t.code,t.name,levelno,isleaf from perf_t_deptcomm_valueset t where 1=1 order by ordernum";
		List<Map<String, Object>> flist = queryForList(sql);
    	sql = " select guid, f.findex,f.guid sindex,f.code,f.name from perf_t_deptfunction f where f.mainguid='" + mainguid + "' order by ordernum";
		List<Map<String, Object>> slist = queryForList(sql);
		List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
		for (Map<String, Object> map : flist) {
			map.put("rowtype", "mod");
			String guid = (String) map.get("guid");
			String superid = (String) map.get("superid");
			String levelno = map.get("levelno") + "";
			if (!"1".equals(levelno)) {
				map.put("findex", superid);
				map.put("sindex", guid);
			}
			temps.add(map);
			if ("1".equals(levelno)) {
				for (Map<String, Object> m : slist) {
					String findexguid = (String) m.get("findex");
					if (guid.equals(findexguid)) {
						m.put("sindex", m.get("guid"));
						m.put("levelno", "2");
						m.put("superid", findexguid);
						temps.add(m);
					}
				}
			}
		}
    	return temps;
    }

}
