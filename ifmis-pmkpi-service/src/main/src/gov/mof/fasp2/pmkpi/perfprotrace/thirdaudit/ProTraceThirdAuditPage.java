package gov.mof.fasp2.pmkpi.perfprotrace.thirdaudit;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProTraceThirdAuditPage extends PmkpiPage {
    /**
     * 成果上传、成果审核页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ProTraceThirdAuditBO proTraceThirdAuditBO = (ProTraceThirdAuditBO) ServiceFactory.getBean("pmkpi.perfprotrace.thirdaudit.ProTraceThirdAuditBOTX");
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", proTraceThirdAuditBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map auditresults(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ProTraceThirdAuditBO proTraceThirdAuditBO = (ProTraceThirdAuditBO) ServiceFactory.getBean("pmkpi.perfprotrace.thirdaudit.ProTraceThirdAuditBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", proTraceThirdAuditBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }

    public Map jxyindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
