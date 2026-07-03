package gov.mof.fasp2.pmkpi.performanceopen.query;

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
public class PerfOpenQueryPage extends PmkpiPage {

    /**
     * 绩效公开填报
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PerfOpenQueryBO perfOpenQueryBO = (PerfOpenQueryBO) PerfServiceFactory.getBean("pmkpi.performanceopen.PerfOpenQueryBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", perfOpenQueryBO.getTraceLeftTree(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
}
