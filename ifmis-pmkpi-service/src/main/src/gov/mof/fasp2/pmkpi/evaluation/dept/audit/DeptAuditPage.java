package gov.mof.fasp2.pmkpi.evaluation.dept.audit;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptAuditPage extends PmkpiPage {
    /**
     * 重点评价审核列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map list(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        DeptAuditBO deptAuditBO = (DeptAuditBO) ServiceFactory.getBean("pmkpi.evaluation.dept.audit.DeptAuditBOTX");
        request.setAttribute("leftconfig", deptAuditBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }

    /**
     * 审核页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map audit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
