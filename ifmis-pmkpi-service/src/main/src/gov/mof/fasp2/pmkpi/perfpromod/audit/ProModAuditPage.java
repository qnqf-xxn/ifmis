package gov.mof.fasp2.pmkpi.perfpromod.audit;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

public class ProModAuditPage extends PmkpiPage{
	/**
	    * 查询页面
	    * @param request
	    * @param response
	    * @param config
	    * @return
	    * @throws Exception
	    */
	   public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		   ProModAuditBO proModAuditBO = (ProModAuditBO) ServiceFactory.getBean("pmkpi.perfpromod.ProModAuditBOTX");
	       String menuId = request.getParameter("menuId");
	       String prolev = request.getParameter("prolev"); //项目一二三级项目
		   String modtype = request.getParameter("modtype");
	       request.setAttribute("leftconfig", proModAuditBO.getTreeData(menuId, prolev, modtype));
	       config.put("left", "lefttree");
		   config.put("modtype", modtype);
	       this.getHeadTitle(config,menuId);
	       return config;
	   }
}
