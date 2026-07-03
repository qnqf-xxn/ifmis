package gov.mof.fasp2.pmkpi.perfprogram.assessment;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfAssessmentPage extends PmkpiPage {
    /**
     * 绩效事前评估
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        return config;
    }
}
