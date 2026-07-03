package gov.mof.fasp2.pmkpi.deptoverallmerit.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.deptoverallmerit.bo.DeptOverallMeritQueryBO;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeptOverallMeritQueryService extends PmkpiService {
    private DeptOverallMeritQueryBO deptOverallMeritQueryBO;

    public void setDeptOverallMeritQueryBO(DeptOverallMeritQueryBO deptOverallMeritQueryBO) {
        this.deptOverallMeritQueryBO = deptOverallMeritQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String tablecode = request.getParameter("tablecode");
        String querytype = request.getParameter("querytype");
        config.put("workflow", workflow);
        config.put("tablecode", tablecode);
        config.put("querytype", querytype);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptOverallMeritQueryBO.getData(parms);
    }

}
