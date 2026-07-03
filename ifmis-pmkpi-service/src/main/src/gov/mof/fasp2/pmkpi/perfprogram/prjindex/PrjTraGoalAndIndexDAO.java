package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PrjTraGoalAndIndexDAO extends PmkpiDAO {

    /**
     * <p>获取左侧树数据-财政区划</p >
     */
    public List<Map<String, Object>> getLeftTree(String procode) {
        StringBuffer sql = new StringBuffer();
        sql.append("select t.guid,t.code,t.name,'0' as superguid,'0' as levelno,'0' as isleaf from v_ele_vd08001 t");
        sql.append(" where exists(select 1 from v_perf_traindex_province a where a.pro_code=? and t.guid=a.submofdivcode)");
        sql.append(" order by code asc");
        logger.info("---获取左侧树数据-不走临时表：" + sql);
        return PerfUtil.lowMapKey(this.queryForList(sql.toString(), new String[]{procode}));
    }

    /**
     * 获取模板数据
     * @param type --
     * @return
     */
    public List<Map<String, Object>> getTempdatas(String type) {
        String sql = "select guid,t.superid,t.code,t.name,levelno,isleaf,ordernum from " + PMKPI_TABLE_T_FRAME + " t where frametype='" + type + "' order by ordernum";
        List<Map<String, Object>> flist = queryForList(sql);
        List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
        Map<String, Object> fMap = new HashMap<>();
        for (Map<String, Object> map : flist) {
            map.put("rowtype", "mod");
            String guid = (String) map.get("guid");
            String superid = (String) map.get("superid");
            String levelno = map.get("levelno") + "";
            if ("1".equals(levelno)) {
                fMap.put(guid, map.get("name"));
                map.put("findexname", map.get("name"));
            }
            if ("2".equals(levelno)) {
                map.put("findex", superid);
                map.put("sindex", guid);
                map.put("findexname", fMap.get(superid));
            }
            temps.add(map);
        }
        return temps;
    }
}
