package gov.mof.fasp2.pmkpi.probleamtask;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProblemTaskPage extends PmkpiPage {

    /**
     * 整改问题下达
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map issue(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config, menuId);
        return config;
    }

    /**
     * 整改情况反馈
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map feedback(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        this.waitDoAction(request,response,config);
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config, menuId);
        return config;
    }

    /**
     * 整改情况审核
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map audit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        this.waitDoAction(request,response,config);
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config, menuId);
        return config;
    }

    /**
     * 延期申请审核
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map delayaudit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config, menuId);
        return config;
    }

    /**
     * 整改问题反馈详情
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map query(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config, menuId);
        return config;
    }
}
