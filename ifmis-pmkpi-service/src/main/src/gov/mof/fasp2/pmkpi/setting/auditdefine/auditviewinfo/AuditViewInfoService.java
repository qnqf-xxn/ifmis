package gov.mof.fasp2.pmkpi.setting.auditdefine.auditviewinfo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.HashMap;
import java.util.Map;

public class AuditViewInfoService  extends PmkpiService {
	 private AuditViewInfoBO auditViewInfoBO;

	    public void setAuditViewInfoBO(AuditViewInfoBO auditViewInfoBO) {
	        this.auditViewInfoBO = auditViewInfoBO;
	    }
	    
	    
	    /**
	     * 查询数据.
	     * @param parms --
	     * @return --
	     */
	    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
	        return auditViewInfoBO.getData(parms);
	    }
	    
	    /**
	     * 删除数据.
	     * @param parms --
	     * @return --
	     */
	    public Map<String, Object> delDatas(HashMap<String,Object> parms) throws AppException {
	        return auditViewInfoBO.delData(parms);
	    }
	    
	    
	    
}
