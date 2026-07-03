package gov.mof.fasp2.pmkpi.appraisal.audit;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class AppraisalAuditPage extends PmkpiPage {

    /**
     * 绩效考核审核
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        AppraisalAuditBO appraisalAuditBO = (AppraisalAuditBO) ServiceFactory.getBean("pmkpi.appraisal.AppraisalAuditBOTX");
        String menuId = StringUtil.isEmpty(request.getParameter("menuId")) ? request.getParameter("menuguid") : request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", appraisalAuditBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;
    }
}
