package gov.mof.fasp2.pmkpi.perfprotrace.dept.send;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptKeyTaskSendPage extends PmkpiPage {
    /**
     * 下达页面
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        DeptKeyTaskSendBO deptKeyTaskSendBO = (DeptKeyTaskSendBO) PerfServiceFactory.getBean("pmkpi.perfprotrace.deptsend.DeptKeyTaskSendBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptKeyTaskSendBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;
    }

}
