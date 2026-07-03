package gov.mof.fasp2.pmkpi.perfprotrace.manage;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProTraceManageService extends PmkpiService {
    private ProTraceManageBO proTraceManageBO;

    public void setProTraceManageBO(ProTraceManageBO proTraceManageBO) {
        this.proTraceManageBO = proTraceManageBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("tablecode", PmkpiDAO.PMKPI_TABLE_T_TAKSSET);
        config.put("pagetype",request.getParameter("pagetype"));
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return proTraceManageBO.getData(parms);
    }

}
