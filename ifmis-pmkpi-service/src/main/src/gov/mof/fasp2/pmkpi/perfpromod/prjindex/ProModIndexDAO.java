/**
 * @Title: PrjIndexDAO.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfpromod.prjindex;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * @ClassName: PrjIndexDAO
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@bjinfor.cn">GM</a>于 2020-1-6 上午10:42:14
 */

public class ProModIndexDAO extends PmkpiDAO {
    /**
     * 查询年度指标空指标模板.
     * @param proguid -- 项目.
     * @return list.
     */
    public List<Map<String, Object>> findNullTemp(String proguid) {
        String sql = "select sys_guid() guid, t.superid findex, t.guid sindex, t.guid frame, '"
                + proguid + "' prjguid from " + PMKPI_TABLE_T_FRAME + " t where "
                + " t.isleaf = 1 and t.frametype = 'PM001' order by ordernum";
        return this.queryForList(sql);
    }
    /**
     * 根据项目，年度，查询年度明细指标.
     * @param proguid -- 项目guid.
     * @param tablecode -- 查询案例表或项目指标表
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> findIndexs(String proguid, String tablecode) {
        StringBuffer sql = new StringBuffer("select * from ").append(tablecode).append(" t where t.mainguid = '");
        sql.append(proguid);
        sql.append("' order by t.sindex,t.findex,t.ordernum");
        return this.queryForList(sql.toString());
    }

    /**
     * 获取符号的值集.
     * @return
     * @throws
     */
    public List<Map<String, Object>> queryComputesign() {
        String sql = "SELECT * FROM Pub_t_Enum t WHERE t.elementcode='calculateymbol'";
        return this.queryForList(sql);
    }
    /**
     * 指标树级获取指标.
     *
     * @param mainguid -- 项目guid.
     * @return list.
     */
    public List<Map<String, Object>> getTempdatas(String mainguid, String frametype) {
        String sql = "select guid,'" + mainguid + "' mainguid,t.superid,t.code,t.name,levelno,isleaf, '1' rowtype, ordernum from " + PMKPI_TABLE_T_FRAME + " t where frametype='" + frametype + "' order by ordernum";
        List<Map<String, Object>> flist = queryForList(sql);
        List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : flist) {
            //map.put("rowtype", "mod");
            String guid = (String) map.get("guid");
            String superid = (String) map.get("superid");
            String levelno = map.get("levelno") + "";
            if (levelno != null && !"1".equals(levelno)) {
                map.put("findex", superid);
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
