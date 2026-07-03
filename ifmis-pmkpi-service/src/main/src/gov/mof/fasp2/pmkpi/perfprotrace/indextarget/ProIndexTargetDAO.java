package gov.mof.fasp2.pmkpi.perfprotrace.indextarget;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ProIndexTargetDAO extends PmkpiDAO {

    /**
     *  绩效目标。
     */
    public static final String TABLE_GOAL = "V_PM_PERF_GOAL_INFO";
    /**
     * 绩效指标.
     */
    public static final String TABLE_INDEX = "V_PERF_T_PROINDEXTRACE";

    public static final String INDEX_DATASOURCE = "PMKPIPROTRACEINDEX";

    /**
     * 获取模板数据
     * @param type --
     * @return
     */
    public List<Map<String, Object>> getTempdatas(String type,String wheresql) {
        String isZJ = PerfUtil.getSystemSet("isZJ"); //判断是否是浙江环境
        StringBuffer sql = new StringBuffer("select guid,t.superid,t.code,t.name,levelno,isleaf,ordernum,'' as NCINDEXVAL from " + PMKPI_TABLE_T_FRAME + " t ");
        sql.append(" where frametype='" + type + "'");
        if (wheresql != null && !wheresql.isEmpty()){
            sql.append(" and ").append(wheresql);
        }
        sql.append(" order by ordernum");
        List<Map<String, Object>> flist = queryForList(sql.toString());
        List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : flist) {
            map.put("rowtype", "mod");
            if ("1".equals(isZJ)) {
                map.put("indexcompletion", "");
            }
            String guid = (String) map.get("guid");
            String superid = (String) map.get("superid");
            String levelno = map.get("levelno") + "";
            if ("1".equals(levelno)) {
                map.put("findex", superid);
                map.put("sindex", guid);
            }
            temps.add(map);
        }
        return temps;
    }

    /**
     * 根据项目，年度，查询年度明细指标.
     * @param tablecode -- 查询案例表或项目指标表
     * @param  filter -- 过滤条件.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> findIndexs(String tablecode, String filter,String mainguid ,String filetype) {
        StringBuffer sql = new StringBuffer("select t.*,(select replace(wm_concat(vpf.filename), ',', '；') as filename from v_perf_file vpf where vpf.billguid = t.guid||'"+mainguid+"' and vpf.filetype = '"+filetype+"') as filename from ").append(tablecode).append(" t ");
        if (!StringUtil.isEmpty(filter)) {
            sql.append(" where ").append(filter);
        }
        sql.append(" order by t.sindex,t.findex,t.ordernum");
        logger.info("监控指标查sql+++++++++++++++++" + sql.toString());
        return this.queryForList(sql.toString());
    }
}
