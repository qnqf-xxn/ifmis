package gov.mof.fasp2.pmkpi.deptperformance.service;

import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.deptperformance.bo.DeptPerformanceQueryBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptPerformanceQueryService extends PmkpiService {
    private DeptPerformanceQueryBO deptPerformanceQueryBO;

    public void setDeptPerformanceQueryBO(DeptPerformanceQueryBO deptPerformanceQueryBO) {
        this.deptPerformanceQueryBO = deptPerformanceQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String menutype = request.getParameter("menutype");
        config.put("menutype",menutype);
        return config;
    }

}
