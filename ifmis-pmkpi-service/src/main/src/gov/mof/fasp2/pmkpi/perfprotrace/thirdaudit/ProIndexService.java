package gov.mof.fasp2.pmkpi.perfprotrace.thirdaudit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProIndexService extends PmkpiService {

    private ProTraceThirdAuditBO proTraceThirdAuditBO;

    public void setProTraceThirdAuditBO(ProTraceThirdAuditBO proTraceThirdAuditBO) {
        this.proTraceThirdAuditBO = proTraceThirdAuditBO;
    }

    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String procode = request.getParameter("procode");
        String mainguid = request.getParameter("mainguid");
        config.put("procode", procode);
        config.put("mainguid", mainguid);
        return config;
    }

    /**
     * 查询数据.
     *
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String, Object> parms) throws AppException {
        return proTraceThirdAuditBO.getData(parms);
    }

}
