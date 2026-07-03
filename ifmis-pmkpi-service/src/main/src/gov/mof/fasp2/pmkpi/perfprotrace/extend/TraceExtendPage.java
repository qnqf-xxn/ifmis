package gov.mof.fasp2.pmkpi.perfprotrace.extend;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class TraceExtendPage extends PmkpiPage {
    /**
     * 延伸监控。
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
