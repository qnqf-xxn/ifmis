package gov.mof.fasp2.pmkpi.deptperformance.hbindex;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class HBDeptIndexDAO extends PmkpiDAO {
    /**
     * 获取模板数据
     * @return
     */
    public List<Map<String, Object>> getTempdatas() {
        String sql = "select guid,t.superid,t.code,t.name,levelno,isleaf,ordernum,1 as isfixed from " + PMKPI_TABLE_T_FRAME + " t where frametype='DEPT' order by ordernum";
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
            } else {
                map.put("findex", guid);
            }
            temps.add(map);
        }
        return temps;
    }

    /**
     * 获取固化指标数据
     * @return
     */
    public List<Map<String, Object>> getFixedindex() {
        String sql = "select t.*,t.sindex as superid,'add' as rowtype from v_perf_t_fixedindex t where t.frametype=? order by findex, sindex, ordernum";
        return PerfUtil.lowMapKey(this.queryForList(sql, new String[]{"DEPT"}));

    }
}
