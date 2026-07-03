package gov.mof.fasp2.pmkpi.workevaluate.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WorkEvaluateQueryService extends PmkpiService {
    private WorkEvaluateQueryBO workEvaluateQueryBO;

    public void setWorkEvaluateQueryBO(WorkEvaluateQueryBO workEvaluateQueryBO) {
        this.workEvaluateQueryBO = workEvaluateQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String provincescoretype = request.getParameter("provincescoretype");
        String deptscoretype = request.getParameter("deptscoretype");
        config.put("deptscoretype", deptscoretype);
        config.put("provincescoretype", provincescoretype);
        return config;
    }

    /**
     * 数据查询.
     * @param params--
     * @return --
     */
    public List<Map<String, Object>> getDatas(HashMap<String, Object> params) throws AppException {
        return workEvaluateQueryBO.getDatas(params);
    }

    /**
     * 查询左侧树
     * @param params ---
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return workEvaluateQueryBO.getTreeData(params);
    }

    /**
     * 获取任务guid
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTaskguid (HashMap<String, Object> params) throws AppException {
        return workEvaluateQueryBO.getTaskguid(params);
    }
}
