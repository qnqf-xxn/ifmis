package gov.mof.fasp2.pmkpi.setting.auditdefine.auditviewinfo;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class AuditViewInfoPage  extends PmkpiPage {
	 /**
     * 视图审核
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
	public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        return config;
    }
	
	
	public Map edit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
	
	
}
