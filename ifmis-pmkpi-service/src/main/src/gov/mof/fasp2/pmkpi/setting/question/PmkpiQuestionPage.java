package gov.mof.fasp2.pmkpi.setting.question;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PmkpiQuestionPage extends PmkpiPage {
	
	public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		PmkpiQuestionBO pmkpiQuestionBO = (PmkpiQuestionBO) ServiceFactory.getBean("pmkpi.setting.question.PmkpiQuestionBOTX");
        request.setAttribute("leftconfig", pmkpiQuestionBO.getLeftTree());
        config.put("left", "lefttree");
		String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        return config;
    }

}
