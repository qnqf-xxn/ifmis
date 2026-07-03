package gov.mof.fasp2.pmkpi.adjust.remind;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class AdjustRemindPage  extends PmkpiPage {
    /**
     * 调整提醒列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        AdjustRemindBO adjustRemindBO = (AdjustRemindBO) ServiceFactory.getBean("pmkpi.adjust.remind.AdjustRemindBOTX");
        request.setAttribute("leftconfig", adjustRemindBO.getRemindLeftTree(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 调整提醒列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map add(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
