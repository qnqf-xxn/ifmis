package gov.mof.fasp2.pmkpi.perfreview.query;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ReviewQueryPage extends PmkpiPage {
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
        ReviewQueryBO reviewQueryBO  = (ReviewQueryBO) PerfServiceFactory.getBean("pmkpi.perfreview.ReviewQueryBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", reviewQueryBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
}
