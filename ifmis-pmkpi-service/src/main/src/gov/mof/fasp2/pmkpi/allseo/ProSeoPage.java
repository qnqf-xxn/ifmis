package gov.mof.fasp2.pmkpi.allseo;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProSeoPage extends PmkpiPage {

    /**
     * 查询页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ProSeoBO proSeoBO = (ProSeoBO) ServiceFactory.getBean("pmkpi.allseo.ProSeoBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", proSeoBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 详情页面编辑
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception -- 异常.
     */
    public Map editindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ProSeoBO proSeoBO = (ProSeoBO) ServiceFactory.getBean("pmkpi.allseo.ProSeoBOTX");
        String pro_code = request.getParameter("pro_code");
        request.setAttribute("leftconfig", proSeoBO.getProNodes(pro_code));
        config.put("left", "lefttree");
        return config;
    }
}
