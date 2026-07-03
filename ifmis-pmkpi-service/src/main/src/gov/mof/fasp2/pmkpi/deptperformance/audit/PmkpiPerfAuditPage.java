
package gov.mof.fasp2.pmkpi.deptperformance.audit;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PmkpiPerfAuditPage extends PmkpiPage {

    /**
     * 审核首页.
     * @param request - HttpServletRequest
     * @param response - HttpServletResponse
     * @param config - 参数
     * @return - 返回参数
     * @throws Exception - 异常处理
     * @throws
     */
    public Map<String, Object> index(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> config) throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }

    /**
     * 审核详情页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map<String, Object> edit(HttpServletRequest request, HttpServletResponse response, Map<String, Object> config)
            throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }

}
