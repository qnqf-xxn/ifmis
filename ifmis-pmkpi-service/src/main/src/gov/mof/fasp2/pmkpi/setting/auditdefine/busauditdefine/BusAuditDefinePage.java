package gov.mof.fasp2.pmkpi.setting.auditdefine.busauditdefine;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 9:23 2020/9/19  chongdayong
 */
public class BusAuditDefinePage extends PmkpiPage {
    /**
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map editMenu(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuid = request.getParameter("menuid");
        String pagetype = request.getParameter("pagetype");
        String levelno = request.getParameter("levelno");
        config.put("superid",menuid);
        config.put("levelno",levelno);
        config.put("pagetype",pagetype);
        return config;
    }
}
