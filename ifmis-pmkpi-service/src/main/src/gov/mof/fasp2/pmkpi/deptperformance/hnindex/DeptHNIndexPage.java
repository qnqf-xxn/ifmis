package gov.mof.fasp2.pmkpi.deptperformance.hnindex;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:17 2020/8/24  chongdayong
 */
public class DeptHNIndexPage extends PmkpiPage {
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
}
