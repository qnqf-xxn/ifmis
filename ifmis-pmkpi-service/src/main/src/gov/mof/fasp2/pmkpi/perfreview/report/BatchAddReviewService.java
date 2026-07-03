package gov.mof.fasp2.pmkpi.perfreview.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * 批量提交送审
 */
public class BatchAddReviewService extends PmkpiService {
    private PerfReviewBO perfReviewBO;

    public void setPerfReviewBO(PerfReviewBO perfReviewBO) {
        this.perfReviewBO = perfReviewBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("bustype", request.getParameter("bustype"));
        config.put("workflow", request.getParameter("workflow"));
        return config;
    }

    /**
     * 抓取未评审信息
     * @param params
     * @return
     */
    public Map<String,Object> batchadd (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfReviewBO.batchadd(params);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
