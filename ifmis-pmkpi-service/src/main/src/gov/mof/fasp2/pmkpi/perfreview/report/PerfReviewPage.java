package gov.mof.fasp2.pmkpi.perfreview.report;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfReviewPage extends PmkpiPage {

    /**
     * 初始化页面.
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config.
     * @throws Exception -- 异常.
     * @throws
     */
    public Map<String, Object> index(HttpServletRequest request, HttpServletResponse response, Map<String, Object> config) throws Exception {
        PerfReviewBO perfReviewBO  = (PerfReviewBO) PerfServiceFactory.getBean("pmkpi.perfreview.PerfReviewBOTX");
        String menuId = request.getParameter("menuId");
        String lefttypes = request.getParameter("lefttypes");
        request.setAttribute("leftconfig", perfReviewBO.getTreeData(menuId,lefttypes));
        config.put("left", "lefttree");
        config.put("depthidemenuid", "deptreviewreporthide");
        config.put("programhidemenuid", "programreviewreporthide");
        this.getHeadTitle(config,menuId);
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
    public Map<String, Object> entrust(HttpServletRequest request, HttpServletResponse response, Map<String, Object> config) throws Exception {
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
    public Map<String, Object> entrustindex(HttpServletRequest request, HttpServletResponse response, Map<String, Object> config) throws Exception {
        PerfReviewBO perfReviewBO  = (PerfReviewBO) PerfServiceFactory.getBean("pmkpi.perfreview.PerfReviewBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", perfReviewBO.getTreeData(menuId,null));
        config.put("left", "lefttree");
        config.put("depthidemenuid", "deptreviewaudithide");
        config.put("programhidemenuid", "programreviewaudithide");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 批量送审
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config.
     * @throws Exception -- 异常.
     * @throws
     */
    public Map<String, Object> batchadd(HttpServletRequest request, HttpServletResponse response, Map<String, Object> config) throws Exception {
        return config;
    }

}
