package gov.mof.fasp2.pmkpi.setting.perfcarryover;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfCarryOverPage extends PmkpiPage {

    /**
     * 整改问题下达
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        PerfCarryOverBO perfCarryOverBO = (PerfCarryOverBO) ServiceFactory.getBean("pmkpi.perfcarryover.PerfCarryOverBOTX");
        request.setAttribute("leftconfig", perfCarryOverBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
}
