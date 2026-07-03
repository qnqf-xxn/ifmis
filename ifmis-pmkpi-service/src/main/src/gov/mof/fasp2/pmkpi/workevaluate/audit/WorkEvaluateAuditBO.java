package gov.mof.fasp2.pmkpi.workevaluate.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WorkEvaluateAuditBO extends PmkpiBO {
    private WorkEvaluateAuditDAO workEvaluateAuditDAO;

    public void setWorkEvaluateAuditDAO(WorkEvaluateAuditDAO workEvaluateAuditDAO) {
        this.workEvaluateAuditDAO = workEvaluateAuditDAO;
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
            tablecode = workEvaluateAuditDAO.PMKPI_TABLE_T_AGENCY;
            columncode = "agencyguid";
        } else if (lefttabtype != null && "subprovince".equals(lefttabtype)) {
            tablecode = "V_ELE_VD08001";
            columncode = "province";
        }
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select t.*,a.startdate,a.enddate,a.taskyear from ").append(workEvaluateAuditDAO.PERF_TABLE_WORKEVALUATE).append(" t left join v_perf_t_workevaluatetask a on a.guid=t.taskguid where t.bustype='").append(lefttabtype).append("' ");
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
                returnsql.append(" and (").append(wfsql).append(") ");
            }
        } else {
            if (!StringUtil.isEmpty(tabfilter)) {
                returnsql.append(" and (").append(tabfilter).append(") ");
            }
        }
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, tablecode));
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
            return workEvaluateAuditDAO.getLeftTree(workEvaluateAuditDAO.PERF_TABLE_WORKEVALUATE, datarule);
        } else {
            return workEvaluateAuditDAO.getLeftTreeProvince(workEvaluateAuditDAO.PERF_TABLE_WORKEVALUATE, datarule, "province");
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
            workEvaluateAuditDAO.saveAll(datas, workEvaluateAuditDAO.PMKPI_TABLE_TMP_AGENCY);
            String wheresql = " set t.wfstatus='" + subprostatus + "' where exists(select 1 from " + workEvaluateAuditDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid )";
            workEvaluateAuditDAO.updateDatas(tablecode, wheresql);
            for (Map<String, Object> data : datas) {
                data.put("wfstatus",subprostatus);
            }
        }
        // 处理规范表数据
        this.updateDeptEvalTabelDatas(datas, actioncode);
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 处理规范表数据
     * @param data
     * @param actioncode
     * @throws AppException
     */
    public void updateDeptEvalTabelDatas ( List<Map<String, Object>> data, String actioncode) throws AppException {
        workEvaluateAuditDAO.updateDeptEvalTabelDatas(data,actioncode);
    }
}
