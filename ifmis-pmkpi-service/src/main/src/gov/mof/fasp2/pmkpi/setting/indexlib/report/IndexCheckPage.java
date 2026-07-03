package gov.mof.fasp2.pmkpi.setting.indexlib.report;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class IndexCheckPage extends PmkpiPage {

    /**
     * 指标库选择调整
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        String indextype = request.getParameter("indextype");
        String tabtype = request.getParameter("tabtype");
        config.put("indextype", indextype);
        config.put("tabtype", tabtype);
        this.getHeadTitle(config,menuId);
        return config;
    }

}
