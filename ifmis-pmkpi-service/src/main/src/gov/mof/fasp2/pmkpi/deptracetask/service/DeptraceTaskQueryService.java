package gov.mof.fasp2.pmkpi.deptracetask.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.deptracetask.bo.DeptraceTaskQueryBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptraceTaskQueryService extends PmkpiService {
    private DeptraceTaskQueryBO deptraceTaskQueryBO;

    public void setDeptraceTaskQueryBO(DeptraceTaskQueryBO deptraceTaskQueryBO) {
        this.deptraceTaskQueryBO = deptraceTaskQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptraceTaskQueryBO.getData(parms);
    }
}
