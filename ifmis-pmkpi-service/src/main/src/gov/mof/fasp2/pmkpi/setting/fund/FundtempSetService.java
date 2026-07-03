package gov.mof.fasp2.pmkpi.setting.fund;

import java.util.HashMap;
import java.util.Map;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

public class FundtempSetService extends PmkpiService {

	private FundtempSetBO fundtempSetBO;

	public void setFundtempSetBO(FundtempSetBO fundtempSetBO) {
		this.fundtempSetBO = fundtempSetBO;
	}
	
	/**
	 * 查询
	 * @return
	 */
	public Map<String,Object> getFundData(){
		return fundtempSetBO.getFundData();
	}
	
	/**
	 * 保存
	 * @param params
	 */
	public Map<String, Object> save(Map<String, Object> params){
		Map<String, Object> remp = new HashMap<String, Object>();
		try{
			fundtempSetBO.save(params);
			remp.put("success", true);
		} catch (PerfAppException e){
			remp = e.getRemap();
			remp.put("code", e.getCode());
		} catch(AppException e){
			logger.error(e.getMessage(), e);
		}
		return remp;
	}
	
	/**
	 * 获取guid
	 * @return
	 */
	public String getCreateguid(){
		return fundtempSetBO.getCreateguid();
	}
	
}
