package gov.mof.fasp2.pmkpi.perfpromod.info;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 17:43 2020/9/9  chongdayong
 */
public class ProModInfoDAO extends PmkpiDAO {
    /**
     * 获取项目信息
     * @param tablecode --表名
     * @param proguid --项目guid
     * @return
     */
    public Map<String, Object> getProgramInfo(String tablecode, String proguid) {
        String sql = " select * from " + tablecode + " t where t.guid='" + proguid + "'";
        List<Map<String, Object>> list = this.queryForList(sql);
        if (list != null && list.size() > 0) {
            return  list.get(0);
        }
        return null;
    }
}
