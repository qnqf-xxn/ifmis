package gov.mof.fasp2.pmkpi.setting.evaluation.report;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class EvaluationReportPage extends PmkpiPage {
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
        EvaluationReportBO evaluationReportBO = (EvaluationReportBO) ServiceFactory.getBean("pmkpi.setting.evaluation.report.EvaluationReportBOTX");
        request.setAttribute("leftconfig", evaluationReportBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 选择项目列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map check(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
