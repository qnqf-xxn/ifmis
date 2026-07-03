package gov.mof.fasp2.pmkpi.perfprogram.yearquery;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class YearProgramQueryService extends PmkpiService {

    private YearProgramQueryBO yearProgramQueryBO;

    public void setYearProgramQueryBO(YearProgramQueryBO yearProgramQueryBO) {
        this.yearProgramQueryBO = yearProgramQueryBO;
    }

    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String type = request.getParameter("type"); // 1-事前绩效评估查询；2-项目绩效目标查询
        config.put("type", type);
        return config;
    }

    /**
     * 左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> getTreeData (HashMap<String, Object> params) throws AppException {
        return yearProgramQueryBO.getTreeData(params);
    }
}
