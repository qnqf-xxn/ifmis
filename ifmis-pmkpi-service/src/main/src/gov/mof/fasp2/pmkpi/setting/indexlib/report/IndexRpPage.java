package gov.mof.fasp2.pmkpi.setting.indexlib.report;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description:指标库
 * @Revision History:
 * @Revision 14:52 2020/8/17  chongdayong
 */
public class IndexRpPage extends PmkpiPage {

    /**
     * 指标库
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        this.waitDoAction(request,response,config);
        String menuId = request.getParameter("menuId");
        String pagetype = request.getParameter("types");
        IndexRpBO indexRpBO = (IndexRpBO) ServiceFactory.getBean("pmkpi.setting.indexlib.report.IndexRpBOTx");
        request.setAttribute("leftconfig", indexRpBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        config.put("pagetype", pagetype);
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 指标库编辑页
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map edit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 指标库编辑页
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map commedit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

}
