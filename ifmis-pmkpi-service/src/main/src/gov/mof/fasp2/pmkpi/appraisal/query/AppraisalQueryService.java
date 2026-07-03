package gov.mof.fasp2.pmkpi.appraisal.query;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class AppraisalQueryService extends PmkpiService {
    private AppraisalQueryBO appraisalQueryBO;

    public void setAppraisalQueryBO(AppraisalQueryBO appraisalQueryBO) {
        this.appraisalQueryBO = appraisalQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }

}
