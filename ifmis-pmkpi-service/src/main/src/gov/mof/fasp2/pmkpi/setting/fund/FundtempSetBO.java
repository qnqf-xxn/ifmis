package gov.mof.fasp2.pmkpi.setting.fund;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

public class FundtempSetBO extends PmkpiBO{
	
	private FundtempSetDAO fundtempSetDAO;

	public void setFundtempSetDAO(FundtempSetDAO fundtempSetDAO) {
		this.fundtempSetDAO = fundtempSetDAO;
	}

	/**
	 * 查询
	 * @return
	 */
	public Map<String, Object> getFundData() {
		Map<String, Object> backMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = fundtempSetDAO.getFundData();
		backMap.put("data", list);
		return backMap;
	}

	/**
	 * 保存
	 * @param params
	 * @throws AppException 
	 */
	@SuppressWarnings("unchecked")
	public void save(Map<String, Object> params) throws AppException {
		List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
		String tablecode = "PERF_T_FUNDTEMP";
		int i = 1;
		String flag = (String) datas.get(0).get("name");
        for (Map<String, Object> map : datas) {
        	String name = (String) map.get("name");
        	if(!flag.equals(name)){
        		i=i+1;
        	}
        	map.put("ordernum", i);
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            map.put("createtime", CommonUtil.getTimeStamp());
            flag = (String) map.get("name");
        }
        fundtempSetDAO.delDatas(tablecode, "");
        fundtempSetDAO.saveAll(datas, tablecode);
	}
	

}
