package gov.mof.fasp2.pmkpi.rectification.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.rectification.bo.RectificationAddProjBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

public class RectificationAddProjService  extends PmkpiService {
    private RectificationAddProjBO rectificationAddProjBO;

    public void setRectificationAddProjBO(RectificationAddProjBO rectificationAddProjBO) {
        this.rectificationAddProjBO = rectificationAddProjBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request,
                             HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String projId = request.getParameter("projId");
        String bustype = request.getParameter("bustype");
        String type = request.getParameter("type");
        String menuid = request.getParameter("menuid");
        String leftmenuid = request.getParameter("leftmenuid");
        String lefttabtype = request.getParameter("lefttabtype");
        String rectype = request.getParameter("rectype");//整改类型   1：绩效监控  2：绩效自评  3：部门自评  4：财政评价
        config.put("projid", projId);
        config.put("type", type);
        config.put("menuid", menuid);
        config.put("bustype", bustype);
        config.put("leftmenuid", leftmenuid);
        config.put("lefttabtype",lefttabtype);
        config.put("rectype",rectype);
        return config;
    }

    public Map save(HashMap config) throws AppException, ParseException {
        return rectificationAddProjBO.save(config);
    }
}
