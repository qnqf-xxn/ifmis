package gov.mof.fasp2.pmkpi.adjust.index;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;

public class AdjustTraIndexDAO extends PmkpiDAO {

    public static String PERF_TABLE_ADJUSTALLGOAL = "v_perf_t_adjustallgoal";

    public static String PERF_TABLE_ADJUSTALLINDEX = "v_perf_t_adjustallindex";

    /**
     * <p>获取左侧树数据-财政区划</p >
     */
    public List<Map<String, Object>> getLeftTree(String procode, String submofdivcodes, String istztj) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select t.guid,t.code,t.name,'0' as superguid,'0' as levelno,'0' as isleaf from v_ele_vd08001 t where ");
        if (!StringUtil.isNullOrEmpty(submofdivcodes)) {
            sql.append(this.createInSql("guid", Arrays.asList(submofdivcodes.split(","))));
        } else if (!"1".equals(istztj)) {
            sql.append("exists(select 1 from v_perf_traindex_province a where a.pro_code=? and t.guid=a.submofdivcode)");
        } else {
            sql.append("1<>1");
        }
        sql.append(" order by code asc");
        logger.info("---获取左侧树数据-不走临时表：" + sql);
        if (StringUtil.isNullOrEmpty(submofdivcodes) && !"1".equals(istztj)) {
            return PerfUtil.lowMapKey(this.queryForList(sql.toString(), new String[]{procode}));
        } else {
            return this.queryForList(sql.toString());
        }

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
