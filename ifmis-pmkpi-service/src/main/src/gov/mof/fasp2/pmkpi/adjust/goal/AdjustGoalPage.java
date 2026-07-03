package gov.mof.fasp2.pmkpi.adjust.goal;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class AdjustGoalPage extends PmkpiPage {
    /**
     * 绩效目标
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 绩效目标(列表)。
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map goalindex(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        return config;
    }
}
