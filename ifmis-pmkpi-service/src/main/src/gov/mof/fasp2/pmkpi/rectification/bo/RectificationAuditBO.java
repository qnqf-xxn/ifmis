package gov.mof.fasp2.pmkpi.rectification.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.datacommon.workflow.dto.WorkflowBranchDTO;
import gov.mof.fasp2.datacommon.workflow.service.IWorkflowService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationAddProjDAO;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationAuditDAO;
import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RectificationAuditBO extends PmkpiBO {
    private RectificationAuditDAO rectificationAuditDAO;

    public void setRectificationAuditDAO(RectificationAuditDAO rectificationAuditDAO) {
        this.rectificationAuditDAO = rectificationAuditDAO;
    }

    IWorkflowService workflowService = (IWorkflowService) gov.mof.fasp2.buscore.framework.util.ServiceFactory.getBean("datacommon.wf.WorkflowService");

    /**
     * 根据左侧页签和数据反查左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getLeftTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = RectificationAddProjDAO.PERF_T_RECTIFY;
        String bustype = (String) params.get("bustype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        datarule += " and bustype='" + bustype + "' ";
        return rectificationAuditDAO.getLeftTree(tablecode,datarule);
    }

    //退回
    public Map back(HashMap config) throws AppException {
        String workflow = (String) config.get("workflow");
        String wfid="";
        String guid = (String) config.get("guid");
        if(guid != null && guid != ""){
            rectificationAuditDAO.update("update PERF_T_RECTIFY set STATUS = '1' where guid ='"+guid+"'");
        }
        List guids = new ArrayList();
        guids.add(guid);
        //获取流程id
        String getWfidSql = "select guid from BUSFW_T_DCWORKFLOWPLAN where guid='"+workflow+"'";
        List mapwfids = rectificationAuditDAO.queryForList(getWfidSql);//List<Map>类型的流程方案ids
        if(null!=mapwfids&&mapwfids.size()>0){
            wfid = (String)((Map)mapwfids.get(0)).get("guid");
        }
        workflowService.multiBackProcess(wfid, guids,"");
        return config;
    }

    //下发
    public Map send(HashMap config) throws AppException {
        String workflow = (String) config.get("workflow");
        String wfid="";
        String guid = (String) config.get("guid");

        String sqlList = "select wfid,wfstatus from PERF_T_RECTIFY where guid = '"+guid+"'";
        List forList = rectificationAuditDAO.queryForList(sqlList);
        Map mapList = (Map)forList.get(0);
        String wfstatus = (String)mapList.get("wfstatus");
        List<WorkflowBranchDTO> WorkflowBranchDTOList = workflowService.queryWorkflowBranchsByWfStatus(workflow, wfstatus);
        if (WorkflowBranchDTOList != null && WorkflowBranchDTOList.size() > 0){
            String configs = WorkflowBranchDTOList.get(0).getConfig();
            if(configs != null && "audit".equals(configs)){
                rectificationAuditDAO.update("update PERF_T_RECTIFY set status = '2' where guid ='"+guid+"'");
            }
        }
/*        if(guid != null && guid != ""){
            rectificationAuditDAO.update("update PERF_T_RECTIFY set STATUS = '2' where guid ='"+guid+"'");
        }*/
        List guids = new ArrayList();
        guids.add(guid);
        //获取流程id
        String getWfidSql = "select guid from BUSFW_T_DCWORKFLOWPLAN where guid ='"+workflow+"'";
        List mapwfids = rectificationAuditDAO.queryForList(getWfidSql);//List<Map>类型的流程方案ids
        if(null != mapwfids && mapwfids.size() > 0){
            wfid = (String)((Map)mapwfids.get(0)).get("guid");
        }
        workflowService.doProcess(wfid, guids);
        return config;
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
        workflow = getWorkflow(workflow,datas); //获取对应的工作流id
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 表格查询
     * @param sqlmap
     * @return
     * @throws AppException
     */
    public String getVodSql(Map sqlmap) throws AppException {
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(rectificationAuditDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        //页面类型
        String wheresql = (String) sqlmap.get("querySql");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String workflow = (String) sqlmap.get("workflow");
        String tabcode = (String) sqlmap.get("tabcode");
        String bustype = (String) sqlmap.get("bustype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String type = (String) sqlmap.get("type");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        // 获取数据权限
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where t.province='").append(province).append("'");
        sql.append(" and t.year=").append(year);
        sql.append(" and t.bustype=").append(bustype);
        sql.append(" and ").append(datarule);
        if (wheresql != null && !wheresql.isEmpty()){
            sql.append(" and ").append(wheresql);
        }
        /*if (type != null && !type.isEmpty()){
            sql.append(" and t.type ='").append(type).append("'");
        }*/
        if (tablesql != null && !tablesql.isEmpty()){
            sql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            sql.append(" and ").append(tabfilter);
        }
        //循环过滤条件
        String wfsql = " ";
        String[] str = null;
        if (workflow != null && !workflow.isEmpty()) {
            workflow = workflow.substring(1, workflow.length() - 1);  //去掉字符串首尾的大括号{}
            str = workflow.split(",");
            for (int i = 0; i < str.length; i++) {
                int index = str[i].indexOf("'");
                str[i] = str[i].substring(index + 1, str[i].length() - 1);
                wfsql += this.getWfSql(tabcode, str[i]);
                if (i < str.length - 1) {
                    wfsql += " or ";
                }
            }
            if (wfsql != null && !wfsql.isEmpty()) {
                sql.append("  and (").append(wfsql).append(")");
            }
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, rectificationAuditDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }


    public String getWorkflow(String workflow,List<Map<String, Object>> datas){
        //根据数据的业务阶段选择对应的工作流    绩效监控、绩效自评、部门评价、财政评价
        String  rectype = (String) datas.get(0).get("rectype");
        String newWorkflow = workflow.substring(1, workflow.length() - 1);  //去掉字符串首尾的大括号{}
        String[] str = newWorkflow.split(",");
        for(String wfid : str) {
            String[] entry = wfid.split(":");
            entry[1] = StringUtils.substringBetween(entry[1], "'", "'"); //去掉字符串首尾的单引号''
            if (rectype != null && entry[0].trim().equals(rectype)){
                newWorkflow =entry[1];
                break;
            }
        }
        return newWorkflow;
    }

}
