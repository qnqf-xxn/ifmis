package gov.mof.fasp2.pmkpi.prorevision.audit;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.prorevision.report.ProrevisionReportDAO;

import java.util.List;
import java.util.Map;

public class ProrevisionAuditDAO extends PmkpiDAO {

    public static final String PERF_STRING_REVISION = "auditrevisionhide";

    /**
     * 根据权限获取单位
     * @param wheresql
     * @return
     */
    public List<Map<String, Object>> getTreeList(String wheresql, String tablecode) {
        StringBuilder sql = new StringBuilder("select * from PMKPI_FASP_T_PUBAGENCY m where 1=1 and exists ");
        sql.append("(select 1 from (select * from ").append(tablecode).append(" t where ").append(wheresql)
                .append(" ) n where m.guid = n.agencyguid ) and exists (select 1 from ").append(ProrevisionReportDAO.PERF_TABLE_REVISION_AGENCY)
                .append(" ptra where ptra.guid = m.guid ) order by code");
        return this.queryForList(sql.toString());
    }

    public void deleteByMainguid(String tableName, String guidcol, String mainguid, String where) {
        StringBuilder sql = new StringBuilder("delete from ");
        sql.append(tableName).append(" where ").append(guidcol).append(" = '").append(mainguid).append("'");
        if (where != null && !where.isEmpty()) {
            sql.append(" and ").append(where);
        }
        this.execute(sql.toString());
    }

    public void updateByMainguid(String tableName, String guidcol, String mainguid, String where) {
        StringBuilder sql = new StringBuilder(" update ");
        sql.append(tableName).append(" t set t.is_deleted = 1 ").append(" where ").append(guidcol).append(" in ('").append(mainguid).append("')");
        if (where != null && !where.isEmpty()) {
            sql.append(" and ").append(where);
        }
        this.execute(sql.toString());
    }

    public void updatedata(String mainguid){
        StringBuilder updatesql = new StringBuilder("update v_PERF_T_PROVISIONDECLARE set revisionstatus=1 where guid='");
        updatesql.append(mainguid).append("'") ;
        this.execute(updatesql.toString());
    }

    /**
     * 将项目指标调整是删除的指标标记为已删除
     * @param indextablecode
     */
    public void updateIndexData(String indextablecode) {
        StringBuilder updatesql = new StringBuilder("update ");
        updatesql.append(indextablecode).append(" t set t.is_deleted=1 where exists(select * from V_PERF_PROVISION_INDICATOR a where a.tindex=t.guid and a.status=1)");
        this.execute(updatesql.toString());
    }

    /**
     * 更改is_deleted字段，改为删除状态
     * @param tablecode
     */
    public void updateIndexDelStuts(String tablecode, String wheresql) {
        StringBuilder sql = new StringBuilder("update ");
        sql.append(tablecode).append(" t set t.is_deleted = 1 ,updatetime='").append(PerfUtil.getServerTimeStamp());
        sql.append("', update_time='").append(PerfUtil.getServerTimeStamp()).append("' ");
        if (!StringUtil.isEmpty(wheresql)) {
            sql.append(" where ").append(wheresql);
        }
        this.execute(sql.toString());
    }
}
