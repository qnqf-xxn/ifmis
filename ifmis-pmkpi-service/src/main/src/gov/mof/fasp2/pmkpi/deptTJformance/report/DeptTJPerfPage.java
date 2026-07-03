package gov.mof.fasp2.pmkpi.deptTJformance.report;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptTJPerfPage extends PmkpiPage {

    /**
     * 申报页面
     * @param request -- 请求
     * @param response -- 响应  
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        DeptTJPerfBO deptTJPerfBO  = (DeptTJPerfBO) PerfServiceFactory.getBean("pmkpi.deptTJformance.DeptTJPerfBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptTJPerfBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
    /**
     * 审核页面
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map auditindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        DeptTJPerfBO deptTJPerfBO  = (DeptTJPerfBO) PerfServiceFactory.getBean("pmkpi.deptTJformance.DeptTJPerfBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptTJPerfBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
    /**
     * 查询页面
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map queryindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        DeptTJPerfBO deptTJPerfBO  = (DeptTJPerfBO) PerfServiceFactory.getBean("pmkpi.deptTJformance.DeptTJPerfBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptTJPerfBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 申报页面编辑
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception -- 异常.
     */
    public Map editindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 目标关联选择任务
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map indextask(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 分发处室
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map indexfinintorg(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 资金处室审阅
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map indexfinreview(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
