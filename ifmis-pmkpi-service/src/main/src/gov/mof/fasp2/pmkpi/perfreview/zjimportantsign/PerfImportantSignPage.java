package gov.mof.fasp2.pmkpi.perfreview.zjimportantsign;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfImportantSignPage extends PmkpiPage {
    /**
     * 调整列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PerfImportantSignBO perfImportantSignBO  = (PerfImportantSignBO) PerfServiceFactory.getBean("pmkpi.zjimportantsign.PerfImportantSignBOTX");
        String menuId = request.getParameter("menuId");
        String lefttypes = request.getParameter("lefttypes");
        request.setAttribute("leftconfig", perfImportantSignBO.getTreeData(menuId,lefttypes));
        config.put("left", "lefttree");
        config.put("depthidemenuid", "deptsignreporthide");
        config.put("programhidemenuid", "programsignreporthide");
        this.getHeadTitle(config,menuId);
        return config;
    }

}
