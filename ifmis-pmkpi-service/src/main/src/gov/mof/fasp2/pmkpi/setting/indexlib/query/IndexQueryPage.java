package gov.mof.fasp2.pmkpi.setting.indexlib.query;

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
public class IndexQueryPage extends PmkpiPage {

    /**
     * 指标库
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        String pagetype = request.getParameter("types");
        String key,tabkey = "";
        if ("dept".equals(pagetype)) {
            tabkey = "/pmkpi/index/query/dept";
            key = "/pmkpi/indexlib/deptlist";
        } else {
            tabkey = "/pmkpi/index/query";
            key = "/pmkpi/indexlib/list";
        }
        config.put("tabkey", tabkey);
        IndexQueryBO  indexQueryBO= (IndexQueryBO) ServiceFactory.getBean("pmkpi.setting.indexlib.query.IndexQueryBOTx");
        request.setAttribute("leftconfig", indexQueryBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        config.put("pagetype", pagetype);
        this.getHeadTitle(config,menuId);
        Map map = this.getComponentConfig("datatable");
        map.put("key", key);
        this.setConfig2Component("datatable", map);
        return config;
    }
}
