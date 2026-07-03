package gov.mof.fasp2.pmkpi.perfpromod.report;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProModRpPage extends PmkpiPage {

    /**
     * 申报页面
     * @param request -- 请求
     * @param response -- 响应  
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ProModRpBO proModRpBO  = (ProModRpBO) PerfServiceFactory.getBean("pmkpi.perfpromod.ProModRpBOTX");
        String menuId = request.getParameter("menuId");
        String prolev = request.getParameter("prolev"); //项目一二三级项目
        String modtype = request.getParameter("modtype");
        request.setAttribute("leftconfig", proModRpBO.getTreeData(menuId,prolev));
        config.put("left", "lefttree");
        config.put("modtype", modtype);
        this.getHeadTitle(config,menuId);
        return config;
    }
    
    /**
     * 申报页面编辑
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
     * 指标新增页.
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map addindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 选择项目页.
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map programcheck(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
