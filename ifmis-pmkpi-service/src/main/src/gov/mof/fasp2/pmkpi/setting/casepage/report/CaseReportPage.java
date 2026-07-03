package gov.mof.fasp2.pmkpi.setting.casepage.report;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class CaseReportPage extends PmkpiPage {
    /**
     * 申报列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        CaseReportBO caseReportBO = (CaseReportBO) ServiceFactory.getBean("pmkpi.casepage.report.CaseReportBOTX");
        request.setAttribute("leftconfig", caseReportBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }

    /**
     * 选择案例
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map checkcase(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }
}
