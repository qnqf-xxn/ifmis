package gov.mof.fasp2.pmkpi.setting.index;

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
public class IndexPage extends PmkpiPage {

    /**
     * 指标库
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        IndexBO indexBO = (IndexBO) ServiceFactory.getBean("pmkpi.setting.index.IndexBOTX");
        request.setAttribute("leftconfig", indexBO.getLeftTree());
        config.put("left", "lefttree");
        String menuId = request.getParameter("menuId");
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
}
