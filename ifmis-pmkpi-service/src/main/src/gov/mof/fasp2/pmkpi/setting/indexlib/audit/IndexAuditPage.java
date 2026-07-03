package gov.mof.fasp2.pmkpi.setting.indexlib.audit;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description:指标审核
 * @Revision History:
 * @Revision 14:52 2021/01/22  GM
 */
public class IndexAuditPage extends PmkpiPage {

    /**
     * 指标库
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        this.waitDoAction(request,response,config);
        String menuId = request.getParameter("menuId");
        String pagetype = request.getParameter("pagetype");
        IndexAuditBO indexAuditBO = (IndexAuditBO) ServiceFactory.getBean("pmkpi.setting.indexlib.audit.IndexAuditBOTx");
        request.setAttribute("leftconfig", indexAuditBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        config.put("pagetype", pagetype);
        this.getHeadTitle(config,menuId);
        return config;
    }
}
