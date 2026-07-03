package gov.mof.fasp2.pmkpi.setting.expdoc;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @ClassName: BusAppendPage
 * @Description: Description of this class
 * @author <a href="mailto:zhongdayong@bjinfor.cn">chongdayong</a>于2021-4-12 下午04:10:13
 */
public class ExpdocPage extends PmkpiPage {
    /**
     * 页面配置维护
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map list(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 菜单编辑
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
