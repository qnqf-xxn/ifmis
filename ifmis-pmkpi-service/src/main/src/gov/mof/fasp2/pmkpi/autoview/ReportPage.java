package gov.mof.fasp2.pmkpi.autoview;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ReportPage extends PmkpiPage {

	/**
	    * 查询页面
	    * @param request
	    * @param response
	    * @param config
	    * @return
	    * @throws Exception
	    */
	   public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		   ReportBO reportBO = (ReportBO) ServiceFactory.getBean("pmkpi.autoview.ReportBOTX");
		   String menuId = request.getParameter("menuId");
		   String viewtable = request.getParameter("viewtable");
		   String querykey = request.getParameter("querykey");
		   config.put("querykey",querykey);
		   if(!StringUtil.isEmpty(querykey)){
			   config.put("pageurl",querykey);
			   config.put("key",querykey);
		   }
		   request.setAttribute("leftconfig", reportBO.getTreeData(menuId,viewtable));
		   config.put("left", "lefttree");
		   config.put("viewtable",viewtable);
		   this.getHeadTitle(config,menuId);
		   return config;
	   }
}
