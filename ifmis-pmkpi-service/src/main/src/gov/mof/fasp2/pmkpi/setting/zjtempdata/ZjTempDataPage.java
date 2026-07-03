package gov.mof.fasp2.pmkpi.setting.zjtempdata;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ZjTempDataPage extends PmkpiPage {
    /**
     * 个性指标项目维护.
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map agencyleftindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ZjTempDataBO zjTempDataBO = (ZjTempDataBO) ServiceFactory.getBean("pmkpi.setting.zjdataset.ZjTempDataBOTX");
        String menuId = request.getParameter("menuId");
        if(StringUtils.isEmpty(menuId)){
            menuId = request.getParameter("menuguid");
        }
        this.getHeadTitle(config,menuId);
        request.setAttribute("leftconfig", zjTempDataBO.getTreeData(menuId));
        config.put("left", "lefttree");
        config.put("menuid", menuId);
        return config;
    }
}
