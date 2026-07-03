package gov.mof.fasp2.pmkpi.perfselfreview.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfSelfReviewQueryService extends PmkpiService {

    public PerfSelfReviewQueryBO perfSelfReviewQueryBO;

    public void setPerfSelfReviewQueryBO(PerfSelfReviewQueryBO perfSelfReviewQueryBO) {
        this.perfSelfReviewQueryBO = perfSelfReviewQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return super.loadComponent(request, response, config);
    }

    /**
     * <p>左侧树-整合菜单首次进入页面</p >
     * @param
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return perfSelfReviewQueryBO.getTreeData(params);
    }
}
