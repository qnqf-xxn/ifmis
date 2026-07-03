package gov.mof.fasp2.pmkpi.setting.evaluation.proaudit;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProEvaluationAuditPage extends PmkpiPage {

    /**
     * 调整列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        String proguid = request.getParameter("proguid");
        String viewtype = request.getParameter("viewtype");
        this.waitDoAction(request,response,config);
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        config.put("proguid", proguid);
        config.put("viewtype", viewtype);
        return config;
    }

}
