package gov.mof.fasp2.pmkpi.workevaluate.task;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class WorkEvaluateTaskPage extends PmkpiPage {

    /**
     * 首页
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

    /**
     * 新增任务
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map editindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        WorkEvaluateTaskBO workEvaluateTaskBO  = (WorkEvaluateTaskBO) PerfServiceFactory.getBean("pmkpi.workevaluate.task.WorkEvaluateTaskBOTX");
        String menuId = request.getParameter("menuId");
        String guid = request.getParameter("guid");
        String viewtype = request.getParameter("viewtype");
        String uikey = (String) config.get("pageurl"); //获取配置了多少页签.
        config.put("tabData", workEvaluateTaskBO.getTabData(uikey));
        config.put("guid", guid);
        config.put("viewtype", viewtype);
        this.getHeadTitle(config,menuId);
        return config;
    }
}
