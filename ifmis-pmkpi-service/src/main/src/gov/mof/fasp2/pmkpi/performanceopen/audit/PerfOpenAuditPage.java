package gov.mof.fasp2.pmkpi.performanceopen.audit;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @author zhangxutao
 * @version 1.0
 * @description: TODO
 * @date 2023/4/18 10:30
 */
public class PerfOpenAuditPage extends PmkpiPage {

    /**
     * 绩效公开填报
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PerfOpenAuditBO perfOpenAuditBO = (PerfOpenAuditBO) PerfServiceFactory.getBean("pmkpi.performanceopen.PerfOpenAuditBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", perfOpenAuditBO.getTraceLeftTree(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        this.waitDoAction(request,response,config);
        return config;
    }

    /**
     * 审核页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map audit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
