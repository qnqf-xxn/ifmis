package gov.mof.fasp2.pmkpi.perfprotrace.query;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProTraceQueryPage extends PmkpiPage {

	/**
	    * 查询页面
	    * @param request
	    * @param response
	    * @param config
	    * @return
	    * @throws Exception
	    */
	   public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		   ProTraceQueryBO proTraceQueryBO = (ProTraceQueryBO) ServiceFactory.getBean("pmkpi.perfprotrace.query.ProTraceQueryBOTX");
	        String menuId = request.getParameter("menuId");
	        request.setAttribute("leftconfig", proTraceQueryBO.getLeftTabTree(config));
	        config.put("left", "lefttree");
	        this.getHeadTitle(config,menuId);
		    config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
	        return config;
	   }

	/**
	 * 查看监控历史记录
	 * @param request
	 * @param response
	 * @param config
	 * @return
	 * @throws Exception
	 */
	public Map histrace(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		String menuId = request.getParameter("menuId");
		this.getHeadTitle(config,menuId);
		config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
		String querytype = request.getParameter("querytype");
		config.put("querytype", querytype);
		return config;
	}
}
