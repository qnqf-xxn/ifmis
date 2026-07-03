package gov.mof.fasp2.pmkpi.setting.indexauth;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description:指标库共享授权
 * @Revision History:
 * @Revision 14:52 2022/7/7  fengji
 */
public class IndexAuthPage extends PmkpiPage {

    /**
     * 指标库共享授权
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
