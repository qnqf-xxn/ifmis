package gov.mof.fasp2.pmkpi.setting.casepage.casemarkedindi;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class CasemarkedIndiService extends PmkpiService {

    private CasemarkedIndiBO casemarkedIndiBO;

    public void setCasemarkedIndiBO(CasemarkedIndiBO casemarkedIndiBO) {
        this.casemarkedIndiBO = casemarkedIndiBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String indi_code = request.getParameter("indi_code");
        String queryYear = request.getParameter("queryYear");
        config.put("indi_code", indi_code);
        config.put("queryYear", queryYear);
        config.put("defYear", SecureUtil.getUserSelectYear());
        return config;
    }

    public Map<String, Object> getTreeData (HashMap<String, Object> params) throws AppException {
        return casemarkedIndiBO.getTreeData(params);
    }
}
