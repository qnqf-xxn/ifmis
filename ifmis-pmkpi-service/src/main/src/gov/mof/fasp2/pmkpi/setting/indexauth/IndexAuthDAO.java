package gov.mof.fasp2.pmkpi.setting.indexauth;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 14:54 2020/8/17  chongdayong
 */
public class IndexAuthDAO extends PmkpiDAO {

    /**
     * 获取左侧树部门数据
     * @return
     */
    public List<Map<String, Object>> getDeptData() {
        String sql = "select t.guid,t.name,t.code,t.levelno + 1 levelno,t.isleaf,case when t.superguid='#' then 'DEPT' else t.superguid end superguid from " + PMKPI_TABLE_T_AGENCY + " t order by code";
        return this.queryForList(sql);
    }

    /**
     * 获取层次分类
     * @param frametype
     * @return
     */
    public List<Map<String, Object>> getFrame(String frametype) {
        String sql = "select t.guid itemid,t.name,t.code,t.levelno,t.isleaf,t.superid superitemid from " + PmkpiDAO.PMKPI_TABLE_T_FRAME + " t where t.frametype='" + frametype + "' order by code";
        return this.queryForList(sql);
    }

    /**
     * 获取单位的下级数据.
     * @param  guid -- guid.
     * @param  tablecode -- 表名
     * @return --
     */
    public List<Map<String, Object>> getElementDatas(String guid, String tablecode) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select distinct t.* from (" + tablecode + ") ");
        sql.append(" t start with  t.guid='").append(guid).append("'");
        sql.append(" connect by prior t.guid = t.superid");
        sql.append(" order by code ");
        return this.queryForList(sql.toString());
    }
}
