package gov.mof.fasp2.pmkpi.common;

import gov.mof.fasp2.buscommon.ui.header.HeaderComponet;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.server.AbstractPageService;
import gov.mof.fasp2.busfw.util.ServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PmkpiPage  extends AbstractPageService {

    protected void getHeadTitle(Map config, String menuId) throws AppException {
        HeaderComponet headerComponet = (HeaderComponet) ServiceFactory.getBean("buscommon.ui.header");
        String location = headerComponet.getLocation(menuId);
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        config.put("location", location);

    }

    /**
     * 处理代办 过滤,
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map waitDoAction(HttpServletRequest request, HttpServletResponse response, Map config){
        String lefttabnum = request.getParameter("lefttabnum"); //出来代办事项.
        config.put("lefttabnum", lefttabnum);
        return config;
    }
}
