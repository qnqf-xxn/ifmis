package gov.mof.fasp2.pmkpi.setting.expdoc.temp;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName: UiEditFormService
 * @Description: Description of this class
 * @author <a href="mailto:zhongdayong@bjinfor.cn">chongdayong</a>于2021-4-12 下午05:31:45
 */
public class ExpdocTempService extends PmkpiService {
	private ExpdocTempBO expdocTempBO;

	public void setExpdocTempBO(ExpdocTempBO expdocTempBO) {
		this.expdocTempBO = expdocTempBO;
	}

	@Override
	public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		super.loadComponent(request, response, config);
		String maintablecode = "v_perf_t_expdocmain";
		String mainguid = request.getParameter("mainguid");
		String tempatecode = request.getParameter("tempatecode");
		String pagetype = request.getParameter("pagetype");
		config.put("maintablecode",maintablecode);
		config.put("pagetype", pagetype);
		if ("mod".equals(pagetype) || "query".equals(pagetype)) {
			String wheresql = "";
			String[] strs = null;
			if ("mod".equals(pagetype)) {
				wheresql = " guid=?";
				strs = new String[]{mainguid};
			} else {
				wheresql = "templatecode=?";
				strs = new String[]{tempatecode};
			}
			Map<String, Object> map = expdocTempBO.getDataMap(maintablecode, wheresql, strs);
			mainguid = (String) map.get("guid");
			config.put("expdata", map);
		}
		config.put("mainguid",mainguid);
		return config;
	}

	/**
     * 保存方法.
     * @param param -- .
     * @return resultmap -- 回返事件
     */
    public Map<String, Object> save(HashMap<String, Object> param) {
        Map<String, Object> resultmap = new HashMap<String, Object>();
        try {
			expdocTempBO.save(param);
			resultmap.put("success", true);
			resultmap.put("code","保存成功！");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
			resultmap.put("success", "false");
			resultmap.put("code",e.getCode());
        }
        return resultmap;
    }
}
