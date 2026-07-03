package gov.mof.fasp2.pmkpi.adjust.index;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class AdjustIndexPage extends PmkpiPage {
    /**
     * 绩效指标调整
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
     * 绩效指标调整(湖北)
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map hbindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 转移支付项目下级区划指标明细页面
     * @param request -- 请求
     * @param response -- 响应
     * @param config
     * @return
     * @throws Exception
     */
    public Map<String, Object> traIndex(HttpServletRequest request, HttpServletResponse response, Map<String, Object> config) throws Exception {
        String procode = request.getParameter("pro_code") == null ? request.getParameter("procode") : request.getParameter("pro_code");
        String submofdivcodes = request.getParameter("submofdivcodes");
        String istztj = request.getParameter("istztj");
        AdjustTraIndexBO adjustTraIndexBO  = (AdjustTraIndexBO) PerfServiceFactory.getBean("pmkpi.adjust.AdjustTraIndexBOTX");
        request.setAttribute("leftconfig", adjustTraIndexBO.getTreeData(procode, submofdivcodes, istztj));
        config.put("left", "lefttree");
        return config;
    }
}
