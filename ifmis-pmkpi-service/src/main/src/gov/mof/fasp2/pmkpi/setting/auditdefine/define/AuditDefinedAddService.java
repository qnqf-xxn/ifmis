package gov.mof.fasp2.pmkpi.setting.auditdefine.define;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AuditDefinedAddService extends PmkpiService {

	private AuditDefinedBO auditDefinedBO;

    public void setAuditDefinedBO(AuditDefinedBO auditDefinedBO) {
        this.auditDefinedBO = auditDefinedBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		String tokenid = request.getParameter("tokenid");// 登录凭证
        String tabcode = request.getParameter("tabcode");
		config.put("tokenid", tokenid);
        config.put("tabcode", tabcode);
        String guid = request.getParameter("guid");
        if(guid != null && !guid.isEmpty()){
        	config.put("auditdefined", auditDefinedBO.getByGuid(AuditDefinedDAO.TABLE_CODE, guid));
        }
		return config;
	}
    
    
    /**
     * 审核属性保存
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        return auditDefinedBO.save(parms);
    }

}
