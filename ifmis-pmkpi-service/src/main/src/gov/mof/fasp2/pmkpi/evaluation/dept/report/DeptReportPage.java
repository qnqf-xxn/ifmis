package gov.mof.fasp2.pmkpi.evaluation.dept.report;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptReportPage extends PmkpiPage {

    /**
     * 部门评价列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map list(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        DeptReportBO deptReportBO = (DeptReportBO) ServiceFactory.getBean("pmkpi.evaluation.dept.report.DeptReportBOTX");
        request.setAttribute("leftconfig", deptReportBO.getLeftTabTree(config));
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
