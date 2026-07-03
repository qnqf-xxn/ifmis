package gov.mof.fasp2.pmkpi.workevaluate.assign;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class TaskAssignPage extends PmkpiPage {

    /**
     * 下达
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        TaskAssignBO taskAssignBO  = (TaskAssignBO) PerfServiceFactory.getBean("pmkpi.workevaluate.assign.TaskAssignBOTX");
        String guid = request.getParameter("guid");
        String tasktype = request.getParameter("tasktype");
        String bustype = request.getParameter("bustype");
        String uikey = (String) config.get("pageurl"); //获取配置了多少页签.
        config.put("tabData", taskAssignBO.getTabData(uikey));
        config.put("guid", guid);
        config.put("tasktype", tasktype);
        config.put("bustype", bustype);
        return config;
    }
}
