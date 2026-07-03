package gov.mof.fasp2.pmkpi.deptperformance.func;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:44 2020/8/24  chongdayong
 */
public class DeptFuncPage extends PmkpiPage {
    /**
     * 部门职能活动
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String isadj = request.getParameter("isadjust");
        config.put("isadj",isadj);
        return config;
    }
}
