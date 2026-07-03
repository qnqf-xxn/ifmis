package gov.mof.fasp2.pmkpi.rectification.bo;

import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.ca.user.util.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.datacommon.workflow.service.IWorkflowService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationAddProjDAO;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RectificationAddProjBO extends PmkpiBO {

    IWorkflowService workflowService = (IWorkflowService) ServiceFactory.getBean("datacommon.wf.WorkflowService");

    private RectificationAddProjDAO rectificationAddProjDAO;

    public void setRectificationAddProjDAO(RectificationAddProjDAO rectificationAddProjDAO) {
        this.rectificationAddProjDAO = rectificationAddProjDAO;
    }

    public Map save(HashMap config) throws AppException, ParseException {
        String projguid = (String) config.get("projguid");
        String projcode = (String) config.get("projcode");
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
            projinfo = getProjInfo(projcode);
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
//            Sqlparam.put("rectifytitle", rectifytitle);
//            Sqlparam.put("rectifycontent", taskcontent);
//            Sqlparam.put("orgid", orgid);
            Sqlparam.put("projname", ("RANDOMCOMMENT").equals(type)? projinfo.get("proname"):projMap.get("projname"));
            if (("RANDOMCOMMENT").equals(type)){
                Sqlparam.put("projcode", projinfo.get("procode"));
            }
            Sqlparam.put("agencyguid", ("RANDOMCOMMENT").equals(type)? projinfo.get("agencyguid"):projMap.get("agencyguid"));
            Sqlparam.put("finintorgguid", ("RANDOMCOMMENT").equals(type)? projinfo.get("finintorgguid"):projMap.get("finintorgguid"));
            Sqlparam.put("bustype", bustype);
            Sqlparam.put("type", type);
            Sqlparam.put("status", "1");
            //isfinal=1(已终审) isfinal = 2(未终审)
            Sqlparam.put("isfinal", "2");
            //保存数据
            rectificationAddProjDAO.save(Sqlparam, RectificationAddProjDAO.PERF_T_RECTIFY);
            guidList.add(guidNew);
            l.add(Sqlparam);
//            this.workflow("create","D1BCFBC977C77FA061E449DADBE6F773", "", "PERF_T_RECTIFY", l);
            workflowService.createProcess(workflow, guidList);
        }
        config.put("success", true);
        return config;
    }

    /**
     * @param
     * @remark 根据项目id获取项目信息
     * @return
     */
    public Map getProjInfo(String projcode) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from v_PERF_PROJECT_INFO where pro_code = '").append(projcode).append("'");
        List list = rectificationAddProjDAO.queryForList(sql.toString());
        Map map = new HashMap();
        if (list.size() > 0) {
            map = (Map) list.get(0);
        }
        return mapToLowerCase(map);
    }

    /**
     * @param
     * @remark 根据项目id获取项目信息
     * @return
     */
    public Map getFinevaluation(String projguid) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from PERF_T_FINEVALUATION where guid = '").append(projguid).append("'");
        List list = rectificationAddProjDAO.queryForList(sql.toString());
        Map map = new HashMap();
        if (list.size() > 0) {
            map = (Map) list.get(0);
        }
        return mapToLowerCase(map);
    }

    public Map mapToLowerCase(Map<String, String> map){
        Map result = new HashMap();
        for(Map.Entry<String, String> entry : map.entrySet()){
            String mapKey = entry.getKey().toLowerCase();
            result.put(mapKey, entry.getValue());
        }
        return result;
    }

    public String getVodSql(Map sqlmap) throws AppException {
        UserDTO user = SecureUtil.getCurrentUser();
        String bustype = (String) sqlmap.get("bustype");
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String type = (String) sqlmap.get("type");
        String querySql = (String) sqlmap.get("querySql");
        String defquery = (String) sqlmap.get("defquery");
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String isZJ = PerfUtil.getSystemSet("isZJ"); //判断是否是浙江环境
        logger.debug("--------------是否浙江环境选择项目"+isZJ);
        StringBuffer sb = new StringBuffer();
        if(isZJ != null && "1".equals(isZJ) && ("RANDOMCOMMENT".equals(type) || "FINEVALUATION".equals(type))){
            sb.append("select * from ");
            if (type != null && "RANDOMCOMMENT".equals(type)){ //抽评
                sb.append("perf_v_randomrectify_proj").append(" t  where");
                sb.append(" bustype = '").append(bustype).append("' ");
                sb.append(" and (ISFINAL != '2' or  ISFINAL is null)");
            }else if(type != null && "FINEVALUATION".equals(type)) {//财政重点评价
                sb.append("PERF_V_FINRECTIFY_PROJ").append(" t where ");
                sb.append("  (ISFINAL != '2' or  ISFINAL is null)");
                sb.append(" and t.EVALMEACH = '"+user.getDivision()+"'");
            }
            if(querySql != null && !querySql.isEmpty()){
                sb.append(" and (").append(querySql).append(")");
            }
            if(defquery != null && !defquery.isEmpty()){
                sb.append(" and ").append(defquery);
            }
            logger.debug("RectificationAddProjBO.getVodSql.querySql="+sb.toString());
        }else{
            String datarule = this.getDataRuleByMenuguid(leftmenuid, "t", null); //数据权限
            sb.append("select * from ").append(tablecode).append(" t where 1=1 ");
            sb.append(datarule);
            sb.append(" and wfstatus = '011' and not exists(select 1 from ").append(RectificationAddProjDAO.PERF_T_RECTIFY).append(" a where  ");
            if (PerfUtil.getIsHbei() || "dept".equals(lefttabtype)) {
                sb.append(" a.proguid=t.guid ");
            } else {
                sb.append(" a.pro_code=t.pro_code ");
            }
            sb.append(" and a.wfstatus<>'011')");
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
