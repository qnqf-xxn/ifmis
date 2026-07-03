package gov.mof.fasp2.pmkpi.perfprogram.approvalquery;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ApprovalQueryService extends PmkpiService {

    private ApprovalQueryBO approvalQueryBO;

    public void setApprovalQueryBO(ApprovalQueryBO approvalQueryBO) {
        this.approvalQueryBO = approvalQueryBO;
    }

    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String type = request.getParameter("type"); // 1-事前绩效评估查询；2-项目绩效目标查询
        config.put("type", type);
        return config;
    }
}
