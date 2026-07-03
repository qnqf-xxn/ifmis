package gov.mof.fasp2.pmkpi.workevaluate.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WorkEvaluateAuditService extends PmkpiService {
    private WorkEvaluateAuditBO workEvaluateAuditBO;

    public void setWorkEvaluateAuditBO(WorkEvaluateAuditBO workEvaluateAuditBO) {
        this.workEvaluateAuditBO = workEvaluateAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String provincescoretype = request.getParameter("provincescoretype");
        config.put("provincescoretype", provincescoretype);
        return config;
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = workEvaluateAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询左侧树
     * @param params ---
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return workEvaluateAuditBO.getTreeData(params);
    }
}
