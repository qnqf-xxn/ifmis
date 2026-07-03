/**
 * @Title: PrjIndexPage.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfset.datarule;

import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.annotation.PageConsole;
import gov.mof.fasp2.buscore.framework.annotation.PageTemplate;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * @ClassName: PrjIndexPage
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@bjinfor.cn">GM</a>于 2020-1-6 上午10:40:42
 */

public class PerfDataRulePage extends PmkpiPage {
    /**
     * 页面访问控制.
     * @return PageConsole
     */
    @SuppressWarnings("rawtypes")
    @PageConsole(
            appid = "pmkpi",
            url = "/pmkpi/perfset/datarule",
            pageTempltate = @PageTemplate(funcShow = "Ext.lt.drtemplate.AllotTemplate"), 
            page = "/pmkpi/setting/datarule/datarightallot.jsp",
            jslib = "/pmkpi/setting/datarule/allot.js",
            config = "{toolbutton:'toolbutton',header:'header',lefttree:'fasplefttabpanelId',datatable:'uidatatabledr'}", 
            component = {
                @PageComponent(serviceid = "header", id = "header"), 
                @PageComponent(serviceid = "bustoolbutton", id = "toolbutton"),
                @PageComponent(serviceid = "busuidatatable", id = "uidatatabledr", config = "{title:'数据权限信息',edit:false,rowtolist:'false'}"),
                @PageComponent(serviceid = "buslefttree", id = "fasplefttabpanelId",config = "{selectmode:n}"),
                @PageComponent(serviceid = "pmkpiPerfDataRuleService", id = "pmkpiPerfDataRuleService") })
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        //request.setAttribute("uidatatabledr", "/pmkpi/perfset/datarule");
        return config;
    }
}
