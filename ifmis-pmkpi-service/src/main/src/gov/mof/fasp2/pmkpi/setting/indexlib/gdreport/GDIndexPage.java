package gov.mof.fasp2.pmkpi.setting.indexlib.gdreport;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class GDIndexPage extends PmkpiPage {


    /**
     * 编辑页面
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
     * 债卷指标库
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        GDIndexBO gdIndexBO  = (GDIndexBO) PerfServiceFactory.getBean("pmkpi.setting.gd.GDIndexBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", gdIndexBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

}
