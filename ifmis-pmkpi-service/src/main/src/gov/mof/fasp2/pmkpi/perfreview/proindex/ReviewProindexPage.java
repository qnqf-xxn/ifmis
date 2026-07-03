package gov.mof.fasp2.pmkpi.perfreview.proindex;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ReviewProindexPage extends PmkpiPage {
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
        config.put("isquery",request.getParameter("isquery"));
        return config;
    }
}
