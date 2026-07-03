package gov.mof.fasp2.pmkpi.hbtracereport.query;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class HbtracereportQueryPage extends PmkpiPage {

    /**
     * 部门监控报告上报查询
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map index (HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        HbtracereportQueryBO hbtracereportBO  = (HbtracereportQueryBO) PerfServiceFactory.getBean("pmkpi.hbtracereport.hbtracereportqueryBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", hbtracereportBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
}
