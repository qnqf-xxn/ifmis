package gov.mof.fasp2.pmkpi.perfselfreview.manage;

import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfSelfReviewManagePage extends PmkpiPage {

    /**
     * 下达页面
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PmkpiBO pmkpiBO = PerfServiceFactory.getPmkpiBO();
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", pmkpiBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;
    }

}
