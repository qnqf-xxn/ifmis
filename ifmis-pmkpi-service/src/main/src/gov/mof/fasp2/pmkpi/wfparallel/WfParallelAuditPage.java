package gov.mof.fasp2.pmkpi.wfparallel;

import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class WfParallelAuditPage extends PmkpiPage {

    /**
     * 工作流并行.
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        String modeltype = request.getParameter("modeltype");//模块类型
        WfParallelAuditBO wfParallelAuditBO = (WfParallelAuditBO) ServiceFactory.getBean("pmkpi.wfparallel.audit.WfParallelAuditBOTX");
        //查询左侧树
        /*if (modeltype != null && "dept".equals(modeltype)){//部门
            request.setAttribute("leftconfig", wfParallelAuditBO.getDeptLeftTree(menuId));
        }else {
            request.setAttribute("leftconfig", wfParallelAuditBO.getLeftTree(menuId, modeltype));
        }*/
        request.setAttribute("leftconfig", wfParallelAuditBO.getWfLeftTree(menuId, modeltype));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
}
