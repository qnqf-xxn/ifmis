package gov.mof.fasp2.pmkpi.evaluation.financial.query;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class FinancialQueryPage extends PmkpiPage {
    /**
     * 重点评价列表
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map list(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        FinancialQueryBO FinancialQueryBO = (FinancialQueryBO) ServiceFactory.getBean("pmkpi.evaluation.financial.query.FinancialQueryBOTX");
        request.setAttribute("leftconfig", FinancialQueryBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;
    }

}
