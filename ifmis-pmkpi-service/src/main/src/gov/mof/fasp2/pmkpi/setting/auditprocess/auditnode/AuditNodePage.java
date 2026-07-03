package gov.mof.fasp2.pmkpi.setting.auditprocess.auditnode;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description: 流程节点配置
 * @Revision History:
 * @Revision 12:00 2020/8/14  chongdayong
 */
public class AuditNodePage  extends PmkpiPage {

    /**
     * 流程节点审核配置
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        AuditNodeB0 auditNodeB0 = (AuditNodeB0) ServiceFactory.getBean("pmkpi.setting.auditnode.AuditNodeB0TX");
        request.setAttribute("leftconfig", auditNodeB0.getLeftTree());
        config.put("left", "lefttree");
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        return config;
    }

}
