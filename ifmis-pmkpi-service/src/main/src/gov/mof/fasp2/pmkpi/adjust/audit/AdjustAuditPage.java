package gov.mof.fasp2.pmkpi.adjust.audit;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class AdjustAuditPage extends PmkpiPage {
    /**
     * 调整列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        AdjustAuditBO adjustReportBO = (AdjustAuditBO) ServiceFactory.getBean("pmkpi.adjust.audit.AdjustAuditBOTX");
        request.setAttribute("leftconfig", adjustReportBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }

    /**
     * 调整列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map editpage(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
