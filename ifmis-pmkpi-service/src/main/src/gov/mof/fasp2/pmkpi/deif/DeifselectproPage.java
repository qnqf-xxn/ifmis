package gov.mof.fasp2.pmkpi.deif;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeifselectproPage extends PmkpiPage {
    /**
     * 列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }

}
