package gov.mof.fasp2.pmkpi.evaluation.financial.deptfill;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptfillPage extends PmkpiPage {
    /**
     * 部门自评
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map list(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        DeptfillBO deptfillBO = (DeptfillBO) ServiceFactory.getBean("pmkpi.evaluation.financial.deptfill.DeptfillBOTX");
        request.setAttribute("leftconfig", deptfillBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     *部门自评编辑
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map edit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     *评分表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map score(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
