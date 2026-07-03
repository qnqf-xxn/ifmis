package gov.mof.fasp2.pmkpi.projapplyjs.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.projapplyjs.bo.DeptPerfBudgetBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptPerfBudgetService extends PmkpiService {
    private DeptPerfBudgetBO deptPerfBudgetBO;

    public void setDeptPerfBudgetBO(DeptPerfBudgetBO deptPerfBudgetBO) {
        this.deptPerfBudgetBO = deptPerfBudgetBO;
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
        return deptPerfBudgetBO.getData(parms);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        return deptPerfBudgetBO.save(parms);
    }
}
