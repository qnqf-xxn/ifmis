package gov.mof.fasp2.pmkpi.doubleprocess.query;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class TlpProgramQueryPage extends PmkpiPage {
	
	/**
    * 查询页面
    * @param request
    * @param response
    * @param config
    * @return
    * @throws Exception
    */
   public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
	   TlpProgramQueryBO tlpProgramQueryBO = (TlpProgramQueryBO) ServiceFactory.getBean("pmkpi.perfprogram.TlpProgramQueryBOTX");
       String menuId = request.getParameter("menuId");
       String prolev = request.getParameter("prolev"); //项目一二三级项目
       request.setAttribute("leftconfig", tlpProgramQueryBO.getTreeData(menuId, prolev));
       config.put("left", "lefttree");
       this.getHeadTitle(config,menuId);
       return config;
   }

}
