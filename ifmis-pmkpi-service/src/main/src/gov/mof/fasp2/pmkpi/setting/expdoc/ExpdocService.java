package gov.mof.fasp2.pmkpi.setting.expdoc;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName: BusAppendService
 * @Description: Description of this class
 * @author <a href="mailto:zhongdayong@bjinfor.cn">chongdayong</a>于2021-4-12 下午04:10:41
 */
public class ExpdocService extends PmkpiService {
	private ExpdocBO expdocBO;

	public void setExpdocBO(ExpdocBO expdocBO) {
		this.expdocBO = expdocBO;
	}

	@Override
	public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		super.loadComponent(request, response, config);
		return config;
	}

	/**
	 * 删除
	 * @param parms --
	 * @return
	 */
	public Map<String, Object> del(HashMap<String,Object> parms){
		return expdocBO.del(parms);
	}


}
