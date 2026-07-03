package gov.mof.fasp2.pmkpi.deptracetask.page;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.deptracetask.bo.DeptraceTaskManageBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptraceTaskManagePage extends PmkpiPage {
    /**
     * 下达页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws AppException
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        DeptraceTaskManageBO deptraceTaskManageBO = (DeptraceTaskManageBO) ServiceFactory.getBean("pmkpi.deptracetask.DeptraceTaskManageBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", deptraceTaskManageBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 下达编辑
     * @param request
     * @param response
     * @param config
     * @return
     * @throws AppException
     */
    public Map edit(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        return config;
    }
}
