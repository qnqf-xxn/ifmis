package gov.mof.fasp2.pmkpi.setting.question;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.HashMap;
import java.util.Map;

public class PmkpiQuestionService extends PmkpiService {
	
	private PmkpiQuestionBO pmkpiQuestionBO;

	public void setPmkpiQuestionBO(PmkpiQuestionBO pmkpiQuestionBO) {
		this.pmkpiQuestionBO = pmkpiQuestionBO;
	}
	
	/**
	 * 获取guid
	 * @return
	 * @throws AppException 
	 */
	public String getCreateguid() throws AppException{
		return pmkpiQuestionBO.getCreateguid();
	}
	
	public Map<String, Object> getTableTree(String wfid){
		return pmkpiQuestionBO.getTableTree(wfid);
	}
	
	/**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
        	pmkpiQuestionBO.tablesave(params);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
    
    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return pmkpiQuestionBO.getData(parms);
    }
	
}
