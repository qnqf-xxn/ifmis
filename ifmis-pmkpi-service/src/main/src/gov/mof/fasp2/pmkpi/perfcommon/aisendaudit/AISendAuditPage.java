package gov.mof.fasp2.pmkpi.perfcommon.aisendaudit;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * AI辅助审核
 */
public class AISendAuditPage extends PmkpiPage {
    /**
     * 辅助审核
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map sendaudit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
