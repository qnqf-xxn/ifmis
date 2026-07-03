package gov.mof.fasp2.pmkpi.setting.expdoc.temp;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @ClassName: UiPage
 * @Description: Description of this class
 * @author <a href="mailto:zhongdayong@bjinfor.cn">chongdayong</a>于2021-4-12 下午05:32:44
 */
public class ExpdocTempPage extends PmkpiPage {
	/**
     * @Description:编辑列表页面
     * @param request - HttpServletRequest
     * @param response - HttpServletResponse
     * @param config - 参数
     * @return - 返回参数
     * @throws Exception - 异常处理
     * @throws
     */
    public Map<String, Object> editpage(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> config) throws Exception {
        return config;
    }
    
    /**
     * @Description:按钮列表.
     * @param request - HttpServletRequest
     * @param response - HttpServletResponse
     * @param config - 参数
     * @return - 返回参数
     * @throws Exception - 异常处理
     * @throws
     */
    public Map<String, Object> uifunctionpage(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> config) throws Exception {
        return config;
    }
    
    /**
     * @Description:页签列表.
     * @param request - HttpServletRequest
     * @param response - HttpServletResponse
     * @param config - 参数
     * @return - 返回参数
     * @throws Exception - 异常处理
     * @throws
     */
    public Map<String, Object> uitabpage(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> config) throws Exception {
        return config;
    }

    /**
     * @Description:查询区列表.
     * @param request - HttpServletRequest
     * @param response - HttpServletResponse
     * @param config - 参数
     * @return - 返回参数
     * @throws Exception - 异常处理
     * @throws
     */
    public Map<String, Object> uiqueryform(HttpServletRequest request, HttpServletResponse response,
                                         Map<String, Object> config) throws Exception {
        return config;
    }

    /**
     * @Description:列表区列表.
     * @param request - HttpServletRequest
     * @param response - HttpServletResponse
     * @param config - 参数
     * @return - 返回参数
     * @throws Exception - 异常处理
     * @throws
     */
    public Map<String, Object> uitable(HttpServletRequest request, HttpServletResponse response,
                                           Map<String, Object> config) throws Exception {
        return config;
    }
}
