package gov.mof.fasp2.pmkpi.perfprotrace.audit;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProTraceAuditPage extends PmkpiPage {

	/**
	    * 审核页面
	    * @param request
	    * @param response
	    * @param config
	    * @return
	    * @throws Exception
	    */
	   public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		   ProTraceAuditBO proTraceAuditBO = (ProTraceAuditBO) ServiceFactory.getBean("pmkpi.perfprotrace.audit.ProTraceAuditBOTX");
	        String menuId = request.getParameter("menuId");
		    this.waitDoAction(request,response,config);
	        request.setAttribute("leftconfig", proTraceAuditBO.getLeftTabTree(config));
	        config.put("left", "lefttree");
	        this.getHeadTitle(config,menuId);
		   	config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
		   return config;
	   }
}
