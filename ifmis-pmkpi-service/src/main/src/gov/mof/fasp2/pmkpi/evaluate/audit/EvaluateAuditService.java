package gov.mof.fasp2.pmkpi.evaluate.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class EvaluateAuditService extends PmkpiService {

    private EvaluateAuditBO evaluateAuditBO;

    @Resource(name="pmkpi.evaluate.EvaluateAuditBOTX")
    public void setEvaluateAuditBO(EvaluateAuditBO evaluateAuditBO) {
        this.evaluateAuditBO = evaluateAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String isfileshow = request.getParameter("isfileshow");
        config.put("isfileshow", isfileshow);
        String mainguid = request.getParameter("mainguid");
        config.put("data", evaluateAuditBO.getDataById(mainguid));
        config.put("filedatas", evaluateAuditBO.getFile(mainguid));
        config.put("audittype",evaluateAuditBO.getAudittypeDatas());
        return config;
    }

    /**
     * 保存
     * @param params
     * @return
     */
    public Map<String,Object> saveDatas (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = evaluateAuditBO.saveDatas(params);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs.put("success", false);
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;

    }
}
