package gov.mof.fasp2.pmkpi.setting.taskset;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class TaskSetPage extends PmkpiPage {

    public Map list(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        TaskSetBO taskSetBO = (TaskSetBO) PerfServiceFactory.getBean("pmkpi.setting.taskset.TaskSetBOTX");
        request.setAttribute("leftconfig", taskSetBO.getLeftTree());
        config.put("left", "lefttree");
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        return config;
    }

    public Map edit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
