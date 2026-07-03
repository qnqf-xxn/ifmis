package gov.mof.fasp2.pmkpi.setting.evaluation.query;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class EvaluationQueryPage extends PmkpiPage {

    /**
     * 列表
     * @param request`
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        EvaluationQueryBO evaluationQueryBO = (EvaluationQueryBO) ServiceFactory.getBean("pmkpi.setting.evaluation.query.EvaluationQueryBOTX");
        request.setAttribute("leftconfig", evaluationQueryBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
}
