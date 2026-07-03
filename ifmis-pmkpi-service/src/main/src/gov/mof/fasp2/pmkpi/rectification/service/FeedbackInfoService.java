package gov.mof.fasp2.pmkpi.rectification.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.rectification.bo.FeedbackInfoBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

public class FeedbackInfoService  extends PmkpiService {
    private FeedbackInfoBO feedbackInfoBO;

    public void setFeedbackInfoBO(FeedbackInfoBO feedbackInfoBO) {
        this.feedbackInfoBO = feedbackInfoBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request,
                             HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String mainguid = request.getParameter("mainguid");
        String proguid = request.getParameter("projguid");
        String guid = request.getParameter("guid");
        String menuId = request.getParameter("menuId");
        String bustype = request.getParameter("bustype");
        config.put("bustype",bustype);
        config.put("menuid", menuId);
        config.put("guid", guid);
        config.put("mainguid", mainguid);
        config.put("proguid", proguid);
        config.put("workflow",workflow);
        return config;
    }

    public Map getText(Map config) throws AppException{
        Map configMap = feedbackInfoBO.getText(config);
        return configMap;
    }

    public Map save(HashMap config) throws AppException, ParseException {
        return feedbackInfoBO.save(config);
    }

}
