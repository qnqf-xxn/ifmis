package gov.mof.fasp2.pmkpi.setting.indexlib.finagive;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class IndFinaGivePage extends PmkpiPage {

    /**
     * 查询页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        IndFinaGiveBO indFinaGiveBO = (IndFinaGiveBO) ServiceFactory.getBean("pmkpi.finagive.IndFinaGiveBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", indFinaGiveBO.getTreeData());
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 授权指标页面.
     * @param request -- 请求
     * @param response --- 响应
     * @param config -- 配置.
     * @return
     * @throws Exception -- 异常
     */
    public Map giveedit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

}
