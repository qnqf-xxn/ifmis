package gov.mof.fasp2.pmkpi.perfprotrace.appresult;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * <p>绩效监控结果应用</p >
 *
 * @author hw
 * @date 2022/12/8 17:07
 */
public class ProTraceAppResultPage extends PmkpiPage {

    /**
     * 查询页面
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ProTraceAppResultBO proTraceAppResultBO = (ProTraceAppResultBO) ServiceFactory.getBean("pmkpi.perfprotrace.appresult.ProTraceAppResultBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", proTraceAppResultBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }
}
