package gov.mof.fasp2.pmkpi.evaluate.audit;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class
EvaluateAuditBO extends PmkpiBO {

    private EvaluateAuditDAO evaluateAuditDAO;

    @Resource(name="pmkpi.evaluate.EvaluateAuditDAO")
    public void setEvaluateAuditDAO(EvaluateAuditDAO evaluateAuditDAO) {
        this.evaluateAuditDAO = evaluateAuditDAO;
    }

    /**
     * 保存
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String,Object> saveDatas (HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("saveAgency");
        String workflow = "80E9F449FD83DFE96FBD178C7E848DFE";
        Map<String, Object> editinfo = (Map<String, Object>) params.get("editinfo");
        String audittype = (String) editinfo.get("audittype");
        //当前登录用户
        UserDTO user = SecureUtil.getCurrentUser();
        editinfo.put("guid", this.getCreateguid());
        editinfo.put("createtime", PerfUtil.getServerTimeStamp());
        editinfo.put("updatetime", PerfUtil.getServerTimeStamp());
        editinfo.put("creater", user.getGuid());
        editinfo.put("province", user.getProvince());
        editinfo.put("year", CommonUtil.getYear());
        editinfo.put("status", "1");
        editinfo.put("proguid", mainguid);
        editinfo.put("agencyguid", saveAgency);
        editinfo.put("islast", 1);
        editinfo.put("type","assessment");
        editinfo.put("bustype","assessment");
        editinfo.put("oldopinion",null);  //历史意见不保存
        if (audittype != null && "BA65A5E8BB565704E053B11FA8C096F3".equals(audittype)) {
            editinfo.put("audittype", "BC4E595CCE4511C7E053B11FA8C0AD52");
        }
        String wheresql = " t.proguid = '"+mainguid+"'";
        List<Map<String,Object>> datas =  new ArrayList();
        evaluateAuditDAO.delDatas("V_PERF_T_EVALUATEAUDIT",wheresql);
        evaluateAuditDAO.save(editinfo, "V_PERF_T_EVALUATEAUDIT");
        if(audittype != null && ("BA65A5E8BB565704E053B11FA8C096F3".equals(audittype) || "BCB5B04419F20765E053480A050ABEE5".equals(audittype))) {//第三方评审/退回走工作流
            wheresql = " t.proguid = '"+mainguid+"' and t.type = 'assessment'";
            List<Map<String, Object>> list = evaluateAuditDAO.getDatas("v_perf_t_review",wheresql,null);
            if(list.size() > 0){
                throw new PerfAppException("项目已推送给第三方审核!!");
            } else {
                datas.add(editinfo);
                String remark = (String) editinfo.get("opinion");
                this.workflow("create",workflow, remark, "v_perf_t_review", datas);
                backMap.put("success", true);
            }
        }
        /*wheresql = " t.proguid = '"+mainguid+"' and t.type = 'assessment'";
        evaluateAuditDAO.delDatas("v_perf_t_review",wheresql);*/
        return backMap;
    }

    /**
     * 获取文件
     * @param proguid
     * @return
     */
    public List<Map<String, Object>> getFile (String proguid){
        List<Map<String, Object>> datas = evaluateAuditDAO.getFile(proguid);
        return datas;
    }

    /**
     * 获取数据
     * @param mainguid --
     * @return
     */
    public Map<String, Object> getDataById(String mainguid) {
        String sql = " proguid='" + mainguid + "' and bustype='assessment'";
        List<Map<String, Object>> list = evaluateAuditDAO.getDatas("v_perf_t_evaluateaudit", sql, "");
        if (list!= null && list.size()>0){
            return list.get(0);
        }
        return new HashMap<>();
    }

    /**
     * 获取审核类型数据源
     * @return
     */
    public List<Map<String, Object>> getAudittypeDatas(){
        return evaluateAuditDAO.getAudittypeDatas();
    }
}
