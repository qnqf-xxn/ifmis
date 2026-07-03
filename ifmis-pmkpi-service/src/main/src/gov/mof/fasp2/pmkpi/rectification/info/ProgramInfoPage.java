package gov.mof.fasp2.pmkpi.rectification.info;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProgramInfoPage extends PmkpiPage {

    public Map editindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String mainguid = request.getParameter("mainguid");
        String proguid = request.getParameter("projguid");
        String viewtype = request.getParameter("viewtype");
        String tablecode = request.getParameter("tablecode");
        String pro_code = request.getParameter("pro_code");  //项目编码
        String bustype = request.getParameter("bustype");
        config.put("mainguid", mainguid);
        config.put("proguid", proguid);
        config.put("viewtype", viewtype);
        config.put("tablecode", tablecode);
        config.put("pro_code", pro_code);
        config.put("bustype", bustype);
        return config;
    }
}
