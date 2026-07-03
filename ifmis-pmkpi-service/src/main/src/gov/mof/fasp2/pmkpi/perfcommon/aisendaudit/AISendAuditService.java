package gov.mof.fasp2.pmkpi.perfcommon.aisendaudit;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.util.Map;

public class AISendAuditService extends PmkpiService {

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String datacols = request.getParameter("datacols");
        datacols = URLDecoder.decode(datacols,"UTF-8");
        config.put("api_key", request.getParameter("api_key"));
        config.put("api_code", request.getParameter("api_code"));
        config.put("datacols", datacols.split(","));
        config.put("bustype", request.getParameter("bustype"));
        config.put("queryset", URLDecoder.decode(request.getParameter("queryset"),"UTF-8"));
        for (String c : datacols.split(",")) {
            config.put(c, request.getParameter(c));
        }
        return config;
    }

}
