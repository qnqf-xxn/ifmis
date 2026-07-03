package gov.mof.fasp2.pmkpi.performanceopen.nxreport;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class NXPerfOpenPage extends PmkpiPage {
    /**
     * 宁夏绩效公开填报
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        NXPerfOpenBO nxPerfOpenBO  = (NXPerfOpenBO) PerfServiceFactory.getBean("pmkpi.performanceopen.NXPerfOpenBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", nxPerfOpenBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        this.waitDoAction(request,response,config);
        return config;
    }
}
