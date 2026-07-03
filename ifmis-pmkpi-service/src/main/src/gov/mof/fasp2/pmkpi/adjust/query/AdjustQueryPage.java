package gov.mof.fasp2.pmkpi.adjust.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class AdjustQueryPage extends PmkpiPage {
    /**
     * 调整列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws AppException
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        String menuId = request.getParameter("menuId");
        AdjustQueryBO adjustQueryBO = (AdjustQueryBO) ServiceFactory.getBean("pmkpi.adjust.query.AdjustQueryBOTX");
        request.setAttribute("leftconfig", adjustQueryBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
}
