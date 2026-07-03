package gov.mof.fasp2.pmkpi.deptoverallmerit.page;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.deptoverallmerit.bo.DeptOverallMeritReportBO;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeptOverallMeritReportPage extends PmkpiPage {
    /**
     * 下达页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
    	DeptOverallMeritReportBO deptOverallMeritReportBO = (DeptOverallMeritReportBO) ServiceFactory.getBean("pmkpi.deptoverallmerit.DeptOverallMeritReportBOTX");
        String menuId = request.getParameter("menuId");
        String bustype = request.getParameter("bustype");
        config.put("bustype", bustype);
        //String isAgency = request.getParameter("isAgency");
        request.setAttribute("leftconfig", deptOverallMeritReportBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 编辑
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map editindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    
    /**
     * 项目基本信息
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map projinfo(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    
    
    /**
     * 综合评价指标
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map deptscore(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    
    /**
     * 年度总结报告
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map workcontent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    
}
