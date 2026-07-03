package gov.mof.fasp2.pmkpi.perfcommon.auditopinion;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class AuditopinionPage extends PmkpiPage {

    /**
     * 审核意见
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map auditedit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
