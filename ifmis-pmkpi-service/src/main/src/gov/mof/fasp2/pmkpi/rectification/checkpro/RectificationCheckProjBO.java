package gov.mof.fasp2.pmkpi.rectification.checkpro;

import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.ca.user.util.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.datacommon.workflow.service.IWorkflowService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.evaluation.dept.audit.DeptAuditDAO;
import gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm.ProConfirmDAO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfApplyDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationAddProjDAO;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RectificationCheckProjBO extends PmkpiBO {

    IWorkflowService workflowService = (IWorkflowService) ServiceFactory.getBean("datacommon.wf.WorkflowService");

    private RectificationCheckProjDAO rectificationCheckProjDAO;

    public void setRectificationCheckProjDAO(RectificationCheckProjDAO rectificationCheckProjDAO) {
        this.rectificationCheckProjDAO = rectificationCheckProjDAO;
    }

    public Map save(HashMap config) throws AppException, ParseException {
        String projguid = (String) config.get("projguid");
        String projcode = (String) config.get("projcode");
        String procode = (String) config.get("pro_code");
        String bustype = (String) config.get("bustype");
        String type = (String)config.get("type");
        String workflow = (String) config.get("workflow");
        UserDTO user = SecureUtil.getCurrentUser();
        //获取项目信息
        Map projinfo = new HashMap();
        Map projMap = new HashMap();
        if ("FINEVALUATION".equals(type)){//财政重点评价
            projMap = getFinevaluation(projguid);
        }else if("RANDOMCOMMENT".equals(type)){
            projinfo = getProjInfo(procode);
        }
        // 新增
        List<String> guidList=new ArrayList<String>();
        Map<String,Object> Sqlparam=new HashMap<String, Object>();
        String guidNew= StringUtil.createUUID();
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        if (projinfo != null || projinfo.size()>0 || projMap != null || projMap.size()>0){
            Sqlparam.put("guid", guidNew);
            Sqlparam.put("state", "0");
            Sqlparam.put("createuid", user.getGuid());
            Sqlparam.put("createuname", user.getName());
            Sqlparam.put("createtime", StringUtil.getDateBySimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
            Sqlparam.put("delstatus", "0");
            Sqlparam.put("province", user.getProvince());
            Sqlparam.put("year", CommonUtil.getYear());
            Sqlparam.put("proguid", projguid);
            Sqlparam.put("creater", user.getName());
            //财政重点评价(组织评价机构)
            Sqlparam.put("evalmeach", ("FINEVALUATION").equals(type)? projMap.get("evalmeach"):null);
            Sqlparam.put("projname", ("RANDOMCOMMENT").equals(type)? projinfo.get("pro_name"):projMap.get("projname"));
            if (("RANDOMCOMMENT").equals(type)){
                Sqlparam.put("projcode", projinfo.get("pro_code"));
                Sqlparam.put("pro_code", projinfo.get("pro_code"));
            }
            Sqlparam.put("agencyguid", ("RANDOMCOMMENT").equals(type)? projinfo.get("agencyguid"):projMap.get("agencyguid"));
            Sqlparam.put("finintorgguid", ("RANDOMCOMMENT").equals(type)? projinfo.get("finintorgguid"):projMap.get("finintorgguid"));
            Sqlparam.put("bustype", bustype);
            Sqlparam.put("type", type);
            Sqlparam.put("rectype","绩效抽评");
            Sqlparam.put("status", "1");
            //isfinal=1(已终审) isfinal = 2(未终审)
            Sqlparam.put("isfinal", "2");
            //保存数据
            rectificationCheckProjDAO.save(Sqlparam, RectificationAddProjDAO.PERF_T_RECTIFY);
            guidList.add(guidNew);
            l.add(Sqlparam);
            workflowService.createProcess(workflow, guidList);
        }
        config.put("success", true);
        return config;
    }

    //获取左侧树
    public Map<String, Object> getTreeData(String lefttabtype) throws AppException {
        List<Map<String, Object>> eledatas = rectificationCheckProjDAO.getDatas("v_perf_t_datasource", "elementcode='rectifytype'", "order by ordernum");
        String type ="dept";
        String wheresql = "tasktype = 'protrace'";
        if (lefttabtype.equals(type)){
            wheresql = "tasktype = 'depttrace'";
        }
        List<Map<String, Object>> taskdata = rectificationCheckProjDAO.getDatas("V_PERF_T_TASKSET", wheresql, "order by taskstage");
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        List<Map<String, Object>> data = new ArrayList<>();
        for (Map<String, Object> eledata : eledatas) {
            data.add(eledata);
        }
        for (Map<String, Object> taskdatum : taskdata) {
            data.add(taskdatum);
        }
        leftconfig.put("name", "业务阶段");
        //leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", data);
        leftconfig.put("outformart", "#name");
        leftconfig.put("expandlevel", 2);
        return leftconfig;
    }

    /**
     * @param
     * @remark 根据项目id获取项目信息
     * @return
     */
    public Map getProjInfo(String projcode) {
        String wheresql = "pro_code=?";
        return this.getDataMap(rectificationCheckProjDAO.PMKPI_TABLE_PROJECT_INFO, wheresql, new String[]{projcode});
    }

    /**
     * @param
     * @remark 根据项目id获取项目信息
     * @return
     */
    public Map getFinevaluation(String projguid) {
        String wheresql = "guid=?";
        return this.getDataMap("v_perf_t_finevaluation", wheresql, new String[]{projguid});
    }

    public String getVodSql(Map sqlmap) throws AppException {
        UserDTO user = SecureUtil.getCurrentUser();
        String bustype = (String) sqlmap.get("bustype");
        String treeid = (String)sqlmap.get("treeid");
        String superguid = (String)sqlmap.get("superguid");
        String taskguid = (String)sqlmap.get("taskguid");
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String querySql = (String) sqlmap.get("querySql");
        String defquery = (String) sqlmap.get("defquery");
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String type = (String) sqlmap.get("type");
        String isZJ = PerfUtil.getSystemSet("isZJ"); //判断是否是浙江环境
        logger.debug("--------------是否浙江环境选择项目"+isZJ);
        StringBuffer sb = new StringBuffer();
        String lefttype ="dept";
        String sql = "";
        if(isZJ != null && "1".equals(isZJ) && ("RANDOMCOMMENT".equals(type) || "FINEVALUATION".equals(type))) {
            sb.append("select * from ");
            if (type != null && "RANDOMCOMMENT".equals(type)) { //抽评
                sb.append("perf_v_randomrectify_proj").append(" t  where");
                sb.append(" bustype = '").append(bustype).append("' ");
                sb.append(" and (ISFINAL != '2' or  ISFINAL is null)");
            } else if (type != null && "FINEVALUATION".equals(type)) {//财政重点评价
                sb.append("PERF_V_FINRECTIFY_PROJ").append(" t where ");
                sb.append("  (ISFINAL != '2' or  ISFINAL is null)");
                sb.append(" and t.EVALMEACH = '" + user.getDivision() + "'");
            }
            if (querySql != null && !querySql.isEmpty()) {
                sb.append(" and (").append(querySql).append(")");
            }
            if (defquery != null && !defquery.isEmpty()) {
                sb.append(" and ").append(defquery);
            }
            logger.debug("RectificationAddProjBO.getVodSql.querySql=" + sb.toString());
        } else {
            //区分项目支出和部门整体
            if (!StringUtil.isEmpty(lefttabtype) && lefttabtype.equals(lefttype)) {
                sql = " and t.bustype = 'dept'";
            } else {
                sql =" and t.bustype = 'program'";
            }
            if (treeid .equals("rectifyperfself")) {  //绩效自评
                tablecode = PerfSelfApplyDAO.SELFEVALTASK_TABLE;
                if (!lefttabtype.equals(lefttype)) {
                    sql =" and t.bustype <> 'dept'";
                }
            } else if (treeid .equals("rectifydepteval")) {  //部门评价
                tablecode = DeptAuditDAO.PERF_TABLE_DEPTEVAL;
            } else if (treeid .equals("rectifyfinancialeval")) {  //财政评价
                tablecode = ProConfirmDAO.PERF_TABLE_PROCONFIRM;
            } else if (treeid.equals("rectifytrace") || "rectifytrace".equals(superguid)) {
                tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE;
                if (!StringUtil.isEmpty(lefttabtype) && lefttabtype.equals(lefttype)) {
                    sql = " and t.tasktype='depttrace'";
                } else {
                    sql = " and t.tasktype='protrace'";
                }
                if (!"00".equals(superguid)) {
                    sql += " and t.taskguid = '" + taskguid + "'";
                }
                if (PerfUtil.getIsNINGXIA()) {
                    sql += " and t.provincetask='1'";
                }
            }
            String datarule = this.getDataRuleByMenuguid(leftmenuid, "t", "1=1"); //数据权限
            sb.append("select * from ").append(tablecode).append(" t where ");
            sb.append(datarule);
            if (!StringUtil.isEmpty(sql)){
                sb.append(sql);
            }
            sb.append(" and not exists(select 1 from ").append(RectificationAddProjDAO.PERF_T_RECTIFY).append(" a where");
            //项目支出用pro_code，部门整体用proguid
            if (PerfUtil.getIsHbei() || lefttype.equals(lefttabtype) || treeid.equals("rectifydepteval")) {
                if (treeid.equals("rectifyperfself")) {
                    sb.append(" a.proguid = t.projguid");  //自评表中项目guid是projguid
                } else {
                    sb.append(" a.proguid = t.proguid");  //其他表项目guid是proguid
                }
            } else {
                sb.append(" a.pro_code = t.pro_code");
            }
            String wheresql ="";
            if (!"00".equals(superguid)) {
                wheresql = " and a.taskguid = t.taskguid and a.rectype = '"+superguid+"'";
            } else {
                wheresql = " and a.rectype = '"+ treeid +"'";
                if (treeid.equals("rectifytrace")) {  //绩效监控
                    wheresql += " and a.taskguid = t.taskguid ";
                }
            }
            sb.append(" and a.wfstatus<>'011'").append(wheresql).append(")");
            if(querySql != null && !querySql.isEmpty()){
                sb.append(" and ").append(querySql);
            }
            if(defquery != null && !defquery.isEmpty()){
                sb.append(" and ").append(defquery);
            }
            if (tabfilter != null && !tabfilter.isEmpty()){
                sb.append(" and ").append(tabfilter);
            }
        }
        return sb.toString();
    }
}
