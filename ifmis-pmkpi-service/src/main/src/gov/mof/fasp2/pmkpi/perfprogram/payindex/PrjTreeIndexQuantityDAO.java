package gov.mof.fasp2.pmkpi.perfprogram.payindex;


import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


public class PrjTreeIndexQuantityDAO extends PmkpiDAO {
    /**
     * 指标表.
     */
    public static final String PMKPI_TABLE_PM_INDEX = "V_PM_PERF_INDICATORQUANTITY";

    /**
     * 查询年度指标空指标模板.
     *
     * @param proguid -- 项目.
     * @return list.
     */
    public List<Map<String, Object>> findNullTemp(String proguid) {
        String sql = "select sys_guid() guid, t.superid findex, t.guid sindex, t.guid frame, '"
                + proguid + "' prjguid from " + PMKPI_TABLE_T_FRAME + " t where 1=1 "
                + " and t.isleaf = 1 and t.frametype = 'PM001' order by ordernum";
        return this.queryForList(sql);
    }

    /**
     * 获取模板数据
     * @param type --
     * @return
     */
    public List<Map<String, Object>> getTempdatas(String type,String wheresql) {
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
}
