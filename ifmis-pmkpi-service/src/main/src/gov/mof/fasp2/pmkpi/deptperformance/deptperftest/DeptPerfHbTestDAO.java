package gov.mof.fasp2.pmkpi.deptperformance.deptperftest;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

/**
 * <p>湖北-部门整体绩效（试点）</p >
 *
 * @author hw
 * @date 2022/9/8 16:37
 */
public class DeptPerfHbTestDAO extends PmkpiDAO {
    /**
     * 部门整体的绩效目标。
     */
    public static final String BGT_TABLE_GOAL = "V_BGT_PERF_GOAL_INFO";
    /**
     * 部门整体的绩效指标.
     */
    public static final String BGT_TABLE_INDICATOR = "V_BGT_PERF_INDICATOR";

    /**
     * 获取模板数据
     *
     * @return
     */
    public List<Map<String, Object>> getTempdatas() {
//        String sql = "select sys_guid()||'' as guid, t.parent_id as superid, t.code, t.parent_id as findex, t.code as sindex, t.findex as lv1_perf_ind_name, t.sindex as lv2_perf_ind_name, t.name, t.level_no as levelno, t.is_leaf as isleaf,'add' as rowtype, rownum as ordernum from bas_perf_indicator t where t.framesystem = 'DEPT_TEST' and year = 2016 and province = '87' order by code";
        String sql = "select sys_guid() || '' as guid, t.superid, t.code, t.findex, t.sindex, t.lv1_perf_ind_name, t.lv2_perf_ind_name, t.name, t.levelno, '1' as isleaf, 'add' as rowtype, t.ordernum from bgt_perf_indicator t where year = 2016 and province = '87' order by ordernum";
        logger.info("查询sql输出----------" + sql);
        List<Map<String, Object>> flist = queryForList(sql);
        return flist;
    }

    /**
     * <p>更新二级指标编码</p >
     *
     * @author hw
     * @date 2022/9/20 17:01
     * @param
     */
    public int updateGroupSindx(String mainguid, String kpidepid) {
        String sql2 = "update v_bgt_perf_indicator c set (c.lv2_perf_ind_code,c.sindex) = " +
                " (select k.rn, k.rn as rn1  from (" +
                "   select findex || row_number() over(partition by t.findex order by t.findex,lv2_perf_ind_name) rn, t.lv2_perf_ind_name from v_bgt_perf_indicator t where t.mainguid = ?  and t.kpi_dep_id = ? group by  t.findex,t.lv2_perf_ind_name) k " +
                " where k.lv2_perf_ind_name = c.lv2_perf_ind_name) " +
                "      where c.mainguid = ? and c.kpi_dep_id = ? ";
        return this.update(sql2, new String[]{mainguid, kpidepid, mainguid, kpidepid});
    }

    /**
     * <p>更新三级指标编码</p >
     *
     * @author hw
     * @date 2022/9/20 17:01
     * @param
     */
    public int updateGroupTindx(String mainguid, String kpidepid) {
        String sql = "update v_bgt_perf_indicator c set c.lv3_perf_ind_code = c.lv2_perf_ind_code||LPAD(c.ordernum,8,'0') where c.mainguid = ? and c.kpi_dep_id = ?";
        return this.update(sql, new String[]{mainguid, kpidepid});
    }
}
