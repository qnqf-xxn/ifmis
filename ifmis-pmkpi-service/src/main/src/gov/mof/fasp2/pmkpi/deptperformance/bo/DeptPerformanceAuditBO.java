package gov.mof.fasp2.pmkpi.deptperformance.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.deptperformance.dao.DeptPerformanceAuditDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptPerformanceAuditBO extends PmkpiBO {

    private DeptPerformanceAuditDAO deptPerformanceAuditDAO;

    public void setDeptPerformanceAuditDAO(DeptPerformanceAuditDAO deptPerformanceAuditDAO) {
        this.deptPerformanceAuditDAO = deptPerformanceAuditDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf");
        String agency = (String)sqlmap.get("agency");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String workflow = (String) sqlmap.get("workflow");
        String orderby = (String) sqlmap.get("orderby");
        String tabcode = (String) sqlmap.get("tabcode");
        String datarule = this.getDataRuleByMenuguidNull(menuid,"t", null);
        StringBuffer sql = new StringBuffer("(select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where 1=1 ");
        if (wheresql != null && !StringUtils.isEmpty(wheresql)){
            sql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !StringUtils.isEmpty(tablesql)){
            sql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !StringUtils.isEmpty(tabfilter)){
            sql.append(" and ").append(tabfilter);
        }
        String wfsql = getWfSql(tabcode, workflow);
        if (wfsql != null && !StringUtils.isEmpty(wfsql)) {
            sql.append(" and (").append(wfsql).append(")");
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, deptPerformanceAuditDAO.PMKPI_TABLE_T_AGENCY));
        sql.append(datarule).append(")");
        return sql.toString();
    }

    /**
     * 获取左侧树显示数据.
     *
     * @param menuId
     *            -- 菜单.
     * @throws AppException
     *             -- 自定义异常
     * @rturn --
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getLeftTreeData(String menuId,String sysvalue)
            throws AppException {
        String tablecode = "v_perf_t_deptperfdeclare";
        String sql = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        //根据权限查询
        return deptPerformanceAuditDAO.getLeftTree(tablecode, sql);
    }

    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String sysvalue = deptPerformanceAuditDAO.getSystemDepttree();
        if (sysvalue == null || StringUtils.isEmpty(sysvalue)){
            //默认查询单位
            sysvalue="PMKPIAGENCYALLPAY";
        }
        leftconfig.put("datas", this.getLeftTreeData(menuId,sysvalue));
        return leftconfig;
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        HashMap<String, Object> map = new HashMap<>();
        map.put("modeltype", "dept");
        map.put("bustype", "dept");
        map.put("mainworkflow", workflow);
        map.put("subworkflow", "D744F2E4176C4D79BC053C1FEE4274D8");
        map.put("actioncode",actioncode );
        map.put("datas", datas);
        boolean iscancelEnd = false;//流程前判断是否为取消终审
        for (Map<String, Object> data : datas){
            String wfstatus = (String) data.get("wfstatus");
            if("cancelaudit".equals(actioncode) && !StringUtil.isEmpty(wfstatus) && "011".equals(wfstatus)){
                iscancelEnd = true;
            }
        }
        this.wfParallel(map);
        this.wfParallelAudit(map);
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        //20230606 部标2.0
        String istogether = PerfUtil.getSystemSet("DEPTGOALSINGLE"); //部门整体绩效申报是否与预算编制流程一起
        if (StringUtil.isEmpty(istogether) || "0".equals(istogether)){ //不在一起走流程，部门绩效单独处理
            List<Map<String, Object>> agencyList = new ArrayList<>();
            Map<String, Object> agencymap = null;
            boolean isEnd = false;//流程后判断是否为终审
            for (Map<String, Object> data : datas){
                String wfstatus = (String) data.get("wfstatus");
                if(("audit".equals(actioncode) || "auditbatch".equals(actioncode)) && !StringUtil.isEmpty(wfstatus) && "011".equals(wfstatus)){
                    isEnd = true;
                }
                agencymap = new HashMap<>();
                agencymap.put("guid", data.get("agencyguid"));
                agencyList.add(agencymap);
            }
            DeptPerformanceBO deptPerformanceBO = (DeptPerformanceBO) ServiceFactory.getBean("pmkpi.deptperformance.DeptPerformanceBOTX");
            if(isEnd){ //终审备份批复版本记录
                deptPerformanceBO.saveDeptPerfPfdata(agencyList,false);
            }
            if(iscancelEnd){ //取消终审删除批复版本记录
                deptPerformanceBO.delDeptPerfPfdata(agencyList,false);
            }
        }
        return this.auditdefine(datas, busguid, actioncode, null);
    }

}
