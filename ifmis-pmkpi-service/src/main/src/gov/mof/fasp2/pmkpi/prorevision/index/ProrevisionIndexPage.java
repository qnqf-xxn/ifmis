package gov.mof.fasp2.pmkpi.prorevision.index;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProrevisionIndexPage extends PmkpiPage {
    /**
     * 绩效指标调整
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        config.put("filterbeanid", "pmkpi.filter.PerfUIFilter");
        return config;
    }
}
