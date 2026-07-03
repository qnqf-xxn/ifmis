package gov.mof.fasp2.pmkpi.componentAllot;

import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.annotation.PageConsole;
import gov.mof.fasp2.buscore.framework.annotation.PageTemplate;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfComponentRulePage extends PmkpiPage {

    /**
     * 页面访问控制.
     * @return PageConsole
     */
    @SuppressWarnings("rawtypes")
    @PageConsole(
            appid = "pmkpi",
            url = "/pmkpi/perfset/component",
            pageTempltate = @PageTemplate(funcShow = "Ext.lt.drtemplate.AllotTemplate"),
            page = "/pmkpi/setting/component/datadistribution.jsp",
            jslib = "/pmkpi/setting/component/dataallot.js",
            config = "{toolbutton:'toolbutton',header:'header',lefttree:'fasplefttabpanelId',datatable:'uidatatabledr'}",
            component = {
                    @PageComponent(serviceid = "header", id = "header"),
                    @PageComponent(serviceid = "bustoolbutton", id = "toolbutton"),
                    @PageComponent(serviceid = "busuidatatable", id = "uidatatabledr"),
                    @PageComponent(serviceid = "buslefttree", id = "fasplefttabpanelId",config = "{selectmode:n}"),
                    @PageComponent(serviceid = "pmkpiPerfDataAllotService", id = "pmkpiPerfDataAllotService") })
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

}
