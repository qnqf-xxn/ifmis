package gov.mof.fasp2.pmkpi.perfpromod.report;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ProModRpDAO extends PmkpiDAO {

	/**
	 * 根据guid查询数据
	 * @param guid -- mainguid/guid.
	 * @param pagetype -- 页面类型.
	 * @return
	 */
	public List getByGuid(String tablecode, String guid, String pagetype){
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from ");
		sql.append(tablecode).append(" where ");
		if (StringUtil.isEmpty(pagetype)) {
            sql.append(" mainguid = '");
        } else {
            sql.append(" guid = '");
        }
		sql.append(guid).append("'");
		return this.queryForList(sql.toString());
	}

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

	/**
	 * 获取选择项目数据
	 *
	 *
	 * @param wheresql
	 * @param wheresql --
	 * @param protablecode
	 * @return
	 */
	public List<Map<String, Object>> getProgramDatas(String wheresql, String protablecode, String tablecode) {
		String sql = "select * from " + protablecode + " t where not exists(select 1 from " + tablecode + " p where t.guid=p.proguid)";
		if (!StringUtil.isEmpty(wheresql)) {
			sql += " and " + wheresql;
		}
		sql += " order by code";
		return this.queryForList(sql);
	}

	/**
	 *获取项目最大调整次数
	 * @return
	 */
	public List<Map<String, Object>> getJustnums(String modtypesql) {
		//修改不是末级
		String sql = "update V_PERF_T_PROVISIONDECLARE t set t.islast = 0 where exists(select 1 from " + this.PMKPI_TABLE_TMP_GUIDS + " d where t.guid=d.guid )";
		if (!StringUtil.isEmpty(modtypesql)) {
			sql += " and " + modtypesql;
		}
		this.execute(sql);
		//获取项目最大调整次数
		sql = "select max(revisionnum) revisionnum,proguid from (select proguid,revisionnum from V_PERF_T_PROVISIONDECLARE t where exists(select 1 from " + this.PMKPI_TABLE_TMP_GUIDS + " d where t.guid=d.guid)  ";
		if (!StringUtil.isEmpty(modtypesql)) {
			sql += " and " + modtypesql;
		}
		sql += " ) group by proguid";
		return this.queryForList(sql);
	}
}
