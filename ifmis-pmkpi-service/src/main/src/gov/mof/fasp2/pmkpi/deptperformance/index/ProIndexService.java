package gov.mof.fasp2.pmkpi.deptperformance.index;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

public class ProIndexService extends PmkpiService {
    private DeptIndexBO deptIndexBO;

    public void setDeptIndexBO(DeptIndexBO deptIndexBO) {
        this.deptIndexBO = deptIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String agency_code = request.getParameter("agency_code");
        config.put("agency_code", agency_code);
        config.put("indsource", PerfUtil.getSourceData("PERFINDSOURCE", ""));
        config.put("signs", PerfUtil.getSourceData("PMKPIZBXS", ""));
        return config;
    }

    /**
     * 项目指标.
     * @param parms --
     * @return --
     */
    public List<Map<String, Object>> getDatas(Map<String,Object> parms) throws AppException {
        return deptIndexBO.getProIndexs(parms);
    }
}
