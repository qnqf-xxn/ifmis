package gov.mof.fasp2.pmkpi.evaluation.dept.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptAuditEditService extends PmkpiService {
    private DeptAuditBO deptAuditBO;

    public void setDeptAuditBO(DeptAuditBO deptAuditBO) {
        this.deptAuditBO = deptAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String workflow = request.getParameter("workflow");
        String saveAgency = request.getParameter("saveAgency");
        String audittype = request.getParameter("audittype"); //审核类型
        String viewtype = request.getParameter("viewtype"); //审核类型
        String leftmenuid = request.getParameter("leftmenuid");
        String actioncode = request.getParameter("actioncode");
        List<Map<String, Object>> audittypedatas = null;
        if (audittype != null && "result".equals(audittype)) { //财政评价上传结果审核
            audittypedatas = deptAuditBO.getAudittypeDatas("");
            config.put("data", deptAuditBO.getDataById(mainguid, audittype));
        } else if (audittype != null && "deptaudit".equals(audittype)) { //财政评价项目审核
            audittypedatas = deptAuditBO.getAudittypeDatas(" and t.code<>'3' ");
            config.put("data", deptAuditBO.getDataById(mainguid, audittype));
        } else if (audittype != null && "feedback".equals(audittype)) { //部门反馈意见
            config.put("data", deptAuditBO.getDataMap(DeptAuditDAO.PERF_TABLE_DEPTEVAL, " guid='"+mainguid+"' "));
        }
        config.put("audittype",audittype);
        config.put("audittypedatas", audittypedatas);
        config.put("workflow", workflow);
        config.put("mainguid", mainguid);
        config.put("saveAgency", saveAgency);
        config.put("viewtype", viewtype);
        config.put("leftmenuid", leftmenuid);
        config.put("actioncode", actioncode);
        return config;
    }

    /**
     * 保存
     * @param params
     * @return
     */
    public Map<String,Object> save (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptAuditBO.saveDatas(params);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs.put("success", false);
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("success", false);
            rs.put("code",e.getMessage());
            logger.error(e.getCode(), e);
        }
        return rs;

    }
}
