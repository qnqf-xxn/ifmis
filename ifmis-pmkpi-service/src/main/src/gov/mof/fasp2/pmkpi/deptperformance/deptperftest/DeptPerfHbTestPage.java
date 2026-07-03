package gov.mof.fasp2.pmkpi.deptperformance.deptperftest;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * <p>湖北-部门整体绩效（试点）</p >
 *
 * @author hw
 * @date 2022/9/8 16:37
 */
public class DeptPerfHbTestPage extends PmkpiPage {
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
