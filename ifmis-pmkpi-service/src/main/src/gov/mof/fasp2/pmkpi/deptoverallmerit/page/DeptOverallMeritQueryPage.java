package gov.mof.fasp2.pmkpi.deptoverallmerit.page;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.deptoverallmerit.bo.DeptOverallMeritQueryBO;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeptOverallMeritQueryPage extends PmkpiPage {
    /**
     * 页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
    	DeptOverallMeritQueryBO deptOverallMeritQueryBO = (DeptOverallMeritQueryBO) ServiceFactory.getBean("pmkpi.deptoverallmerit.DeptOverallMeritQueryBOTX");
        String menuId = request.getParameter("menuId");
        String bustype = request.getParameter("bustype");
        config.put("bustype", bustype);
        //String isAgency = request.getParameter("isAgency");
        request.setAttribute("leftconfig", deptOverallMeritQueryBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
    
}
