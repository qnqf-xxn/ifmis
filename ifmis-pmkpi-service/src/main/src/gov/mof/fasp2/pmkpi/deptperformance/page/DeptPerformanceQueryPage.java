package gov.mof.fasp2.pmkpi.deptperformance.page;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.deptperformance.bo.DeptPerformanceQueryBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptPerformanceQueryPage extends PmkpiPage {

    /**
     * 查询页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
    	DeptPerformanceQueryBO deptPerformanceQueryBO = (DeptPerformanceQueryBO) ServiceFactory.getBean("pmkpi.deptperformance.DeptPerformanceQueryBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptPerformanceQueryBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

}
