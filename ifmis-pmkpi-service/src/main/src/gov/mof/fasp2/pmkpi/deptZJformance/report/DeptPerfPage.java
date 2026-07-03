package gov.mof.fasp2.pmkpi.deptZJformance.report;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptPerfPage extends PmkpiPage {

    /**
     * 申报页面
     * @param request -- 请求
     * @param response -- 响应  
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        DeptPerfBO deptPerfBO  = (DeptPerfBO) PerfServiceFactory.getBean("pmkpi.deptZJformance.DeptPerfBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptPerfBO.getTreeData(menuId));
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
     * @throws Exception -- 异常.
     */
    public Map editindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 指标对应的项目选择.
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map indexpros(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
