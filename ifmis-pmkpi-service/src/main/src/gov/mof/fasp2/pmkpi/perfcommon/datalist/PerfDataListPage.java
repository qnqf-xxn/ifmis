package gov.mof.fasp2.pmkpi.perfcommon.datalist;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfDataListPage extends PmkpiPage {
    /**
     * 列表页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map list(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        if(StringUtils.isEmpty(menuId)){
            menuId = request.getParameter("menuguid");
        }
        this.getHeadTitle(config,menuId);
        return config;
    }
}
