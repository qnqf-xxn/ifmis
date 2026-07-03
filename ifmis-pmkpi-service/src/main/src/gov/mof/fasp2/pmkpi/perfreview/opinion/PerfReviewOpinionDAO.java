package gov.mof.fasp2.pmkpi.perfreview.opinion;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class PerfReviewOpinionDAO extends PmkpiDAO {

    /**
     * 查询项目指标.
     * @param proGuid   -- 项目guid.
     * @param tempFilter  -- 显示页签
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> getProIndex(String proGuid, String procode, String[] tempFilter) {
        String tableCode = "";
        StringBuffer wheresql = null;
        StringBuffer sql = null;
        List<Map<String,Object>> list = new ArrayList<>();
        for (String yearflag : tempFilter) {
            wheresql = new StringBuffer();
            if (yearflag != null && "1".equals(yearflag)) {
                tableCode = "pm_perf_indicator";
            } else if (yearflag != null && "0".equals(yearflag)) {
                tableCode = "v_pm_perf_indicator";
            }
            if (yearflag != null && "1".equals(yearflag)) {
                wheresql.append(" t.mainguid = '").append(proGuid).append("'");
                wheresql.append(" and nvl(yearflag,'0') = '1' and is_deleted = 2 and is_backup=2 ");
            } else if ("0".equals(yearflag)) {
                wheresql.append(" t.pro_code = '").append(procode).append("'");
                wheresql.append(" and nvl(yearflag,'0') = '0'");
            }
            sql = new StringBuffer();
            sql.append("select 1 isleaf, '1' as rowtype,t.* from ").append(tableCode).append(" t where 1=1 ");
            if (!StringUtil.isEmpty(wheresql.toString())) {
                sql.append(" and ");
                sql.append(wheresql);
            }
            sql.append(" order by yearflag,t.findex,t.sindex,t.ordernum");
            logger.debug("sql.toString():::"+sql.toString());
            List<Map<String, Object>> indexList = this.queryForList(sql.toString());
            list.addAll(indexList);
        }
        return list;
    }

    /**
     * 查询部门指标.
     * @param proguid   -- 项目guid.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> getDeptIndex(String proguid) {
        String tableCode = "v_bgt_perf_indicator";
        StringBuffer sql = new StringBuffer();
        sql.append("select 1 isleaf, '1' as rowtype,t.* from ").append(tableCode).append(" t where t.mainguid = '");
        sql.append(proguid).append("'");
        sql.append(" order by t.findex,t.sindex,t.ordernum");
        logger.debug("sql.toString():::"+sql.toString());
        return this.queryForList(sql.toString());
    }

    /**
     * 指标树级获取指标.
     *
     * @param mainGuid -- 项目guid.
     * @return list.
     */
    public List<Map<String, Object>> getTempdatas(String mainGuid, String frameType) {
        String sql = "select guid,'" + mainGuid + "' mainguid,t.superid,t.code,t.name,levelno,isleaf, '1' as rowtype, ordernum from " + PMKPI_TABLE_T_FRAME + " t where frametype='" + frameType + "' order by ordernum";
        List<Map<String, Object>> flist = queryForList(sql);
        List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : flist) {
            //map.put("rowtype", "mod");
            String guid = (String) map.get("guid");
            String superId = (String) map.get("superid");
            String levelNo = map.get("levelno") + "";
            if (levelNo != null && !"1".equals(levelNo)) {
                map.put("findex", superId);
                map.put("sindex", guid);
                //map.put("_isleaf", map.get("isleaf"));
            }
            map.put("is_add", "0");
            map.put("zqindexval", "");
            map.put("zqmeterunit", "");
            map.put("zqcomputesign", "");
            map.put("adjoption", "");
            map.put("options", "");
            temps.add(map);
        }
        return temps;
    }
}
