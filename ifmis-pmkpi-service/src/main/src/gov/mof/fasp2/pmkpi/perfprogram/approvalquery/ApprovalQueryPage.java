package gov.mof.fasp2.pmkpi.perfprogram.approvalquery;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ApprovalQueryPage extends PmkpiPage {

    /**
     * 查询页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ApprovalQueryBO approvalQueryBO = (ApprovalQueryBO) ServiceFactory.getBean("pmkpi.perfprogram.ApprovalQueryBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", approvalQueryBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
}
