package gov.mof.fasp2.pmkpi.evaluateTemp.page;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class EvaluateTempPage extends PmkpiPage {

    
    /**  
     * @Title: evaluateType
     * @Description: TODO(评价类型)
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
     * 评价类型新增页
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map add(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 评价类型基本信息页签
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map evaltypeinfo(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 评价模板基本信息页签
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map evaltempinfo(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 新增一级评价模板
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map tempAdd(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
