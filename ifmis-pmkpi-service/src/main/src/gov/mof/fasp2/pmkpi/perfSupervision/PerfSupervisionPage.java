package gov.mof.fasp2.pmkpi.perfSupervision;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfSupervisionPage extends PmkpiPage {

    /**
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     * @Title: index
     * @Description: TODO(监审)
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PerfSupervisionBO perfSupervisionBO = (PerfSupervisionBO) ServiceFactory.getBean("pmkpi.perfSupervision.PerfSupervisionBOTX");
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", perfSupervisionBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;
    }

    public Map updateIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}