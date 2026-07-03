package gov.mof.fasp2.pmkpi.performanceopen.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * @author zhangxutao
 * @version 1.0
 * @description: TODO
 * @date 2023/4/18 10:30
 */
public class PerfOpenAuditService extends PmkpiService {


    private PerfOpenAuditBO perfOpenAuditBO;

    /**
     * 注入bo.
     * @param perfOpenAuditBO
     */
    public void setPerfOpenAuditBO(PerfOpenAuditBO perfOpenAuditBO) {
        this.perfOpenAuditBO = perfOpenAuditBO;
    }


    @SuppressWarnings("unchecked")
    @Override
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
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfOpenAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
