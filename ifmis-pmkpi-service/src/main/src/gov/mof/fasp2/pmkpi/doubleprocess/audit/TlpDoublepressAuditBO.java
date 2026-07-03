package gov.mof.fasp2.pmkpi.doubleprocess.audit;

import com.alibaba.fastjson.JSON;
import gov.mof.fasp2.buscommon.micro.MicroParamDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.datacommon.workflow.dto.WorkflowBranchDTO;
import gov.mof.fasp2.datacommon.workflow.service.IWorkflowService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.doubleprocess.otherapp.IBdmInterface;
import gov.mof.fasp2.pmkpi.doubleprocess.otherapp.IPdmInterface;
import gov.mof.fasp2.pmkpi.doubleprocess.report.TlpDoublepressBO;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TlpDoublepressAuditBO extends PmkpiBO {

    /**
     * 日志.
     */
    private final static Logger log = Logger.getLogger(TlpDoublepressAuditBO.class);
	
	private TlpProgramAuditDAO tlpProgramAuditDAO;

	public void setTlpProgramAuditDAO(TlpProgramAuditDAO tlpProgramAuditDAO) {
		this.tlpProgramAuditDAO = tlpProgramAuditDAO;
	}

    private TlpDoublepressBO tlpProgramBO;

    @Resource(name = "pmkpi.doubleprocess.TlpProgramBO")
    public void setTlpProgramBO(TlpDoublepressBO tlpProgramBO) {
        this.tlpProgramBO = tlpProgramBO;
    }

    private IWorkflowService workflowService;

    public IWorkflowService getWorkflowService() {
        if(workflowService == null){
            workflowService =(IWorkflowService) ServiceFactory.getBean("datacommon.wf.WorkflowService");
        }
        return workflowService;
    }
    /**
    *
    * @param sqlmap
    * @return
    * @throws AppException
    */
   @Override
   public String getVodSql(Map sqlmap) throws AppException {
       String wheresql = (String) sqlmap.get("querySql");
       String menuid = (String)sqlmap.get("menuid");
       String isleaf = (String)sqlmap.get("isleaf");
       String agency = (String)sqlmap.get("agency");
       String tablecode = (String)sqlmap.get("tablecode");
       String tabfilter = (String) sqlmap.get("tabfilter");
       String workflow = (String) sqlmap.get("workflow");
       String tablesql = (String) sqlmap.get("tablesql");//查询条件
       String orderby = (String) sqlmap.get("orderby");
       String tabcode = (String) sqlmap.get("tabcode");
       String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
       Integer year = SecureUtil.getUserSelectYear();
       String province = SecureUtil.getUserSelectProvince();
       StringBuffer sql = new StringBuffer("select * from ");
       sql.append(tablecode).append(" t ");
       sql.append(" where t.province='").append(province).append("'");
       sql.append(" and t.year=").append(year);
       String columncode = "agencyguid";
       sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, tlpProgramAuditDAO.PMKPI_TABLE_T_AGENCY));
       sql.append(datarule);
       if (!StringUtils.isEmpty(wheresql)){
           sql.append(" and ( ").append(wheresql).append(" )");
       }
       if (!StringUtils.isEmpty(tabfilter)){
           sql.append(" and ").append(tabfilter);
       }
       if (!StringUtils.isEmpty(tablesql)){
           sql.append(" and ").append(tablesql);
       }
       String wfsql = getWfSql(tabcode, workflow);
       if (!StringUtils.isEmpty(wfsql)) {
           sql.append(" and ").append(wfsql);
       }
       if (!StringUtils.isEmpty(orderby)){
           sql.append(" ").append(orderby);
       }
       return sql.toString();
   }


    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId, String prolev) throws AppException {
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("menuid",menuId);
        leftconfig.put("datas", this.getTreeData(map));
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
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        //校验项目库项目资金状态  资金超过则送审至绩效处审核  否则绩效流程不经过绩效处（仅应用于业务处公用送审至业务处审核岗）
        Map<String, Object> checkMap = checkPdmCapital(params);
        if (checkMap != null && checkMap.size()>0){
            String bool = String.valueOf(checkMap.get("bool"));
            if ("false".equals(bool)){
                Map result = new HashMap<String, Object>();
                String errmsg ="Y";
                String errtype = "tips";
                result.put("redata",new ArrayList());
                result.put("success", false);
                result.put("msg", errmsg);
                result.put("errmsg", errmsg);
                result.put("errtype", errtype);
                return result;
            }
        }
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 获取预算中单位的流程状态，判断接口.
     * @param params -- 前端参数.
     * @return list.
     */
    public Map<String, Object> getBdmWfstatus(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<>();
        log.info("========================bdm开始========================");
        IBdmInterface pmkpiinterface = gov.mof.fasp2.buscore.framework.util.ServiceFactory.getFeignClient(IBdmInterface.class);
        log.info("========================1========================");
        List<Map<String, Object>> programs = (List<Map<String, Object>>) params.get("programs");
        MicroParamDTO paramDTO = new MicroParamDTO();
        List list = new ArrayList();
        List<String> agencyList = new ArrayList<>();
        String agencyid = "";
        Map temMap = null;
        for (Map<String, Object> temppro: programs) {
            agencyid = (String) temppro.get("agencyguid");
            if (agencyList.contains(agencyid)){
                continue;
            }
            temMap = new HashMap();
            temMap.put("agency_code",agencyid);
            temMap.put("mof_div_code",SecureUtil.getUserSelectProvince());
            temMap.put("fiscal_year",SecureUtil.getUserSelectYear());
            list.add(temMap);
        }
        log.info("=============2===");
        log.info(list.toString());
        log.info("====请求预算服务状态========");
        paramDTO.setList(list);
        MicroParamDTO dto = pmkpiinterface.querytaskflow(paramDTO);
        boolean flag = dto.isBool();
        log.info("============="+flag+"================");
        backMap.put("bool",flag);
        if (!flag){
            backMap.put("mesg",dto.getStr1());
            return  backMap;
        }
        List backAgencys = dto.getList();
        /*List backAgencys = new ArrayList();
        Map temMap1 = new HashMap();
        temMap1.put("agency_code","001001");
        temMap1.put("mof_div_code",SecureUtil.getUserSelectProvince());
        temMap1.put("fiscal_year",SecureUtil.getUserSelectYear());
        temMap1.put("wfstatus","008");
        backAgencys.add(temMap1);*/
        log.info("======= end ======"+backAgencys.toString()+"================");
        Map<String, Object> wfListMap = new HashMap<String, Object>(); //单位对应的项目允许状态
        Map<String, Object> perBdmWfMap = new HashMap<String, Object>(); //预算对应的前状态
        List<Map<String, Object>> wfList = tlpProgramAuditDAO.findPBdmWf(); //工作流对应状态
        String bdmwf = "";
        String perfwf = ""; //绩效状态
        String beforewf = "";
        for (Map<String, Object> tempwf: wfList) {
            bdmwf = (String) tempwf.get("bdmwf");
            perfwf = (String) tempwf.get("perfwf");
            beforewf = (String) tempwf.get("beforewf");
            wfListMap.put(bdmwf,beforewf);
            perBdmWfMap.put(bdmwf,perfwf);
        }
        Map<String, Object> agencyWfMap = new HashMap<String, Object>(); //返回单位状态
        Map temAgencyMap = null;
        String wfstatus = "";
        for (int i = 0; i < backAgencys.size(); i++) {
            temAgencyMap = (Map) backAgencys.get(i);
            agencyid = (String) temAgencyMap.get("agency_code");
            wfstatus = (String) temAgencyMap.get("wfstatus");
            agencyWfMap.put(agencyid,wfstatus);
        }
        //处理项目对应的状态是否可走
        String proname = "";
        String prowfstatus = "";
        String proagency = "";
        String busguid  = "";
        StringBuffer message = new StringBuffer();
        log.info("=======查询的单位状态"+agencyWfMap.toString()+"=====");
        for (Map<String, Object> temppro: programs) {
            busguid = (String) temppro.get("guid");
            proname = (String) temppro.get("pro_name");
            prowfstatus = (String) temppro.get("wfstatus"); //项目状态
            proagency = (String) temppro.get("agencyguid");
            wfstatus  = (String) agencyWfMap.get(proagency);//单位获取的状态.
            beforewf = (String) wfListMap.get(wfstatus); //单位允许的状态
            if (beforewf.indexOf(";"+prowfstatus+";") < 0){
                message.append("[").append(proname).append("]").append("的绩效状态不能早于预算状态！");
            }
            if (prowfstatus.equals(perBdmWfMap.get(wfstatus))){
                String sql = "update V_PERF_PROJECT_INFODP t set t.islast = 0, t.is_deleted = 1 where  t.agencyguid = '" + proagency + "' and t.guid = '" + busguid + "'";
                log.info("=======预算绩效一致，消除退回"+"单位："+proagency+"业务主键"+busguid.toString()+"=====");
                tlpProgramAuditDAO.update(sql);
            }
        }
        if (message.length() > 0){
            backMap.put("bool",false);
        }
        backMap.put("mesg",message.toString());
        return backMap;
    }

    /**
     * 获取项目库中项目的流程状态，判断接口.
     * @param params -- 前端参数.
     * @return list.
     */
    public Map<String, Object> getPmWfstatus(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<>();
        log.info("========================Pm开始========================");
        IPdmInterface pmkpiinterface = gov.mof.fasp2.buscore.framework.util.ServiceFactory.getFeignClient(IPdmInterface.class);
        log.info("========================1========================");
        List<Map<String, Object>> programs = (List<Map<String, Object>>) params.get("programs");
        log.info("========================programs========================"+programs);
        MicroParamDTO paramDTO = new MicroParamDTO();
        List list = new ArrayList();
        List<String> proList = new ArrayList<>();
        String proguid = "";
        Map temMap = null;
        for (Map<String, Object> temppro: programs) {
            String pro_code = (String) temppro.get("pro_code");
            Map<String, Object> infoMap = tlpProgramAuditDAO.getDataMap("v_perf_project_info", " pro_code ='" + pro_code + "'");
            proguid = (String) infoMap.get("pro_id");//项目id
            temppro.put("pro_id",proguid);
            if (proList.contains(proguid)){
                continue;
            }
            temMap = new HashMap();
            temMap.put("proguid",proguid);
            temMap.put("mof_div_code",SecureUtil.getUserSelectProvince());
            temMap.put("fiscal_year",SecureUtil.getUserSelectYear());
            list.add(temMap);
        }
        log.info("=============2===");
        log.info(list.toString());
        log.info("====请求项目库服务状态========"+list);
        paramDTO.setList(list);
        MicroParamDTO dto = pmkpiinterface.querytaskflow(paramDTO);
        boolean flag = dto.isBool();
        log.info("============="+flag+"================");
        backMap.put("bool",flag);
        if (!flag){
            backMap.put("mesg",dto.getStr1());
            return  backMap;
        }
        List backPros = dto.getList();
        /*List backAgencys = new ArrayList();
        Map temMap1 = new HashMap();
        temMap1.put("agency_code","001001");
        temMap1.put("mof_div_code",SecureUtil.getUserSelectProvince());
        temMap1.put("fiscal_year",SecureUtil.getUserSelectYear());
        temMap1.put("wfstatus","008");
        backAgencys.add(temMap1);*/
        log.info("======= end ======"+backPros.toString()+"================");
        Map<String, Object> wfListMap = new HashMap<String, Object>(); //单位对应的项目允许状态
        Map<String, Object> perPdmWfMap = new HashMap<String, Object>(); //预算对应的前状态
        List<Map<String, Object>> wfList = tlpProgramAuditDAO.findPBdmWf(); //工作流对应状态
        log.info("======= 工作流对应状态 ======"+wfList.toString()+"================");
        String bdmwf = "";
        String perfwf = ""; //绩效状态
        String beforewf = "";
        for (Map<String, Object> tempwf: wfList) {
            bdmwf = (String) tempwf.get("bdmwf");
            perfwf = (String) tempwf.get("perfwf");
            beforewf = (String) tempwf.get("beforewf");
            wfListMap.put(bdmwf,beforewf);
            perPdmWfMap.put(bdmwf,perfwf);
        }
        Map<String, Object> agencyWfMap = new HashMap<String, Object>(); //返回单位状态
        Map temAgencyMap = null;
        String wfstatus = "";
        for (int i = 0; i < backPros.size(); i++) {
            temAgencyMap = (Map) backPros.get(i);
            proguid = (String) temAgencyMap.get("proguid");
            wfstatus = (String) temAgencyMap.get("wfstatus");
            agencyWfMap.put(proguid,wfstatus);
        }
        //处理项目对应的状态是否可走
        String proname = "";
        String prowfstatus = "";
        String proagency = "";
        String busguid  = "";
        StringBuffer message = new StringBuffer();
        log.info("=======查询的单位状态"+agencyWfMap.toString()+"=====");
        for (Map<String, Object> temppro: programs) {
            busguid = (String) temppro.get("guid");
            proname = (String) temppro.get("pro_name");
            prowfstatus = (String) temppro.get("wfstatus"); //项目状态
            proagency = (String) temppro.get("pro_id");
            wfstatus  = (String) agencyWfMap.get(proagency);//项目获取的状态.
            beforewf = (String) wfListMap.get(wfstatus); //项目允许的状态
            log.info("======= beforewf ======"+beforewf+"================");
            log.info("======= prowfstatus ======"+prowfstatus+"================");
            log.info("======= perPdmWfMap.get(wfstatus) ======"+perPdmWfMap.get(wfstatus).toString()+"================");
            if (beforewf.indexOf(";"+prowfstatus+";") < 0){
                message.append("[").append(proname).append("]").append("的绩效状态不能早于项目库状态！");
            }
            if (prowfstatus.equals(perPdmWfMap.get(wfstatus))){
                String sql = "update V_PERF_PROJECT_INFODP t set t.islast = 0, t.is_deleted = 1 where  t.pro_id = '" + proagency + "' and t.guid = '" + busguid + "'";
                log.info("=======预算绩效一致，消除退回"+"项目："+proagency+"业务主键"+busguid.toString()+"=====");
                tlpProgramAuditDAO.update(sql);
            }
        }
        if (message.length() > 0){
            backMap.put("bool",false);
        }
        backMap.put("mesg",message.toString());
        return backMap;
    }

    /**
     * 校验项目库项目资金是否超过某个额度 超过绩效单独流程送至绩效处  未超过则不通过绩效处审核.
     * @param params
     * @return
     */
    public Map<String, Object> checkPdmCapital(HashMap<String, Object> params){
        Map map = new HashMap<String, Object>();
        map.put("bool", true);
        map.put("mesg", "成功!");
        try {
            List<Map<String, Object>> programs = (List<Map<String, Object>>) params.get("datas");
            IPdmInterface pmkpiinterface = gov.mof.fasp2.buscore.framework.util.ServiceFactory.getFeignClient(IPdmInterface.class);
            List list = new ArrayList();
            List<String> proList = new ArrayList<>();
            String proguid = "";
            Map temMap = null;
            if (programs != null && programs.size() > 0) {
                for (Map<String, Object> temppro : programs) {
//                    proguid = String.valueOf(temppro.get("pro_id"));
                    String pro_code = (String) temppro.get("pro_code");
                    Map<String, Object> infoMap = tlpProgramAuditDAO.getDataMap("v_perf_project_info", " pro_code ='" + pro_code + "'");
                    proguid = (String) infoMap.get("pro_id");//项目id
                    String wfstatus = String.valueOf(temppro.get("wfstatus"));
                    String workflow = String.valueOf(temppro.get("wfid"));
                    //校验当前审核节点
                    List<WorkflowBranchDTO> WorkflowBranchDTOList = getWorkflowService().queryWorkflowBranchsByWfStatus(workflow, wfstatus);
                    if (WorkflowBranchDTOList != null && WorkflowBranchDTOList.size() > 0) {
                        String configs = WorkflowBranchDTOList.get(0).getConfig();
                        Map jsonMap =new HashMap();
                        String checkPdmCapital = "";
                        if (configs != null && !configs.equals("")){
                            jsonMap = JSON.parseObject(configs, HashMap.class);
                            checkPdmCapital = String.valueOf(jsonMap.get("checkPdmCapital"));
                        }
                        //当前审核节点为业务处经办-业务处审核岗
                        if (jsonMap != null && jsonMap.size()>0 && "1".equals(checkPdmCapital)) {
                            //组装参数 调用项目库接口判断项目资金
                            if (proList.contains(proguid)) {
                                continue;
                            }
                            temMap = new HashMap();
                            temMap.put("proguid", proguid);
                            proList.add(proguid);
                            temMap.put("mof_div_code", SecureUtil.getUserSelectProvince());
                            temMap.put("fiscal_year", SecureUtil.getUserSelectYear());
                            list.add(temMap);
                        } else {
                            continue;
                        }

                    }
                }
                if (list !=null && list.size()>0){
                    logger.debug("--------------请求项目库资金参数----------------" + list);
                    HashMap paramMap = new HashMap<String,Object>();
                    paramMap.put("datalist",list);
                    paramMap.put("mof_div_code",SecureUtil.getUserSelectProvince());
                    paramMap.put("fiscal_year",SecureUtil.getUserSelectYear());
                    Map resultMap = pmkpiinterface.queryproveramt(paramMap);
                    logger.debug("--------------请求项目库资金结果----------------result" + resultMap.get("result").toString());
                    logger.debug("--------------请求项目库资金结果----------------datalist" + resultMap.get("datalist").toString());
                    if (resultMap != null && resultMap.size() > 0) {
                        String result = String.valueOf(resultMap.get("result"));
                        if ("true".equals(result)) {
                            String datalist = resultMap.get("datalist").toString();
                            if (datalist.startsWith("[") && datalist.endsWith("]")){
                                datalist = datalist.substring(1, datalist.length()-1);
                            }
                            String[] resultList = null;
                            if (datalist != null && !"".equals(datalist)){
                                resultList = datalist.split(",");
                            }
                            if (resultList != null && resultList.length>0){

                                List passdata = new ArrayList<HashMap>();
                                for(String pro_id :resultList){
                                    Map<String, String> pass = new HashMap<String, String>();
                                    pass.put("mainguid", pro_id);
                                    pass.put("bustype", "program");
                                    passdata.add(pass);
                                }
                                HashMap<String, Object> passparams = new HashMap<String, Object>();//参数
                                passparams.put("workflow", "B9C7D80EC0188933E053B11FA8C0A5D6");
                                passparams.put("datas", passdata);
                                logger.debug("--------------推送至绩效处----------------passparams" + passparams.toString());
                                tlpProgramBO.savereviewdatas(passparams);
                            }
                        } else {
                            map.put("bool", false);
                            map.put("mesg", "失败!");
                        }
                    }
                }
            }
        }catch (AppException e){
            logger.error("error", e);
            map.put("bool", false);
            map.put("mesg", "失败!");
        }
        return map;
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String leftmenuid = (String) params.get("menuid");
        String tablecode = "V_PERF_PROJECT_INFODPVIEW";
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        return tlpProgramAuditDAO.getLeftTree(tablecode, datarule);
    }
}
