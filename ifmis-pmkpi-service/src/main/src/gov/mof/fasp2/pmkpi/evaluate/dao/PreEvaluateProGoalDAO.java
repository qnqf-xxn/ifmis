package gov.mof.fasp2.pmkpi.evaluate.dao;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class PreEvaluateProGoalDAO extends PmkpiDAO {

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

}
