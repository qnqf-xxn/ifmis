package gov.mof.fasp2.pmkpi.deptZJformanceadjust.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeptPerfQueryService extends PmkpiService {

    private DeptPerfQueryBO deptPerfQueryBO;

    public void setDeptPerfQueryBO(DeptPerfQueryBO deptPerfQueryBO) {
        this.deptPerfQueryBO = deptPerfQueryBO;
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
        return deptPerfQueryBO.getData(parms);
    }
}
