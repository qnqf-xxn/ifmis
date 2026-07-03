package gov.mof.fasp2.pmkpi.perfcommon.aisupportaudit;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class AISupportAuditPage extends PmkpiPage {

    /**
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    public Map detail(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    public Map exeindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        AISupportAuditExeBO aISupportAuditExeBO = (AISupportAuditExeBO) ServiceFactory.getBean("pmkpi.aisupportaudit.AISupportAuditExeBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", aISupportAuditExeBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;
    }

    public Map preperf(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

}
