package gov.mof.fasp2.pmkpi.dtsys.controller;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.List;
import java.util.Map;

public class ConfirConfigDAO extends PmkpiDAO {
    /**
     * 项目目标表
     */
    public static final String PMKPI_TABLE_PM_GOAL = "PM_PERF_GOAL_INFO";

    /**
     * 项目指标表
     */
    public static final String PMKPI_TABLE_PM_INDICATOR = "PM_PERF_INDICATOR";

    /**
     * 部门整体目标表
     */
    public static final String PMKPI_TABLE_BGT_GOAL = "BGT_PERF_GOAL_INFO";

    /**
     * 项目指标表
     */
    public static final String PMKPI_TABLE_BGT_INDICATOR = "PM_PERF_INDICATOR";

    /**
     * 评审意见表
     */
    public static final String PMKPI_TABLE_AUDITMAIN = "PERF_T_AUDITMAIN";

    /**
     * 评审意见表
     */
    public static final String PMKPI_TABLE_AUDITITEMS = "PERF_T_AUDITITEMS";

    /**
     * 评审工作流表
     */
    public static final String PMKPI_TABLE_REVIEW = "PERF_T_REVIEW";

    /**
     * 获取项目目标、指标数据-年度
     * @param table --关联主表--项目表、部门整体表
     * @param tablecode --目标、指标表
     * @param province --区划
     * @param year --年度
     * @param agencyguid --单位
     * @return
     */
    public List<Map<String, Object>> getGoalOrIndexData(String table, String tablecode, String province, String year, String agencyguid){
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from ").append(tablecode).append(" t where t.year=? and t.province=? and exists(select 1 from ");
        sql.append(table).append(" a where a.province=? and a.agency_code=? and a.pro_code = t.pro_code) and t.yearflag='0'");
        return PerfUtil.lowMapKey(this.queryForList(sql.toString(), new String[]{year, province, province, agencyguid}));
    }

    /**
     * 审核意见数据
     * @param table --关联主表--项目表、部门整体表
     * @param tablecode --目标、指标表
     * @param province --区划
     * @param year --年度
     * @param agencyguid --单位
     * @return
     */
    public List<Map<String, Object>> getAuditOpinion(String table, String tablecode, String province, String year, String agencyguid){
        StringBuffer sql = new StringBuffer();
        sql.append(" select t.*,b.pro_code,b.type from ").append(tablecode).append(" t left join ").append(table).append(" b on b.guid=t.mainguid");
        sql.append(" where t.year=? and t.province=? and exists(select 1 from ");
        sql.append(table).append(" a where a.province=? and a.agencyguid=? and a.guid = t.mainguid)");
        return PerfUtil.lowMapKey(this.queryForList(sql.toString(), new String[]{year, province, province, agencyguid}));
    }
}
