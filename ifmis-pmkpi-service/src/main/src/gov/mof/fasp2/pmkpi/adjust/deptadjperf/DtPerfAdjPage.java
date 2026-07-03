package gov.mof.fasp2.pmkpi.adjust.deptadjperf;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:17 2022/05/11 gaoming
 */
public class DtPerfAdjPage extends PmkpiPage {
    /**
     * 指标
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    
    /**
     * 选择指标
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map indexcheck(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 指标编辑
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map editpage(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
