package gov.mof.fasp2.pmkpi.deptZJformanceadjust.query;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptPerfQueryPage extends PmkpiPage {

    /**
     * 调整查询页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
    	DeptPerfQueryBO deptPerfQueryBO = (DeptPerfQueryBO) ServiceFactory.getBean("pmkpi.deptZJformance.DeptPerfQueryBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptPerfQueryBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

}
