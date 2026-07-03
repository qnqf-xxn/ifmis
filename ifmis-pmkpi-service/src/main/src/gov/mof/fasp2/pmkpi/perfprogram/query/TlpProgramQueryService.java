package gov.mof.fasp2.pmkpi.perfprogram.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TlpProgramQueryService extends PmkpiService {

    private TlpProgramQueryBO tlpProgramQueryBO;

    public void setTlpProgramQueryBO(TlpProgramQueryBO tlpProgramQueryBO) {
        this.tlpProgramQueryBO = tlpProgramQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String type = request.getParameter("type"); // 1-事前绩效评估查询；2-项目绩效目标查询
        config.put("type", type);
        config.put("prolev", request.getParameter("prolev"));//项目级次
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return tlpProgramQueryBO.getTreeData(params);
    }

}
