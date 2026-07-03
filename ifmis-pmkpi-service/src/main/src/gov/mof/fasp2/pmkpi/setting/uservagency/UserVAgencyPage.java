package gov.mof.fasp2.pmkpi.setting.uservagency;

import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.annotation.PageConsole;
import gov.mof.fasp2.buscore.framework.annotation.PageTemplate;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class UserVAgencyPage extends PmkpiPage {

	@PageConsole(
            appid = "pmkpi",
            url = "/pmkpi/setting/uservagency",
            pageTempltate = @PageTemplate(funcShow = "Ext.lt.uatemplate.AllotTemplate"), 
            page = "/pmkpi/setting/uservagency/uservagency.jsp",
            jslib = "/pmkpi/setting/uservagency/uservagency.js",
            config = "{toolbutton:'toolbutton',header:'header',lefttree:'usertree'}", 
            component = {
                @PageComponent(serviceid = "header", id = "header"), 
                @PageComponent(serviceid = "bustoolbutton", id = "toolbutton"),
                @PageComponent(serviceid = "buslefttree", id = "usertree"),
                @PageComponent(serviceid = "pmkpiUserVAgencyService", id = "pmkpiUserVAgencyService") })
	public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        return config;
    }
}
