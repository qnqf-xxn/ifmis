package gov.mof.fasp2.pmkpi.workevaluate.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WorkEvaluateReportBO extends PmkpiBO {
    private WorkEvaluateReportDAO workEvaluateReportDAO;

    public void setWorkEvaluateReportDAO(WorkEvaluateReportDAO workEvaluateReportDAO) {
        this.workEvaluateReportDAO = workEvaluateReportDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String columncode = "";
        String tablecode = "";
        if (lefttabtype != null && "dept".equals(lefttabtype)) {
            tablecode = workEvaluateReportDAO.PMKPI_TABLE_T_AGENCY;
            columncode = "agencyguid";
        } else if (lefttabtype != null && "subprovince".equals(lefttabtype)) {
            tablecode = "V_ELE_VD08001";
            columncode = "subprovince";
        }
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select t.*,a.startdate,a.enddate,a.taskyear from PERF_T_WORKTASKASSIGN").append(" t left join perf_t_workevaluatetask a on a.guid=t.taskguid and a.year=").append(SecureUtil.getUserSelectYear()).append(" where t.bustype='").append(lefttabtype).append("' and t.year =").append(SecureUtil.getUserSelectYear());
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (wheresql != null && !wheresql.isEmpty()){
            wheresql = wheresql.toLowerCase();
            wheresql = wheresql.replaceAll("name","t.name");
            returnsql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        if (lefttabtype != null && "dept".equals(lefttabtype)) { //预算部门走数据权限，县区不走
            if (tabfilter != null && !tabfilter.isEmpty()){
                returnsql.append(" and ").append(tabfilter);
            }
            String wfsql = this.getWfSql(tabcode, workflow,"t");
            if (wfsql != null && !wfsql.isEmpty()) {
                wfsql = wfsql.replace("GUID IN", "t.GUID IN");
                returnsql.append(" and (").append(wfsql);
                if (tabcode != null && "waitaudit".equals(tabcode)) {
                    returnsql.append(" or wfstatus is null ");
                }
                returnsql.append(") ");
            }
            returnsql.append(" and t.province='").append(SecureUtil.getUserPartitionProvince()).append("' ");
        } else if (lefttabtype != null && "subprovince".equals(lefttabtype)) {
            if (!StringUtil.isEmpty(tabfilter)) {
                returnsql.append(" and (").append(tabfilter);
            }
            if (tabcode != null && "waitaudit".equals(tabcode)) {
                returnsql.append(" or wfstatus is null ");
            }
            returnsql.append(") ");
        }
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, tablecode));
        if (lefttabtype != null && "subprovince".equals(lefttabtype)) {
            datarule = datarule.replace("t.province", "t." + columncode);
        }
        returnsql.append(datarule);
        return returnsql.toString();
    }

    /**
     * 查询左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String bustype = (String) params.get("bustype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype = '" + bustype + "'";
        if (bustype != null && "dept".equals(bustype)) {
            return workEvaluateReportDAO.getLeftTree(workEvaluateReportDAO.PERF_TABLE_WORKEVALUATE, datarule);
        } else {
            datarule = datarule.replace("t.province","t.subprovince");
            return workEvaluateReportDAO.getLeftTreeProvince("perf_t_worktaskassign", datarule,"subprovince");
        }
    }

    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String busguid = (String) params.get("busguid");
        String bustype = (String) params.get("bustype");
        String tablecode = "perf_t_worktaskassign";
        String actioncode = (String) params.get("actioncode");
        if (bustype != null && "dept".equals(bustype)) {
            String workflow = (String) params.get("workflow");
            String remark = (String) params.get("remark");
            this.workflow(actioncode, workflow, remark, tablecode, datas);
        } else {
            String subprostatus = (String) params.get("subprostatus");//区县状态编码，区县审核才传
            workEvaluateReportDAO.saveAll(datas, workEvaluateReportDAO.PMKPI_TABLE_TMP_AGENCY);
            String wheresql = " set t.wfstatus='" + subprostatus + "' where exists(select 1 from " + workEvaluateReportDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid )";
            workEvaluateReportDAO.updateDatas(tablecode, wheresql);
        }
        return this.auditdefine(datas, busguid, "perf", null);
    }
}
