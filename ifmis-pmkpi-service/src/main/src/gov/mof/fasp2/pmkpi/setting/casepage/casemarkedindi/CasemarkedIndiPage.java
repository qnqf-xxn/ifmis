package gov.mof.fasp2.pmkpi.setting.casepage.casemarkedindi;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class CasemarkedIndiPage extends PmkpiPage {
    /**
     * 查询列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map list(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        CasemarkedIndiBO casemarkedIndiBO = (CasemarkedIndiBO) ServiceFactory.getBean("pmkpi.casemarkedindi.CasemarkedIndiBOTX");
        request.setAttribute("leftconfig", casemarkedIndiBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }

    /**
     * 查询列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map prolist(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }
}
