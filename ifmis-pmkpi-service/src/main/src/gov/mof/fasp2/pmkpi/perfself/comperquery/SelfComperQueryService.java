package gov.mof.fasp2.pmkpi.perfself.comperquery;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SelfComperQueryService extends PmkpiService {
    private SelfComperQueryBO selfComperQueryBO;

    public void setSelfComperQueryBO(SelfComperQueryBO selfComperQueryBO) {
        this.selfComperQueryBO = selfComperQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return super.loadComponent(request, response, config);
    }

    /**
     * <p>左侧树-整合菜单首次进入页面</p >
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return selfComperQueryBO.getTreeData(params);
    }
}
