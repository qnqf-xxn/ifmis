package gov.mof.fasp2.pmkpi.perfcommon.intoindexlib;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class IntoIndexLibPage extends PmkpiPage {
    /**
     * 纳入指标列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map list(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 填报要素说明列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map explan(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
