package gov.mof.fasp2.pmkpi.randomComment.tab;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class RandomIndexEditDAO extends PmkpiDAO {

	/**
	 * 基础指标表.
	 */
	public static final String PMKPI_TABLE_INDEX = "PERF_T_RANDOMINDEX";
	
	public List<Map<String, Object>> getDataIndex(String tabcode,
			String wheresql, String string) {
		String sql = "select t.guid,t.SUPERID,t.MEASURESNAME as name,t.LEVELNO,t.ISLEAF,rownum as ordernum from "+tabcode+"" +
				" t where 1=1 and DELSTATUS = '0' and EVALUATEOBJECT like '%01%'";
		return this.queryForList(sql);
	}
	/**
	 * 指标树级获取指标.
	 *
	 * @param mainGuid -- 项目guid.
	 * @return list.
	 */
	public List<Map<String, Object>> getTempdatas(String mainGuid, String frameType) {
		String sql = "select guid,'" + mainGuid + "' mainguid,t.superid,t.code,t.name,levelno,isleaf, '1' as rowtype, ordernum from " + PMKPI_TABLE_T_FRAME + " t where frametype='" + frameType + "' order by ordernum";
		List<Map<String, Object>> flist = queryForList(sql);
		List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
		for (Map<String, Object> map : flist) {
			//map.put("rowtype", "mod");
			String guid = (String) map.get("guid");
			String superId = (String) map.get("superid");
			String levelNo = map.get("levelno") + "";
			if (levelNo != null && !"1".equals(levelNo)) {
				map.put("findex", superId);
				map.put("sindex", guid);
			}
			map.put("is_add", "0");
			map.put("zqindexval", "");
			map.put("zqmeterunit", "");
			map.put("zqcomputesign", "");
			map.put("adjoption", "");
			map.put("options", "");
			temps.add(map);
		}
		logger.debug(temps.toString());
		return temps;
	}
}
