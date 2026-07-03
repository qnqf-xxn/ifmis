package gov.mof.fasp2.pmkpi.deptTJformance.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptTJPerfQueryService extends PmkpiService {
    /**
     * deptPerfBO.
     */
    private DeptTJPerfQueryBO deptTJPerfQueryBO ;

    /**
     * 注入bo.
     * @param deptTJPerfQueryBO
     */
    public void setDeptTJPerfQueryBO(DeptTJPerfQueryBO deptTJPerfQueryBO) {
        this.deptTJPerfQueryBO = deptTJPerfQueryBO;
    }
    

    @SuppressWarnings("unchecked")
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }

    public Map<String, Object> getExpDatas(HashMap<String,Object> parms) throws AppException {
        return deptTJPerfQueryBO.getExpDatas(parms);
    }
}
