package gov.mof.fasp2.pmkpi.performanceopen.query;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @author zhangxutao
 * @version 1.0
 * @description: TODO
 * @date 2023/4/18 10:30
 */
public class PerfOpenQueryService extends PmkpiService {


    private PerfOpenQueryBO perfOpenQueryBO;

    /**
     * 注入bo.
     * @param perfOpenQueryBO
     */
    public void setPerfOpenQueryBO(PerfOpenQueryBO perfOpenQueryBO) {
        this.perfOpenQueryBO = perfOpenQueryBO;
    }


    @SuppressWarnings("unchecked")
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        config.put("workflow",workflow);
        return config;
    }

}
