package gov.mof.fasp2.pmkpi.evaluation.dept.result;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptResultPage extends PmkpiPage {
    /**
     * 财政评价结果上传
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map list(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        DeptResultBO deptResultBO = (DeptResultBO) ServiceFactory.getBean("pmkpi.evaluation.dept.DeptResultBOTX");
        request.setAttribute("leftconfig", deptResultBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }

    /**
     * 结果页
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
     * 财政评价结果审核
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map audit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        DeptResultBO deptResultBO = (DeptResultBO) ServiceFactory.getBean("pmkpi.evaluation.dept.DeptResultBOTX");
        request.setAttribute("leftconfig", deptResultBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }
    public Map query(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        DeptResultBO deptResultBO = (DeptResultBO) ServiceFactory.getBean("pmkpi.evaluation.dept.DeptResultBOTX");
        request.setAttribute("leftconfig", deptResultBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 评价成果（宁夏）
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map evaledit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
