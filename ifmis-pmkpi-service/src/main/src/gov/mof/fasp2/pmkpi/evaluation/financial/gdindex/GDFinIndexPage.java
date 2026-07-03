package gov.mof.fasp2.pmkpi.evaluation.financial.gdindex;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class GDFinIndexPage extends PmkpiPage {

    /**
     * 债券重点评价指标
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
