package gov.mof.fasp2.pmkpi.deptracetask.page;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.deptracetask.bo.DeptraceTaskQueryBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptraceTaskQueryPage extends PmkpiPage {

    /**
     * 查询页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
    	DeptraceTaskQueryBO deptPerformanceQueryBO = (DeptraceTaskQueryBO) ServiceFactory.getBean("pmkpi.deptperformance.DeptPerformanceQueryBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptPerformanceQueryBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

}
