package gov.mof.fasp2.pmkpi.setting.buspage.ui;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: UiEditFormService
 * @Description: Description of this class
 * @author <a href="mailto:zhongdayong@bjinfor.cn">chongdayong</a>于2021-4-12 下午05:31:45
 */
public class UiService extends PmkpiService {
	private UiSetBO uiSetBO;

	public void setUiSetBO(UiSetBO uiSetBO) {
		this.uiSetBO = uiSetBO;
	}

	@Override
	public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		super.loadComponent(request, response, config);
		String uikey = request.getParameter("uikey");
		String selectappid = request.getParameter("selectappid");
		String tablecode = request.getParameter("tablecode");
		String pageurl = (String) config.get("pageurl");
		config.put("checktabsource", uiSetBO.getCheckTabData());
		config.put("uikey", uikey);
		config.put("selectappid", selectappid);
		config.put("tablecode", tablecode);
		config.put("cols", uiSetBO.getcolumn(pageurl,"busfw_t_Uicolumn"));
		return config;
	}

	/**
	 * 获取编辑区表格数据.
	 * @param param --
	 * @return --
	 */
	public List<Map<String,Object>> getUIData(HashMap<String, Object> param) {
		return uiSetBO.getUIData(param);
	}

	/**
	 * 查询数据.
	 * @param param --
	 * @return --
	 */
	public List<Map<String, Object>> getData(HashMap<String, Object> param){
		return uiSetBO.getData(param);
	}

	/**
     * 保存方法.
     * @param param -- .
     * @return resultmap -- 回返事件
     */
    public Map<String, Object> save(HashMap<String, Object> param) {
        Map<String, Object> resultmap = new HashMap<String, Object>();
        try {
        	uiSetBO.save(param);
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
