package gov.mof.fasp2.pmkpi.setting.buspage;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: BusAppendService
 * @Description: Description of this class
 * @author <a href="mailto:zhongdayong@bjinfor.cn">chongdayong</a>于2021-4-12 下午04:10:41
 */
public class BusAppendService extends PmkpiService {
	private BusAppendBO busAppendBO;

	public void setBusAppendBO(BusAppendBO busAppendBO) {
		this.busAppendBO = busAppendBO;
	}

	@Override
	public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		super.loadComponent(request, response, config);
		return config;
	}

	/**
	 * 获取列表数据.
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> getData(HashMap<String, Object> param){
		return busAppendBO.getData(param);
	}

	/**
	 * 获取列表数据.
	 * @return
	 */
	public List<Map<String, Object>> getMenuTree(){
		return busAppendBO.getTreeData();
	}

	/**
	 * 保存.
	 * @param parms --
	 * @return --
	 */
	public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
		Map<String, Object> rs = new HashMap<String, Object>();
		try {
			busAppendBO.save(parms);
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
	 * 删除
	 * @param parms --
	 * @return
	 */
	public Map<String, Object> del(HashMap<String,Object> parms){
		return busAppendBO.del(parms);
	}


}
