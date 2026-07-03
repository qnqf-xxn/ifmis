package gov.mof.fasp2.pmkpi.evaluation.dept.report;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptReportAddPage extends PmkpiPage{

    /**
     * 基本信息
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map editInfo(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
