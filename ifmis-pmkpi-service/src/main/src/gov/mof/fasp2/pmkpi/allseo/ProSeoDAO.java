package gov.mof.fasp2.pmkpi.allseo;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ProSeoDAO extends PmkpiDAO {

    /**
     * 获取模板数据
     * @return
     */
    public List<Map<String, Object>> getTempdatas() {
        String sql = "select guid,t.superid,t.code,t.name,levelno,isleaf,ordernum from " + PMKPI_TABLE_T_FRAME + " t where frametype='PM001' order by ordernum";
        List<Map<String, Object>> flist = queryForList(sql);
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
        }
        return temps;
    }

    /**
     * 获取项目的监控任务树。
     * @param pro_code
     * @return
     */
    public List<Map<String, Object>> getMainGuid(String pro_code) {
        String sql = "SELECT k.guid, t.name " +
                "  FROM v_perf_t_taskset t, v_perf_t_promonitor k " +
                " where t.tasktype = 'protrace' " +
                "   and k.taskguid = t.guid " +
                "   and k.pro_code = '"+pro_code+"'";
        return  this.queryForList(sql);
    }
}
