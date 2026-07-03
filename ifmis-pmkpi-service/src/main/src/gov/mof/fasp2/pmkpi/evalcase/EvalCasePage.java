package gov.mof.fasp2.pmkpi.evalcase;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class EvalCasePage extends PmkpiPage {

    /**
     * 申报页面
     * @param request -- 请求
     * @param response -- 响应  
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        EvalCaseBO evalCaseBO  = (EvalCaseBO) PerfServiceFactory.getBean("pmkpi.evalcase.EvalCaseBOTX");
        String menuId = request.getParameter("menuId");
        String querytype = request.getParameter("querytype");
        request.setAttribute("leftconfig", evalCaseBO.getTreeData(querytype));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
    
    /**
     * 申报页面编辑
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception -- 异常.
     */
    public Map resultappindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

}
