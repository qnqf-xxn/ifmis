package gov.mof.fasp2.pmkpi.perfself.page;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfself.bo.PerfSelfAuditBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfSelfAuditPage extends PmkpiPage {

    /**
     * 审核首页.
     * @param request - HttpServletRequest
     * @param response - HttpServletResponse
     * @param config - 参数
     * @return - 返回参数
     * @throws Exception - 异常处理
     * @throws
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PerfSelfAuditBO perfSelfAuditBO = (PerfSelfAuditBO) PerfServiceFactory.getBean("pmkpi.perfSelf.PerfSelfAuditBOTX");
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", perfSelfAuditBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
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
