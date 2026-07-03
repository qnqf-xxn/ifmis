package gov.mof.fasp2.pmkpi.deptracetask.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.deptracetask.bo.DeptraceTaskAuditBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptraceTaskAuditService extends PmkpiService {
    private DeptraceTaskAuditBO deptraceTaskAuditBO;

    public void setDeptraceTaskAuditBO(DeptraceTaskAuditBO deptraceTaskAuditBO) {
        this.deptraceTaskAuditBO = deptraceTaskAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        //String pagetype = request.getParameter("pagetype");
        String workflow = request.getParameter("workflow");
        String audittype = "normal";
        config.put("audittype",audittype);
        config.put("workflow",workflow);
        return config;
    }
    
    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
	public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptraceTaskAuditBO.getData(parms);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        try {
            deptraceTaskAuditBO.wfAudit(params);
            backmap.put("flg", "1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

}
