package gov.mof.fasp2.pmkpi.perfself.opinion;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class SelfOpinionPage extends PmkpiPage {

    /**
     * 页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map edit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        config.put("menutype","perfmenu");
        return config;
    }
}
