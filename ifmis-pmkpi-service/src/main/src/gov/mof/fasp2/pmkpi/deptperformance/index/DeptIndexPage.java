package gov.mof.fasp2.pmkpi.deptperformance.index;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:17 2020/8/24  chongdayong
 */
public class DeptIndexPage extends PmkpiPage {
    /**
     * 指标
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    
    /**
     * 选择指标
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map indexcheck(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 指标编辑
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map editpage(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 指标推荐
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map recomindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        DeptRecomIndexBO deptRecomIndexBO  = (DeptRecomIndexBO) PerfServiceFactory.getBean("pmkpi.deptperformance.DeptRecomIndexBOTX");
        String menuId = request.getParameter("menuId");
        String saveAgency = request.getParameter("saveAgency");
        request.setAttribute("leftconfig", deptRecomIndexBO.getTreeData(menuId,saveAgency));
        config.put("left", "lefttree");
        return config;
    }

    /**
     * 选择项目指标
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map proindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
