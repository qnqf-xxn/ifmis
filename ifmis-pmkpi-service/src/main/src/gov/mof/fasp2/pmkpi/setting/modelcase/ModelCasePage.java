package gov.mof.fasp2.pmkpi.setting.modelcase;

import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description:案例/模板指标
 * @Revision History:
 * @Revision 20:44 2020/8/18  chongdayong
 */
public class ModelCasePage extends PmkpiPage {
    /**
     * 案例/模板列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map list(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        ModelCaseBO baseinfoBO = (ModelCaseBO) ServiceFactory.getBean("pmkpi.setting.modelcase.ModelCaseBOTX");
        request.setAttribute("leftconfig", baseinfoBO.getTreeData());
        config.put("left", "lefttree");
        return config;
    }

    /**
     * 指标列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map indexlist(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 指标编辑
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map indexedit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
