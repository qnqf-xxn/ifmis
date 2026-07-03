package gov.mof.fasp2.pmkpi.doubleprocess.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class TlpProgramAuditService extends PmkpiService {

	private TlpDoublepressAuditBO tlpProgramAuditBO;

	public void setTlpProgramAuditBO(TlpDoublepressAuditBO tlpProgramAuditBO) {
		this.tlpProgramAuditBO = tlpProgramAuditBO;
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
            backmap = tlpProgramAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

    /**
     * 获取预算单位的审批流程.
     * @param parms -- 选中项目数据.
     * @return
     */
    public Map<String, Object> getBdmWfstatus(HashMap<String,Object> parms){
        return tlpProgramAuditBO.getPmWfstatus(parms);
    }

    /**
     * 校验项目库项目资金是否超过某个额度 超过绩效单独流程送至绩效处  未超过则不通过绩效处审核.
     * @param parms -- 选中项目数据.
     * @return
     */
    public Map<String, Object> checkPdmCapital(HashMap<String,Object> parms) throws AppException {
        return tlpProgramAuditBO.checkPdmCapital(parms);
    }
}
