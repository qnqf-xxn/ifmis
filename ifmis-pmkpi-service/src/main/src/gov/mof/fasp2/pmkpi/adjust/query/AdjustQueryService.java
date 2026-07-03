package gov.mof.fasp2.pmkpi.adjust.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdjustQueryService extends PmkpiService {
    private AdjustQueryBO adjustQueryBO;

    public void setAdjustQueryBO(AdjustQueryBO adjustQueryBO) {
        this.adjustQueryBO = adjustQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("deptqfdatas", adjustQueryBO.getQueryFrom("/pmkpi/adjust/report/dept"));
        config.put("proqfdatas", adjustQueryBO.getQueryFrom("/pmkpi/adjust/report/program"));
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return adjustQueryBO.getTreeData(params);
    }

}
