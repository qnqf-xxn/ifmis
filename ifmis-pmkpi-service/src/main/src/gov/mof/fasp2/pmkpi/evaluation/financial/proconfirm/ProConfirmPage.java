package gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProConfirmPage extends PmkpiPage {
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
        this.waitDoAction(request,response,config);
        ProConfirmBO proConfirmBO = (ProConfirmBO) ServiceFactory.getBean("pmkpi.financial.proconfirm.ProConfirmBOTX");
        request.setAttribute("leftconfig", proConfirmBO.getLeftTabTree(config));
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
