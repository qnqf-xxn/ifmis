package gov.mof.fasp2.pmkpi.projapplyjs.page;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProjPage extends PmkpiPage {

    
    /**
     * 事前绩效评估表信息
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map perfAdvEvalindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }


    /**
     * 项目审核
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map projAudit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String bustype = request.getParameter("bustype");
        config.put("bustype", bustype);
        return config;
    }

}
