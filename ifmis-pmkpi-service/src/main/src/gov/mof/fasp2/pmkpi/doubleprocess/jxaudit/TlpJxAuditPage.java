package gov.mof.fasp2.pmkpi.doubleprocess.jxaudit;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class TlpJxAuditPage extends PmkpiPage {

	/**
	    * 审核页面
	    * @param request
	    * @param response
	    * @param config
	    * @return
	    * @throws Exception
	    */
	   public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		   TlpJxAuditBO tlpProgramAuditBO = (TlpJxAuditBO) ServiceFactory.getBean("pmkpi.doubleprocess.TlpJxAuditBOTX");
	        String menuId = request.getParameter("menuId");
	        String prolev = request.getParameter("prolev"); //项目一二三级项目
	        request.setAttribute("leftconfig", tlpProgramAuditBO.getTreeData(menuId, prolev));
	        config.put("left", "lefttree");
	        this.getHeadTitle(config,menuId);
	        return config;
	   }
}
