package gov.mof.fasp2.pmkpi.perfprotrace.indextarget;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProIndexTargetPage extends PmkpiPage {
    /**
     * 指标完成情况。
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map list(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 指标完成情况(湖北)
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map hbindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
