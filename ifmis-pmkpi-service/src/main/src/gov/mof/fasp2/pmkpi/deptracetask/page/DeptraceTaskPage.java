package gov.mof.fasp2.pmkpi.deptracetask.page;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.deptracetask.bo.DeptraceTaskBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptraceTaskPage extends PmkpiPage {

    /**
     * 申报页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws AppException
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        DeptraceTaskBO deptraceTaskBO = (DeptraceTaskBO) ServiceFactory.getBean("pmkpi.deptracetask.DeptraceTaskBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptraceTaskBO.getTreeData(menuId));
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
     * @throws AppException
     */
    public Map editindex(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        return config;
    }

    /**
     * 指标新增页.
     * @param request
     * @param response
     * @param config
     * @return
     * @throws AppException
     */
    public Map addindex(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        return config;
    }
}
