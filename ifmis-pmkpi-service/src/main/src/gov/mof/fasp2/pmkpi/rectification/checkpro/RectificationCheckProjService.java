package gov.mof.fasp2.pmkpi.rectification.checkpro;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

public class RectificationCheckProjService extends PmkpiService {
    private RectificationCheckProjBO rectificationCheckProjBO;

    public void setRectificationCheckProjBO(RectificationCheckProjBO rectificationCheckProjBO) {
        this.rectificationCheckProjBO = rectificationCheckProjBO;
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
        //config.put("querydatas", rectificationCheckProjBO.getQueryFrom("/pmkpi/rectification/check/proj"));
        String treeid = request.getParameter("treeid");
        String lefttreename = request.getParameter("lefttreename");
        config.put("treeid", treeid);
        config.put("lefttreename", lefttreename);
        config.put("querydatas", rectificationCheckProjBO.getQueryFrom("/pmkpi/rectification/check/proj"));
        config.put("selfquerydata", rectificationCheckProjBO.getQueryFrom("/pmkpi/rectification/check/selfproj"));
        config.put("deptquerydatas", rectificationCheckProjBO.getQueryFrom("/pmkpi/rectification/check/deptproj"));
        config.put("projid", projId);
        config.put("type", type);
        config.put("menuid", menuid);
        config.put("bustype", bustype);
        config.put("leftmenuid", leftmenuid);
        config.put("lefttabtype",lefttabtype);
        return config;
    }

    public Map save(HashMap config) throws AppException, ParseException {
        return rectificationCheckProjBO.save(config);
    }
}
