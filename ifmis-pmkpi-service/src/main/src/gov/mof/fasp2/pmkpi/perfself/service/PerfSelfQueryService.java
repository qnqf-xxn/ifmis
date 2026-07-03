package gov.mof.fasp2.pmkpi.perfself.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfself.bo.PerfSelfQueryBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfSelfQueryService extends PmkpiService {
    private PerfSelfQueryBO perfSelfQueryBO;

    public void setPerfSelfQueryBO(PerfSelfQueryBO perfSelfQueryBO) {
        this.perfSelfQueryBO = perfSelfQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("deptqfdatas", perfSelfQueryBO.getQueryFrom("/pmkpi/perfself/apply/dept"));
        config.put("proqfdatas", perfSelfQueryBO.getQueryFrom("/pmkpi/perfself/apply/index"));
        String deptcode = request.getParameter("deptcode");//数据分析大屏跳转-参数
        String busguid = request.getParameter("busguid");//数据分析大屏跳转-参数
        String divcode = request.getParameter("divcode");//数据分析大屏跳转-参数
        config.put("deptcode", deptcode);
        config.put("busguid", busguid);
        config.put("divcode", divcode);
        config.put("isNINGXIA", PerfUtil.getIsNINGXIA());
        return config;
    }

    /**
     * <p>左侧树-整合菜单首次进入页面</p >
     *
     * @author hw
     * @date 2021/7/17 16:06
     * @param
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return perfSelfQueryBO.getTreeData(params);
    }
}
