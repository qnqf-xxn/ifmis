package gov.mof.fasp2.pmkpi.hbtracereport.upload;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class HbtracereportPage extends PmkpiPage {
    /**
     * 部门监控报告上报
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map index (HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        HbtracereportBO hbtracereportBO  = (HbtracereportBO) PerfServiceFactory.getBean("pmkpi.hbtracereport.hbtracereportBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", hbtracereportBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 部门监控报告编辑
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map editindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        HbtracereportBO hbtracereportBO  = (HbtracereportBO) PerfServiceFactory.getBean("pmkpi.hbtracereport.hbtracereportBOTX");
        String agency = request.getParameter("agency");
        String viewtype = request.getParameter("viewtype");
        String mainguid = request.getParameter("mainguid");
        String uikey = (String) config.get("pageurl");
        String mod =  request.getParameter("mod");
        config.put("agency", agency);
        config.put("viewtype", viewtype);
        config.put("mainguid", mainguid);
        config.put("mod", mod);
        config.put("tabData", hbtracereportBO.getTabData(uikey));
        return config;
    }
}
