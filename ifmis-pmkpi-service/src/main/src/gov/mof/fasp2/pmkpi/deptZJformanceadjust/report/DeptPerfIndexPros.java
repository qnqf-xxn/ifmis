package gov.mof.fasp2.pmkpi.deptZJformanceadjust.report;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

public class DeptPerfIndexPros extends PmkpiService {
    /**
     * 注入bo.
     */
    private DeptPerfBO deptPerfBO;
    /**
     * bo.
     * @param deptPerfBO -- bo.
     * @throws
     */
    public void setDeptPerfBO(DeptPerfBO deptPerfBO) {
        this.deptPerfBO = deptPerfBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String saveAgency = request.getParameter("saveAgency"); //单位处室
        String mainguid = request.getParameter("mainguid"); //主键
        String indexguid = request.getParameter("indexguid"); //指标主键
        config.put("saveAgency",saveAgency);
        config.put("mainguid",mainguid);
        config.put("indexguid",indexguid);
        List projects = deptPerfBO.findWaitPros(saveAgency);
        config.put("projects", PerfUtil.lowMapKey(projects));
        return config;
    }

}
