package gov.mof.fasp2.pmkpi.evaluation.financial.audit;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class FinancialAuditDAO extends PmkpiDAO {

    public static final String PERF_STRING_PROCONFIRM = "finaudithide";

    /**
     * 根据权限获取单位
     * @param wheresql
     * @return
     */
    public List<Map<String, Object>> getTreeList(String wheresql, String tablecode) {
        String sql = "select * from PMKPI_FASP_T_PUBAGENCY m where 1=1 and exists "
                + "(select 1 from (select * from " + tablecode + " t where "
                + wheresql
                + " ) n where m.guid = n.agencyguid ) order by code";
        return this.queryForList(sql);
    }

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
