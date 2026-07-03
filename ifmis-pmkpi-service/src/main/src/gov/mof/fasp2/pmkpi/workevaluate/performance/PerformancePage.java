package gov.mof.fasp2.pmkpi.workevaluate.performance;

import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.annotation.PageConsole;
import gov.mof.fasp2.buscore.framework.annotation.PageTemplate;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class PerformancePage extends PmkpiPage {

    /**
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    @PageConsole(appid = "pmkpi", url = "/pmkpi/workevaluate/performance/index", page = "/busfw/common/template/template_defautl.jsp", jslib = "/busfw/common/template/template_default.js,/pmkpi/common/common.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js",
            pageTempltate =
            @PageTemplate(funcShow = "Ext.lt.ui.template"),
            config = "{header:[header],main:[toolbutton,queryform,datatable],heights:[null,null,null]}",
            component = {
            @PageComponent(serviceid = "header", id = "header"),
            @PageComponent(serviceid = "bustoolbutton", id = "toolbutton"),
            @PageComponent(serviceid = "busqueryform", id = "queryform",config="{name:'查询区',datatable:'datatable',fastquery:true,drawmode:'div',label:'快速查询',labelwidth:'120'}"),
            @PageComponent(serviceid = "buslefttree", id = "lefttree"),
            @PageComponent(serviceid = "busuidatatable", id = "datatable", config = "{checkbox:true,title:'绩效考核',edit:false,addrow:'false'}"),
            @PageComponent(serviceid = "pmkpi.performance.performanceService", id = "indexservice")})
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("submenu");
        PerformanceBO performanceBO = (PerformanceBO) ServiceFactory.getBean("pmkpi.workevaluate.performance.PerformanceBOTX");
        HashMap<String, Object> params =new HashMap<>();
        params.put("menuId", menuId);
        request.setAttribute("leftconfig", performanceBO.getLeftTree(params));
        config.put("left", "lefttree");
        return config;
    }
}
