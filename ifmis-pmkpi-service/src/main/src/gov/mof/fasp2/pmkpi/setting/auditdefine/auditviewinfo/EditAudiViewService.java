package gov.mof.fasp2.pmkpi.setting.auditdefine.auditviewinfo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class EditAudiViewService  extends PmkpiService {
	private AuditViewInfoBO auditViewInfoBO;

    public void setAuditViewInfoBO(AuditViewInfoBO auditViewInfoBO) {
        this.auditViewInfoBO = auditViewInfoBO;
    }
        
	    @Override
	    @SuppressWarnings({"rawtypes", "unchecked" })
	    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
			String guid = request.getParameter("guid");
			Map<String, Object> map=new HashMap();
			if(!StringUtils.isEmpty(guid)){
				map=auditViewInfoBO.getEditData(guid);
			}
			config.put("editAudi", map);
			return config;
		}

	    /**
	     * 视图校验
	     * @param parms --
	     * @return --
	     */
	    
	    public Map<String, Object> checkSql(HashMap<String,Object> parms) throws AppException {
	        return auditViewInfoBO.checksql(parms);
	    }
	    
	    /**
	     * 视图保存
	     * @param parms --
	     * @return --
	     */
	    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
	        return auditViewInfoBO.save(parms);
	    }
	    
	    
}
