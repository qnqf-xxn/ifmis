package gov.mof.fasp2.pmkpi.deptZJformanceadjust.audit;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptPerfAuditPage extends PmkpiPage {

    /**
     * 调整审核页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        DeptPerfAuditBO deptPerfAuditBO  = (DeptPerfAuditBO) PerfServiceFactory.getBean("pmkpi.deptZJformanceadjust.DeptPerfAuditBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptPerfAuditBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

}
