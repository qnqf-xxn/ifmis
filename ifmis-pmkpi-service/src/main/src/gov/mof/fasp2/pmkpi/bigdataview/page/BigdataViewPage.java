package gov.mof.fasp2.pmkpi.bigdataview.page;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfprotrace.query.ProTraceQueryBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class BigdataViewPage extends PmkpiPage {

    
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        String type = request.getParameter("type");
        config.put("type", type);
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 监控自评对比列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map dbindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ProTraceQueryBO proTraceQueryBO = (ProTraceQueryBO) ServiceFactory.getBean("pmkpi.perfprotrace.query.ProTraceQueryBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", proTraceQueryBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }
    
}
