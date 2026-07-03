package gov.mof.fasp2.pmkpi.perfprogrammiddle.midreport;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MidCheckBO extends PmkpiBO {
    private MidProgramDAO midProgramDAO;
    /**
     * 注入dao.
     * @param midProgramDAO --dao.
     * @throws
     */
    public void setMidProgramDAO(MidProgramDAO midProgramDAO) {
        this.midProgramDAO = midProgramDAO;
    }
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String nodeguid = (String)sqlmap.get("nodeguid"); //节点id.
        String tablecode = (String) sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql"); //项目级别：一二三级项目
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
        StringBuffer returnsql = new StringBuffer("select * from ");
        if(!PerfUtil.getIS_HUBEI()){//非湖北环境
            returnsql.append(tablecode).append(" t where ");
            returnsql.append(" not exists (select 1 from v_perf_t_deptperfmiddeclare pd where pd.pro_code = t.pro_code) ");
        }else{
            returnsql = new StringBuffer("select t.* from ");
            returnsql.append(tablecode).append(" t ");
            returnsql.append(" where not exists(select 1 from v_pm_perf_goal_info a where a.pro_code=t.pro_code and a.yearflag='0')");
            returnsql.append(" and not exists (select 1 from v_perf_t_deptperfmiddeclare pd where pd.pro_code = t.pro_code)  ");
        }
        if(wheresql != null && !wheresql.isEmpty()){
            returnsql.append(" and (").append(wheresql).append(") ");
        }
        if (tablesql != null && !tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        returnsql.append(datarule);
        returnsql.append(" and (t.pro_cat_code in ('22','3'))");
        return returnsql.toString();
    }

    public Map<String, Object> saveProgramadjust(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>>  datas = (List<Map<String, Object>>) params.get("datas");
        String tablecode = "V_PERF_T_DEPTPERFMIDDECLARE";
        String workflow = (String)params.get("workflow");
        String bustype = (String) params.get("bustype");
        if (datas != null && datas.size() >= 0) {
            List<Map<String, Object>> adjustList = new ArrayList<Map<String, Object>>();
            Map<String, Object> adjustMap = null;
            for (Map<String, Object> map : datas) {
                String agencyguid = (String) map.get("agencyguid");
                adjustMap = new HashMap<String, Object>();
                adjustMap.put("guid", this.getCreateguid());
                adjustMap.put("proguid",  map.get("guid"));
                logger.info("获取年中项目编码："+map.get("pro_code"));
                adjustMap.put("pro_code",map.get("pro_code"));
                adjustMap.put("pro_name",map.get("pro_name"));
                adjustMap.put("createtime", StringUtil.getSysDBDate());
                adjustMap.put("updatetime", StringUtil.getSysDBDate());
                adjustMap.put("creater", SecureUtil.getCurrentUser().getGuid());
                adjustMap.put("province", SecureUtil.getUserSelectProvince());
                adjustMap.put("year", CommonUtil.getYear());
                adjustMap.put("wfid", workflow);
                adjustMap.put("agencyguid", agencyguid);
                adjustMap.put("finintorgguid", map.get("mof_dep_code"));
                adjustMap.put("bustype", bustype);
                adjustMap.put("manage_dept_code",map.get("manage_dept_code"));
                adjustMap.put("manage_mof_dep_code",map.get("manage_mof_dep_code"));
                adjustMap.put("mof_dep_code",map.get("mof_dep_code"));
                adjustMap.put("dept_code",map.get("dept_code"));
                adjustMap.put("setup_year",map.get("setup_year"));
                adjustMap.put("projectkind",map.get("projectkind"));          //支出项目类别
                adjustMap.put("pro_levone_code",map.get("pro_levone_code"));  //专项资金、一级项目编码
                adjustMap.put("create_time", map.get("create_time")); //项目创建时间
                adjustList.add(adjustMap);
            }
            this.workflow("create", workflow, "", tablecode, adjustList);
        }
        return backMap;
    }
}
