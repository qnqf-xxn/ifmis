package gov.mof.fasp2.pmkpi.projapplyjs.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.projapplyjs.bo.DeptPerfFunctionBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptPerfFunctionService extends PmkpiService {
    private DeptPerfFunctionBO deptPerfFunctionBO;

    public void setDeptPerfFunctionBO(DeptPerfFunctionBO deptPerfFunctionBO) {
        this.deptPerfFunctionBO = deptPerfFunctionBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String projguid = request.getParameter("projguid");
        String viewtype = request.getParameter("viewtype");
        config.put("mainguid", mainguid);
        config.put("projguid", projguid);
        config.put("viewtype", viewtype);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptPerfFunctionBO.getData(parms);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        return deptPerfFunctionBO.save(parms);
    }

    /**
     * 清空对应项目.
     * @param parms --
     * @return --
     */
    public Map<String, Object> clearproject(HashMap<String,Object> parms) throws AppException {
        return deptPerfFunctionBO.clearproject(parms);
    }
}
