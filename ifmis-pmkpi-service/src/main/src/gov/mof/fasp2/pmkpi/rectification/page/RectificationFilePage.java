package gov.mof.fasp2.pmkpi.rectification.page;

import gov.mof.fasp2.buscore.framework.util.GlobalConfig;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class RectificationFilePage extends PmkpiPage {

    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String viewtype = request.getParameter("viewtype");
        String bustype = request.getParameter("bustype");
        String rectype = request.getParameter("rectype");
        String mainguid = request.getParameter("mainguid");
        String projguid = request.getParameter("projguid");
        String pro_code = request.getParameter("pro_code");
        String workflow = request.getParameter("workflow");
        String rectifyType = request.getParameter("rectifyType");
        String filebustype = request.getParameter("filebustype");
        String systemStyle = GlobalConfig.getConfigData("SYSTEM_STYLE");
        request.setAttribute("SYSTEM_STYLE", systemStyle);
        String treeid = request.getParameter("treeid");
        config.put("rectifys", request.getParameter("rectifys"));
        config.put("treeid", treeid);
        config.put("viewtype", viewtype);
        config.put("bustype", bustype);
        config.put("rectype", rectype);
        config.put("mainguid", mainguid);
        config.put("projguid", projguid);
        config.put("pro_code", pro_code);
        config.put("workflow", workflow);
        config.put("rectifyType", rectifyType);
        config.put("filebustype",filebustype);
        return config;
    }
}
