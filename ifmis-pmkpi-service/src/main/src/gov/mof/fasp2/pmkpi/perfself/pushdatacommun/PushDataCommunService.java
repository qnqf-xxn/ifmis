package gov.mof.fasp2.pmkpi.perfself.pushdatacommun;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PushDataCommunService extends PmkpiService {

    private PushDataCommunBO pushDataCommunBO;

    public void setPushDataCommunBO(PushDataCommunBO pushDataCommunBO) {
        this.pushDataCommunBO = pushDataCommunBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }

    /**
     * <p>左侧树-整合菜单首次进入页面</p >
     *
     * @param
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        return pushDataCommunBO.getTreeData(params);
    }

    /**
     * 推送数据到数据交互中心
     * @param params
     * @return
     */
    public Map<String, Object> add(HashMap<String, Object> params) throws Exception {
        return pushDataCommunBO.add(params);
    }
}
