package gov.mof.fasp2.pmkpi.evaluation.financial.prjindex;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class EvaPrjIndexPage extends PmkpiPage {

    /**
     * 层次分类
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map toIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String mainguid  = request.getParameter("mainguid");
        config.put("mainguid",mainguid);
        return config;
    }
}
