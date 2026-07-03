package gov.mof.fasp2.pmkpi.perfprogram.approvalquery.goal;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


public class ApprovalGoalDAO extends PmkpiDAO {

    private static final String PMKPI_PERF_T_CASE_MODEL_GOAl = "V_PERF_T_CASEMODELGOAL";

    /**
     * 查询页面编辑区的注册字段
     * @param uikey
     * @return
     */
    public List<Map<String, Object>> getEditfrom(String uikey){
        String sql = "SELECT LOWER(t.columncode) as columncode,t.name,t.ORDERNUM FROM busfw_t_Uieditform t where t.key='"+uikey+"' and t.isvisiable=1" +
                " union all select 'type' columncode ,'类型' as name, 0 ordernum from dual";
        return this.queryForList(sql);
    }

    /**
     * 根据条件查询指标数据.
     * @param proguid -- 项目guid.
     * @param tempfilter -- 过滤条件.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> getGoalsByFilter(String proguid, String procode, String[] tempfilter) {
        String tablecode = "v_perf_bgt_goalpf";
        StringBuffer wheresql = null;
        StringBuffer sql = null;
        List<Map<String,Object>> list = new ArrayList<>();
        for (String yearflag : tempfilter) {
            wheresql = new StringBuffer();
            if ("1".equals(yearflag)) {
                wheresql.append(" yearflag = '1' and is_deleted = 2 and  t.mainguid ='").append(proguid).append("'");
            } else if ("0".equals(yearflag)) {
                wheresql.append(" yearflag = '0' and t.pro_code='").append(procode).append("'");
            }
            sql = new StringBuffer("select t.* from ").append(tablecode).append(" t where 1=1 ");
            if (!StringUtil.isEmpty(wheresql.toString())){
                sql.append(" and ");
                sql.append(wheresql);
            }
            if (!PerfUtil.getIS_HUBEI()) {
                sql.append(" and rownum=1 order by update_time desc");
            } else {
                sql.append(" order by goalname");
            }
            logger.info("查询绩效目标sql----------" + sql.toString());
            list.addAll(this.queryForList(sql.toString()));
        }
        return list;
    }

    public List<Map<String, Object>> findGoalByTempCode(String proguid, String tempcode, String[] tempfilter) {
        List<Map<String,Object>> list = new ArrayList<>();
        for (String yearflag:tempfilter) {
            List<Map<String,Object>> goallist = new ArrayList<>();
            StringBuffer sql = new StringBuffer();
            sql.append(" select '"+proguid+"' as mainguid, '"+yearflag+"' as yearflag, t.*,(case when "+yearflag+"=1 then ZQGOAL else NDGOAL end) as KPI_TARGET from ").append(PMKPI_PERF_T_CASE_MODEL_GOAl);
            sql.append(" t right join V_PERF_T_MODEL vptm on (t.mainguid = vptm.guid) where 1=1 and vptm.code = '").append(tempcode).append("' ");
            goallist = this.queryForList(sql.toString());
            logger.info("获取内置模板目标数据sql：-------------"+sql.toString());
            list.addAll(goallist);
        }
        for (Map<String, Object> map : list) {
            String guid = this.getCreateguid();
            map.put("guid", guid);
            map.put("kpi_per_id", guid);
        }
        return list;
    }

    public String getCreateguid() {
        return StringUtil.createUUID(); // 获取guid信息;
    }

}
