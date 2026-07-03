package gov.mof.fasp2.pmkpi.deptZJformance.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptPerfAuditService extends PmkpiService {

    private DeptPerfAuditBO deptPerfAuditBO;

    public void setDeptPerfAuditBO(DeptPerfAuditBO deptPerfAuditBO) {
        this.deptPerfAuditBO = deptPerfAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        config.put("workflow",workflow);
        return config;
    }
    
    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
	public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptPerfAuditBO.getData(parms);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        try {
            backmap = deptPerfAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

}
