package gov.mof.fasp2.pmkpi.perfpromod.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProModAuditService extends PmkpiService {

    private ProModAuditBO proModAuditBO;

    public void setProModAuditBO(ProModAuditBO proModAuditBO) {
        this.proModAuditBO = proModAuditBO;
    }
	
	public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String prolev = request.getParameter("prolev"); //项目一二三级项目
        config.put("workflow",workflow);
        config.put("prolev",prolev);
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
            backmap = proModAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

}
