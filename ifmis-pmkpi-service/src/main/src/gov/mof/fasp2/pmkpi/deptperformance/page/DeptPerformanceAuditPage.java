package gov.mof.fasp2.pmkpi.deptperformance.page;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.deptperformance.bo.DeptPerformanceAuditBO;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptPerformanceAuditPage extends PmkpiPage {

    /**
     * 审核页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
    	DeptPerformanceAuditBO deptPerformanceAuditBO = (DeptPerformanceAuditBO) ServiceFactory.getBean("pmkpi.deptperformance.DeptPerformanceAuditBOTX");
        String menuId = request.getParameter("menuId");
        if(StringUtils.isEmpty(menuId)){
            menuId = request.getParameter("menuguid");
        }
        request.setAttribute("leftconfig", deptPerformanceAuditBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }

}
