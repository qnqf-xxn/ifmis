/**
 * @Title: PrjIndexPage.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfprogram.fundCalIndex.adjust;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;


public class FundCalAdjustIndexPage extends PmkpiPage {

    /**
     * 指标
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        //String menuId = request.getParameter("menuId");
        //this.getHeadTitle(config, menuId);
        return config;
    }


}
