package gov.mof.fasp2.pmkpi.setting.auditdefine.auditclassify.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.setting.auditdefine.auditclassify.bo.AuditClassifyBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AuditClassifyService extends PmkpiService {

	private String getBOBeanID() {
		return "pmkpi.setting.auditclassify.AuditClassifyBOTX";
	}
	
	public AuditClassifyBO getBoBean() {
		return (AuditClassifyBO) ServiceFactory.getBean(getBOBeanID());
	}

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		String tokenid = request.getParameter("tokenid");// 登录凭证
		config.put("tokenid", tokenid);
		config.put("bobeanid", this.getBOBeanID());
		return config;
	}
    
	/**
	 * 新增
	 * @param config
	 * @return
	 * @throws AppException 
	 */
	public Map infosave(HashMap config) throws AppException{
		return getBoBean().infosave(config);
	}
	
}
