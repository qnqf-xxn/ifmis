package gov.mof.fasp2.pmkpi.perfprogrammiddle.midaudit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class MidProgramAuditService extends PmkpiService {

	private MidProgramAuditBO midProgramAuditBO;

	public void setMidProgramAuditBO(MidProgramAuditBO midProgramAuditBO) {
		this.midProgramAuditBO = midProgramAuditBO;
	}
	
	public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        config.put("workflow",workflow);
        String viewtype = request.getParameter("viewtype");
        config.put("viewtype",viewtype);
        return config;
    }
    
    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        try {
            backmap = midProgramAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code",e.getCode());
        } catch (AppException e) {
            backmap.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

    /**
     * 纳入案例库
     * @param params --
     * @return --
     */
    public Map<String, Object> intoCase(HashMap<String,Object> params) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        try {
            backmap = midProgramAuditBO.intoCase(params);
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code",e.getCode());
        } catch (AppException e) {
            backmap.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

}
