package gov.mof.fasp2.pmkpi.evaluate.page;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.evaluate.bo.PreEvaluateBo;
import gov.mof.fasp2.pmkpi.evaluate.bo.ThirdEvaluateBo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class EvaluatePage extends PmkpiPage {

    /**
     * 第三方评估页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map toThirdEvaluate(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ThirdEvaluateBo thirdEvaluateBo = (ThirdEvaluateBo) ServiceFactory.getBean("pmkpi.evaluate.ThirdEvaluateBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", thirdEvaluateBo.getLeftTree(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 事前评估页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map toPreEvaluate(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PreEvaluateBo preEvaluateBo = (PreEvaluateBo) ServiceFactory.getBean("pmkpi.evaluate.PreEvaluateBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", preEvaluateBo.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 评估委托页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map toEvaluateEntrust(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        return config;
    }

     /**
     * 事前评估-评估页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map editIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 初始化页面.
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config.
     * @throws Exception -- 异常.
     * @throws
     */
    public Map<String, Object> toProgoal(HttpServletRequest request, HttpServletResponse response, Map<String, Object> config) throws Exception {
        return config;
    }

    /**
     * 评估意见
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config.
     * @throws Exception -- 异常.
     * @throws
     */
    public Map<String, Object> toOpinion(HttpServletRequest request, HttpServletResponse response, Map<String, Object> config) throws Exception {
        String workflow = request.getParameter("workflow");
        config.put("workflow", workflow);
        return config;
    }
}
