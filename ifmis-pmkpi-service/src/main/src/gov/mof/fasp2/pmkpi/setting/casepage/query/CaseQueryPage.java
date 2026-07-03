package gov.mof.fasp2.pmkpi.setting.casepage.query;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class CaseQueryPage extends PmkpiPage {
    /**
     * 查询列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map list(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        CaseQueryBO caseQueryBO = (CaseQueryBO) ServiceFactory.getBean("pmkpi.casepage.query.CaseQueryBOTX");
        request.setAttribute("leftconfig", caseQueryBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }
}
