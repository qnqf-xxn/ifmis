package gov.mof.fasp2.pmkpi.adjust.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdjustAuditService extends PmkpiService {
    private AdjustAuditBO adjustAuditBO;

    public void setAdjustAuditBO(AdjustAuditBO adjustAuditBO) {
        this.adjustAuditBO = adjustAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("deptqfdatas", adjustAuditBO.getQueryFrom("/pmkpi/adjust/report/dept"));
        config.put("proqfdatas", adjustAuditBO.getQueryFrom("/pmkpi/adjust/report/program"));
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return adjustAuditBO.getTreeData(params);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        try {
            backmap = adjustAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code",e.getCode());
        } catch (AppException e) {
            backmap.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

}
