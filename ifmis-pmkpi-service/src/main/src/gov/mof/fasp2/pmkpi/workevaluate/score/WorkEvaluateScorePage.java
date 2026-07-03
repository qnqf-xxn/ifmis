package gov.mof.fasp2.pmkpi.workevaluate.score;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class WorkEvaluateScorePage extends PmkpiPage {
    /**
     *评分表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map score(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
