package gov.mof.fasp2.pmkpi.deptperformance.hnindex;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:18 2020/8/24  chongdayong
 */
public class DeptHNIndexDAO extends PmkpiDAO {
    /**
     * 获取模板数据
     * @return
     */
    public List<Map<String, Object>> getTempdatas() {
        String sql = "select guid,t.superid,t.code,t.name,levelno,isleaf from " + PMKPI_TABLE_T_FRAME + " t where frametype='DEPT' order by ordernum";
        return this.queryForList(sql);
    }

}
