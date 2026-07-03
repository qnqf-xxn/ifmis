package gov.mof.fasp2.pmkpi.perfprogrammiddle.midaudit;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class MidProgramAuditPage extends PmkpiPage {

	/**
	    * 审核页面
	    * @param request
	    * @param response
	    * @param config
	    * @return
	    * @throws Exception
	    */
	   public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		    MidProgramAuditBO tlpProgramAuditBO = (MidProgramAuditBO) ServiceFactory.getBean("pmkpi.midperfprogram.MidProgramAuditBOTX");
	        String menuId = request.getParameter("menuId");
	        String prolev = request.getParameter("prolev"); //项目一二三级项目
	        request.setAttribute("leftconfig", tlpProgramAuditBO.getTreeData(menuId, prolev));
	        config.put("left", "lefttree");
	        this.getHeadTitle(config,menuId);
		    config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
	        return config;
	   }
}
