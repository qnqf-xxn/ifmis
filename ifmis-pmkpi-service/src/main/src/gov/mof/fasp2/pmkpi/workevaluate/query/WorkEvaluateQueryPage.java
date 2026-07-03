package gov.mof.fasp2.pmkpi.workevaluate.query;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class WorkEvaluateQueryPage extends PmkpiPage {
    /**
     * 重点评价列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map list(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        WorkEvaluateQueryBO workEvaluateQueryBO = (WorkEvaluateQueryBO) ServiceFactory.getBean("pmkpi.workevaluate.query.WorkEvaluateQueryBOTX");
        request.setAttribute("leftconfig", workEvaluateQueryBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
}
