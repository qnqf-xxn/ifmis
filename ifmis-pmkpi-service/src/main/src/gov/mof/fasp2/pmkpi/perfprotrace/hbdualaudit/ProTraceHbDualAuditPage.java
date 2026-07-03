package gov.mof.fasp2.pmkpi.perfprotrace.hbdualaudit;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProTraceHbDualAuditPage extends PmkpiPage {

	/**
	    * 审核页面
	    * @param request
	    * @param response
	    * @param config
	    * @return
	    * @throws Exception
	    */
	   public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		   ProTraceHbDualAuditBO proTraceAuditBO = (ProTraceHbDualAuditBO) ServiceFactory.getBean("pmkpi.perfprotrace.audit.ProTraceHbDualAuditBOTX");
	        String menuId = request.getParameter("menuId");
	        request.setAttribute("leftconfig", proTraceAuditBO.getTraceLeftTree(menuId));
	        config.put("left", "lefttree");
	        this.getHeadTitle(config,menuId);
	        return config;
	   }
}
