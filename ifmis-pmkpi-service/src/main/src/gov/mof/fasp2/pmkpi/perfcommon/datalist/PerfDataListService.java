package gov.mof.fasp2.pmkpi.perfcommon.datalist;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;
import java.util.Map;

public class PerfDataListService extends PmkpiService {
    private PerfDataListBO perfDataListBO;

    public void setPerfDataListBO(PerfDataListBO perfDataListBO) {
        this.perfDataListBO = perfDataListBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        Enumeration paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = (String) paramNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            if (paramValues.length >= 1) {
                String paramValue = paramValues[0];
                if (paramValue.length() != 0) {
                    config.put(paramName, paramValue);
                }
            }
        }
        return config;
    }
}
