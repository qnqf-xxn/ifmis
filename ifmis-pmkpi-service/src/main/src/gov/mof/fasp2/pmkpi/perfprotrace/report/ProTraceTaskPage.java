package gov.mof.fasp2.pmkpi.perfprotrace.report;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProTraceTaskPage extends PmkpiPage {

    /**
     * 审核页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ProTraceTaskBO proTraceTaskBO = (ProTraceTaskBO) PerfServiceFactory.getBean("pmkpi.perfprotrace.report.ProTraceTaskBOTX");
        String menuId = request.getParameter("menuId");
        if(StringUtils.isEmpty(menuId)){
            menuId = request.getParameter("menuguid");
        }
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", proTraceTaskBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }
}
