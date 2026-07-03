package gov.mof.fasp2.pmkpi.setting.auditprocess.naturesaudit;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description: 四性审核配置
 * @Revision History:
 * @Revision 21:26 2020/8/13  chongdayong
 */
public class NaturesAuditPage extends PmkpiPage {

    /**
     * 四性审核维护
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        return config;
    }
}
