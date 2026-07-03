package gov.mof.fasp2.pmkpi.perfprotrace.info;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProTraceInfoProPage extends PmkpiPage {
    /**
     * 基本信息
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws AppException
     */
    public Map editInfo(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        return config;
    }
}
