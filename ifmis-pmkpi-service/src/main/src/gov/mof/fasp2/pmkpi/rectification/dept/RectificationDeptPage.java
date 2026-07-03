package gov.mof.fasp2.pmkpi.rectification.dept;

import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class RectificationDeptPage extends PmkpiPage {
    /**
     * 整改通知首页
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        RectificationDeptBO rectificationDeptBO = (RectificationDeptBO) ServiceFactory.getBean("pmkpi.rectification.dept.RectificationDeptBOTX");
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", rectificationDeptBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        config.put("menuid", menuId);
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }
}


