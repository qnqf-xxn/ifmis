package gov.mof.fasp2.pmkpi.perfreview.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReviewQueryService extends PmkpiService {

    private ReviewQueryBO reviewQueryBO;

    public void setReviewQueryBO(ReviewQueryBO reviewQueryBO) {
        this.reviewQueryBO = reviewQueryBO;
    }

    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        config.put("workflow", workflow);
        config.put("procoldatas", reviewQueryBO.getCols("/pmkpi/review/report/program"));
        config.put("protabledata", reviewQueryBO.getTable("/pmkpi/review/report/program"));
        config.put("proqfdatas", reviewQueryBO.getQueryFrom("/pmkpi/review/report/program"));
        config.put("deptcoldatas", reviewQueryBO.getCols("/pmkpi/review/report/dept"));
        config.put("depttabledata", reviewQueryBO.getTable("/pmkpi/review/report/dept"));
        config.put("deptqfdatas", reviewQueryBO.getQueryFrom("/pmkpi/review/report/dept"));
        return config;
    }


    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return reviewQueryBO.getTreeData(params);
    }
}
