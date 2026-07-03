package gov.mof.fasp2.pmkpi.deptperfevalTJ;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptPerfEvalTJPage extends PmkpiPage {

    /**
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map reportindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        DeptPerfEvalTJBO deptPerfEvalTJBO = (DeptPerfEvalTJBO) ServiceFactory.getBean("pmkpi.deptperfevalTJ.DeptPerfEvalTJBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptPerfEvalTJBO.getTreeData(menuId));
        this.waitDoAction(request,response,config);
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;
    }

    /**
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map auditindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        DeptPerfEvalTJBO deptPerfEvalTJBO = (DeptPerfEvalTJBO) ServiceFactory.getBean("pmkpi.deptperfevalTJ.DeptPerfEvalTJBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptPerfEvalTJBO.getTreeData(menuId));
        this.waitDoAction(request,response,config);
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;
    }

    /**
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map queryindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        DeptPerfEvalTJBO deptPerfEvalTJBO = (DeptPerfEvalTJBO) ServiceFactory.getBean("pmkpi.deptperfevalTJ.DeptPerfEvalTJBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptPerfEvalTJBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;
    }

}
