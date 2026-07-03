package gov.mof.fasp2.pmkpi.prorevision.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProrevisionAuditService extends PmkpiService {
    private ProrevisionAuditBO revisionAuditBO;

    public void setRevisionAuditBO(ProrevisionAuditBO revisionAuditBO) {
        this.revisionAuditBO = revisionAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("deptqfdatas", revisionAuditBO.getQueryFrom("/pmkpi/prorevision/report/dept"));
        config.put("proqfdatas", revisionAuditBO.getQueryFrom("/pmkpi/prorevision/report/program"));
        config.put("auditrevision", ProrevisionAuditDAO.PERF_STRING_REVISION);
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return revisionAuditBO.getTreeData(params);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        try {
            backmap = revisionAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code",e.getCode());
        } catch (AppException e) {
            backmap.put("msg", e.getCode() + e.getMessage().replace(e.getCode(), ""));
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

}
