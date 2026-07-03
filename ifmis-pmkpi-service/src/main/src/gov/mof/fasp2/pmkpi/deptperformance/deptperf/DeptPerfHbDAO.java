package gov.mof.fasp2.pmkpi.deptperformance.deptperf;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:18 2022/05/11 gaoming
 */
public class DeptPerfHbDAO extends PmkpiDAO {
    /**
     *  部门整体的绩效目标。
     */
    public static final String BGT_TABLE_GOAL = "V_BGT_PERF_GOAL_INFO";
    /**
     * 部门整体的绩效指标.
     */
    public static final String BGT_TABLE_INDICATOR = "V_BGT_PERF_INDICATOR";
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
     * 查询上一年度部门绩效的长期目标年限.
     * @param agencyguid --单位，部门。
     */
    public List getMainMap(String agencyguid){
        String sql = "select t.endyear,t.guid from perf_t_deptperfdeclare t where t.agencyguid = ? and t.year = ? and t.province = ?";
        return this.queryForList(sql,new String[]{agencyguid, (Integer.parseInt(CommonUtil.getYear())-1)+"",CommonUtil.getProvince()});
    }
}
