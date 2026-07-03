package gov.mof.fasp2.pmkpi.setting.evaluation.proaudit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProEvaluationAuditService extends PmkpiService {
    private ProEvaluationAuditBO proEvaluationAuditBO;

    public void setProEvaluationAuditBO(ProEvaluationAuditBO proEvaluationAuditBO){
        this.proEvaluationAuditBO = proEvaluationAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }

    /**
     * 查询项目信息
     * @param params --
     * @return
     */
    public Map<String, Object> getEditInfo(HashMap<String, Object> params) {
        return proEvaluationAuditBO.getEditInfo(params);
    }

    /**
     * 保存
     * @param params
     * @return
     */
    public Map<String, Object> save(HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = proEvaluationAuditBO.save(params);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
