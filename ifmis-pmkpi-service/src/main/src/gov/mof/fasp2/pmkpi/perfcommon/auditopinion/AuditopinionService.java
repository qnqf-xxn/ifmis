package gov.mof.fasp2.pmkpi.perfcommon.auditopinion;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.util.Enumeration;
import java.util.Map;

public class AuditopinionService extends PmkpiService {

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        Enumeration paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = (String) paramNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            if (paramValues.length == 1) {
                String paramValue = paramValues[0];
                if (paramValue.length() != 0) {
                    config.put(paramName, paramValue);
                }
            }
        }
        String actionname = request.getParameter("actionname");
        // 审核名称 中文参数乱码问题
        if (!StringUtil.isEmpty(actionname)) {
            actionname = URLDecoder.decode(request.getParameter("actionname"),"UTF-8");
        }
        config.put("actionname", actionname);
        config.remove("datas");
        config.remove("auditdata");
        return config;
    }
}
