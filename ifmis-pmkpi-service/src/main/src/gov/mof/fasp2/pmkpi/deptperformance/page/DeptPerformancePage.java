package gov.mof.fasp2.pmkpi.deptperformance.page;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.deptperformance.bo.DeptPerformanceBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptPerformancePage extends PmkpiPage {

    /**
     * 申报页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        DeptPerformanceBO deptPerformanceBO = (DeptPerformanceBO) ServiceFactory.getBean("pmkpi.deptperformance.DeptPerformanceBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptPerformanceBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 申报页面编辑
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map editindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 指标新增页.
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map addindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    
    /**
     * 选择指标
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map indexcheck(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
