package gov.mof.fasp2.pmkpi.doubleprocess.jxaudit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TlpJxAuditService extends PmkpiService {

    private TlpJxAuditBO tlpJxAuditBO;

    public void setTlpJxAuditBO(TlpJxAuditBO tlpJxAuditBO) {
        this.tlpJxAuditBO = tlpJxAuditBO;
    }

	public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        config.put("workflow",workflow);
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
            backmap = tlpJxAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

    /**
     * 根据项目id查询项目信息
     * @param params --
     * @return --
     */
    public List<Map<String,Object>> getProInfo(HashMap<String,Object> params) {
        List<Map<String,Object>> list = tlpJxAuditBO.getProInfo(params);
        return list;
    }

}
