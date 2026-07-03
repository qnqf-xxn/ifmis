package gov.mof.fasp2.pmkpi.performanceopen.audit;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

/**
 * @author zhangxutao
 * @version 1.0
 * @description: TODO
 * @date 2023/4/18 10:30
 */
public class PerfOpenAuditDAO extends PmkpiDAO {

    /**
     * 获取审核类型数据源
     * @param wheresql
     * @return
     */
    public List<Map<String, Object>> getAudittypeDatas(String wheresql) {
        String sql = "select t.guid itemid,t.name,t.code,t.levelno,t.isleaf,t.superguid superitemid from v_perf_t_datasource t where t.elementcode='ordinaryaudittype' ";
        sql += wheresql;
        return this.queryForList(sql);
    }
}
