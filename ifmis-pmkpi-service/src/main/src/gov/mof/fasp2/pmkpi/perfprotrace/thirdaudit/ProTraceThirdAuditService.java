package gov.mof.fasp2.pmkpi.perfprotrace.thirdaudit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProTraceThirdAuditService extends PmkpiService {

    private ProTraceThirdAuditBO proTraceThirdAuditBO;

    public void setProTraceThirdAuditBO(ProTraceThirdAuditBO proTraceThirdAuditBO) {
        this.proTraceThirdAuditBO = proTraceThirdAuditBO;
    }

    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String prolev = request.getParameter("prolev");
        config.put("prolev", prolev);
        return config;
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        try {
            backmap = proTraceThirdAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code",e.getCode());
        } catch (AppException e) {
            backmap.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return proTraceThirdAuditBO.getTreeData(params);
    }

    /**
     * 2.2.查询重点绩效监控项目成果
     * 3.2.查询财政重点评价项目成果
     * @param params
     * @throws Exception
     */
    public Map<String, Object> getResult (HashMap<String, Object> params) throws Exception {
        return proTraceThirdAuditBO.getProTraceEvalResult(params);
    }


}
