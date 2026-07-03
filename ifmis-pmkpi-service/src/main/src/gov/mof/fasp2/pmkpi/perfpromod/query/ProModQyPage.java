package gov.mof.fasp2.pmkpi.perfpromod.query;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

public class ProModQyPage extends PmkpiPage {

	/**
	    * 查询页面
	    * @param request
	    * @param response
	    * @param config
	    * @return
	    * @throws Exception
	    */
	   public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		   ProModQyBO proModQyBO = (ProModQyBO) ServiceFactory.getBean("pmkpi.perfpromod.ProModQyBOTX");
	       String menuId = request.getParameter("menuId");
	       String prolev = request.getParameter("prolev"); //项目一二三级项目
	       request.setAttribute("leftconfig", proModQyBO.getTreeData(menuId, prolev));
	       config.put("left", "lefttree");
	       this.getHeadTitle(config,menuId);
	       return config;
	   }
}
