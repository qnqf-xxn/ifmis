package gov.mof.fasp2.pmkpi.deptperformance.index;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:18 2020/8/24  chongdayong
 */
public class DeptIndexDAO extends PmkpiDAO {
    /**
     * 获取模板数据
     * @return
     */
    public List<Map<String, Object>> getTempdatas() {
    	String sql = "select guid,t.superid,t.code,t.name,levelno,isleaf,ordernum from " + PMKPI_TABLE_T_FRAME + " t where frametype='DEPT' order by ordernum";
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
     * 获取默认模板数据
     * @param modelguid
     * @return
     */
    public List<Map<String, Object>> getModeldatas(String modelguid, String tablecode, String mainguid) {
        if (!StringUtil.isEmpty(modelguid)) {
            String sql = "select t.*,'add' as rowtype from v_perf_t_casemodelindex t where t.mainguid='" + modelguid + "'" +
                    " and not exists (select 1 from " + tablecode + " d where d.tindex = t.guid and d.mainguid='" + mainguid + "') order by ordernum";
            return this.queryForList(sql);
        }
        return new ArrayList<>();
    }

}
