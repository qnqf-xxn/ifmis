package gov.mof.fasp2.pmkpi.transpaypro;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class TranspayProIndexPage extends PmkpiPage {

    /**
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config, menuId);
        return config;
    }

    /**
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map proindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config, menuId);
        return config;
    }
}
