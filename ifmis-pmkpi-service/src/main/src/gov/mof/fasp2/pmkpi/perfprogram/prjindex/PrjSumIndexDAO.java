package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PrjSumIndexDAO extends PmkpiDAO {
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
