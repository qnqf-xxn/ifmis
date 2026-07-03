package gov.mof.fasp2.pmkpi.perfQuery;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * <p>绩效目标查询（菜单整合）</p >
 *
 * @author hw
 * @date 2021/5/19 17:34
 */
public class PerfQueryPage extends PmkpiPage {

    /**
     * <p></p >
     *
     * @param
     * @author hw
     * @date 2021/5/19 17:34
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PerfQueryBO perfQueryBO = (PerfQueryBO) ServiceFactory.getBean("pmkpi.perfQuery.PerfQueryBOTX");
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", perfQueryBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;
    }
}