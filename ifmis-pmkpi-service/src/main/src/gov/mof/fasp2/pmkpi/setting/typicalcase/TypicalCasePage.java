package gov.mof.fasp2.pmkpi.setting.typicalcase;

import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description:典型案例
 */
public class TypicalCasePage extends PmkpiPage {
    /**
     * 案例/模板列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        TypicalCaseBO typicalCaseBO = (TypicalCaseBO) ServiceFactory.getBean("pmkpi.typicalcase.TypicalCaseBOTX");
        request.setAttribute("leftconfig", typicalCaseBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        return config;
    }


    /**
     * 编辑
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
     * 基本信息
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map info(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
