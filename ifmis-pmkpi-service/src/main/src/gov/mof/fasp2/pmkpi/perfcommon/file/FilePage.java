package gov.mof.fasp2.pmkpi.perfcommon.file;

import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.annotation.PageConsole;
import gov.mof.fasp2.buscore.framework.annotation.PageTemplate;
import gov.mof.fasp2.buscore.framework.util.GlobalConfig;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 11:23 2020/8/25  chongdayong
 */
public class FilePage extends PmkpiPage {
    /**
     * 附件
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    @PageConsole(
            appid = "pmkpi",
            jslib = "/pmkpi/common/filemanage/filemanage.js,/pmkpi/common/perfutil.js",
            url = "/pmkpi/file/index",
            page = "/pmkpi/common/filemanage/filemanage.jsp",
            config = "{name:'附件上传',enablecfg:false}",
            pageTempltate = @PageTemplate(funcShow = "Ext.lt.pmkpi.filemanage"),
            component = {@PageComponent(serviceid = "pmkpifileManageService", id = "pmkpifileManageService")})
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String viewtype = request.getParameter("viewtype");
        String systemStyle = GlobalConfig.getConfigData("SYSTEM_STYLE");
        request.setAttribute("SYSTEM_STYLE", systemStyle);
        config.put("viewtype", viewtype);
        return config;
    }
}
