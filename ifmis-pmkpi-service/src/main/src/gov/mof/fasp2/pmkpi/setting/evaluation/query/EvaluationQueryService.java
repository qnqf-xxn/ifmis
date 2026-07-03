package gov.mof.fasp2.pmkpi.setting.evaluation.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EvaluationQueryService extends PmkpiService {
    private EvaluationQueryBO evaluationQueryBO;

    public void setEvaluationQueryBO(EvaluationQueryBO evaluationQueryBO){
        this.evaluationQueryBO = evaluationQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return evaluationQueryBO.getTreeData(params);
    }


    public String getDataGuid (HashMap<String, Object> params) throws AppException {
        return evaluationQueryBO.getDataGuid(params);
    }

}
