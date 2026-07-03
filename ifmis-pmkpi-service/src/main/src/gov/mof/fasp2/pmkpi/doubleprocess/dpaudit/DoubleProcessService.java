package gov.mof.fasp2.pmkpi.doubleprocess.dpaudit;

import gov.mof.fasp2.pmkpi.common.PmkpiService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DoubleProcessService extends PmkpiService {

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String passData = request.getParameter("passData");
        String backData = request.getParameter("backData");
        config.put("passData", passData);
        config.put("backData", backData);
        return super.loadComponent(request, response, config);
    }

}
