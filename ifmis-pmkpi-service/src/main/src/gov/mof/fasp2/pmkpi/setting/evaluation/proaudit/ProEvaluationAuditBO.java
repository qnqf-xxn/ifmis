package gov.mof.fasp2.pmkpi.setting.evaluation.proaudit;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.publicapi.bussender.dto.ApiResultDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProEvaluationAuditBO extends PmkpiBO {
    private ProEvaluationAuditDAO proEvaluationAuditDAO;

    public void setProEvaluationAuditDAO(ProEvaluationAuditDAO proEvaluationAuditDAO){
        this.proEvaluationAuditDAO = proEvaluationAuditDAO;
    }

    /**
     * 查询项目信息
     * @param params --项目guid
     * @return
     */
    public Map<String, Object> getEditInfo(HashMap<String, Object> params) {
        String proguid = (String) params.get("proguid");
        String tablecode = (String) params.get("tablecode");
        String province = SecureUtil.getUserSelectProvince();
        String wheresql = " t.PRO_ID = '"+proguid +"' and province ='"+province+"'";
        List<Map<String, Object>> list = proEvaluationAuditDAO.getDatas("v_perf_t_evaluationaudit", wheresql, null);
        if (list == null || list.size() == 0) {
            return null;
        }
        return list.get(0);
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map save(HashMap config) throws AppException {
        String busguid = (String) config.get("busguid");
        String proguid = (String) config.get("proguid");
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        //当前登录用户
        UserDTO user = SecureUtil.getCurrentUser();
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        infodata.put("guid",CommonUtil.createGUID());
        infodata.put("proguid",proguid);
        infodata.put("agency_code",infodata.get("agencyguid"));
        infodata.put("agencyguid",infodata.get("agencyguid"));
        infodata.put("createtime", PerfUtil.getServerTimeStamp());
        infodata.put("updatetime", PerfUtil.getServerTimeStamp());
        infodata.put("creater", user.getGuid());
        infodata.put("province", SecureUtil.getUserSelectProvince());
        infodata.put("year", CommonUtil.getYear());
        proEvaluationAuditDAO.delDatas(proEvaluationAuditDAO.TABLE_EVALUATION," t.proguid = '"+proguid+"'");
        proEvaluationAuditDAO.save(infodata,proEvaluationAuditDAO.TABLE_EVALUATION);
        //调用项目库更新接口
        ApiResultDTO resultDTO = pdmUpdateData(infodata);
        String result_code = resultDTO.getResult_code(); //:0000(成功)/0001(失败)
        if("0001".equals(result_code)){
            throw new AppException("更新项目数据失败!-->"+resultDTO.getReason());
        }
        return this.auditdefine(l, busguid,"perf", null);
    }

    /**
     * 调用项目库更新数据接口
    */
    public ApiResultDTO pdmUpdateData(Map<String, Object> params){
        PdmInterface pdmInterface = gov.mof.fasp2.buscore.framework.util.ServiceFactory.getFeignClient(PdmInterface.class);
        String ispdm = (String) params.get("ispdm");  //事前绩效评估结论（是否纳入项目库）
        String proguid = (String) params.get("proguid"); //项目编码
        String tablecode ="pm_project_info";//表名
        String province = SecureUtil.getUserSelectProvince(); //财政区划
        String wheresql = " pro_id = '"+proguid+"'";
        HashMap<String,Object> upmap = new HashMap<>();
        upmap.put("v_col8",ispdm);
        upmap.put("upfilter",wheresql); //需额外传key为 upfilter的,value值则是过滤条件(既where后条件)  注：upfilter的key必须存在，否则报错
        logger.debug("-----------调用项目库更新接口------------");
        logger.debug("--------更新字段："+upmap);
        logger.debug("--------表名："+tablecode+"------------区划："+province);
        ApiResultDTO resultDTO = pdmInterface.pdmUpdateData(upmap, tablecode, province);
        logger.debug("返回信息："+resultDTO);
        return resultDTO;
    }
}
