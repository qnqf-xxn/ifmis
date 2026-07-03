package gov.mof.fasp2.pmkpi.adjust.report;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.List;
import java.util.Map;

public class AdjustReportDAO extends PmkpiDAO {

    /**
     *获取项目最大调整次数
     * @return
     */
    public List<Map<String, Object>> getJustnums(String bustype) {
        String type = "dept";
        //修改不是末级
        String sql = "update v_perf_t_adjust t set t.islast = 0 where exists(select 1 from " + this.PMKPI_TABLE_TMP_GUIDS + " d where t.guid=d.guid)";
        this.execute(sql);
        //获取项目最大调整次数
        if (PerfUtil.getIsHbei() || type.equals(bustype)) {
            sql = "select max(adjustnum) adjustnum,proguid from (select proguid,adjustnum from v_perf_t_adjust t where exists(select 1 from " + this.PMKPI_TABLE_TMP_GUIDS + " d where t.guid=d.guid)) group by proguid";
        } else {
            sql = "select max(adjustnum) adjustnum,pro_code from (select pro_code,adjustnum from v_perf_t_adjust t where exists(select 1 from " + this.PMKPI_TABLE_TMP_GUIDS + " d where t.guid=d.guid)) group by pro_code";
        }
        return this.queryForList(sql);
    }

    /**
     *获取项目最大调整次数
     * @return
     */
    public void updateIsLast(String bustype, String wheresql) {
        String type = "dept";
        //修改不是末级
        StringBuffer sql = new StringBuffer();
        sql.append("update v_perf_t_adjust t set t.ISLAST=1 where exists(select * from ");
        //获取项目最大调整次数
        if (PerfUtil.getIsHbei() || type.equals(bustype)) {
            sql.append("(select max(a.adjustnum)adjustnum,proguid from v_perf_t_adjust a where bustype= '").append(bustype).append("' group by proguid) b where ");
        } else {
            sql.append("(select max(a.adjustnum)adjustnum,pro_code from v_perf_t_adjust a where bustype= '").append(bustype).append("' group by pro_code) b where ");
        }
        sql.append(wheresql).append(" and b.adjustnum=t.ADJUSTNUM) and bustype= '").append(bustype).append("'");
        logger.info("sql+++++++++" + sql);
        this.execute(sql.toString());
    }

    /**
     *获取项目最大调整次数
     * @return
     */
    public List<Map<String, Object>> getAdjustDatas(String wheresql) {
        StringBuffer sql = new StringBuffer();
        sql.append("select * from v_perf_t_adjust t where t.wfstatus <> '011'");
        sql.append(" and ").append(wheresql);
        sql.append(" and (exists (select 1 from v_perf_t_adjustindex a where t.guid=a.mainguid) or t.delwfstatus in('1','3'))");
        logger.debug("查询调整在途数据+++++++" + sql);
        return this.queryForList(sql.toString());
    }
}
