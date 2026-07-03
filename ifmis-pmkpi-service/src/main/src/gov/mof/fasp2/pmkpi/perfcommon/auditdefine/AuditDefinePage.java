package gov.mof.fasp2.pmkpi.perfcommon.auditdefine;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class AuditDefinePage extends PmkpiPage {
    /**
     * 错误信息展示页
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map error(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
