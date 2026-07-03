package gov.mof.fasp2.pmkpi.setting.casepage.audit;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class CaseAuditPage extends PmkpiPage {

    /**
     * 审核列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map audit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        CaseAuditBO caseAuditBO = (CaseAuditBO) ServiceFactory.getBean("pmkpi.casepage.audit.CaseAuditBOTX");
        request.setAttribute("leftconfig", caseAuditBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }
}
