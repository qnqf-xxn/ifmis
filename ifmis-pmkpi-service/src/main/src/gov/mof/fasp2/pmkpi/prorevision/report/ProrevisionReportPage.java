package gov.mof.fasp2.pmkpi.prorevision.report;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/***
 * 河北贵州模式：项目支出 修改.
 */
public class ProrevisionReportPage extends PmkpiPage {
    /**
     * 调整列表
     * @param request`
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        ProrevisionReportBO revisionReportBO = (ProrevisionReportBO) ServiceFactory.getBean("pmkpi.prorevision.RevisionReportBOTX");
        request.setAttribute("leftconfig", revisionReportBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 选择项目列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map check(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
