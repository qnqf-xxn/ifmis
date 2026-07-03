package gov.mof.fasp2.pmkpi.perfself.tab;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class TjSelfIndexPage extends PmkpiPage {

    /**
     * 下达页面
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

}
