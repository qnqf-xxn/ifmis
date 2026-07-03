package gov.mof.fasp2.pmkpi.evaluateTemp.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.evaluateTemp.bo.EvaluateTempBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EvaluateTempAddService extends PmkpiService {

	private EvaluateTempBO evaluateTempBO;

	public void setEvaluateTempBO(EvaluateTempBO evaluateTempBO) {
		this.evaluateTempBO = evaluateTempBO;
	}

	//评价类型表
	private final String tablecode = "PERF_T_RANDOMQUALITY_TYPE";
	//评价模板菜单关联表
	private final String evalTempMenuTable = "PERF_T_RANDOMQUALITY_MENU";

	@Override
	public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		String tokenid = request.getParameter("tokenid");// 登录凭证
		String tabcode = request.getParameter("tabcode");
		String mainguid = request.getParameter("mainguid");
		String viewtype = request.getParameter("viewtype");

		//String guid = request.getParameter("guid");
		config.put("tokenid", tokenid);
		config.put("tabcode", tabcode);
		config.put("mainguid", mainguid);
		config.put("viewtype", viewtype);
		if(!StringUtils.isEmpty(mainguid)){
			Map map = evaluateTempBO.getByGuid(tablecode,mainguid);
			if (map!=null &&map.size()>0){
				String code = (String) map.get("code");
				List<Map> menuDatas = evaluateTempBO.getDateByCode(code,evalTempMenuTable);
				StringBuffer menuids = new StringBuffer();
				if (null!= menuDatas && menuDatas.size() > 0){
					for (int i=0;i<menuDatas.size();i++) {
						Map data = menuDatas.get(i);
						String menuid = (String) data.get("menuid");
						if (menuids.length() > 0) {
							menuids.append(",");
						}
						menuids.append(menuid);
					}
				}
				map.put("menuid",menuids.toString());
			}
			config.put("evaluateTemp", map);
		}
		return config;
	}


	public Map getByGuid(HashMap<String,Object> parms) {
		String guid = (String) parms.get("guid");
		Map map = evaluateTempBO.getByGuid(tablecode,guid);
		return  map;
	}

	/**
	 * 编辑区保存
	 * @param config --
	 * @return
	 * @throws AppException
	 */
	public Map infosave(HashMap config) {
		Map<String, Object> rs = new HashMap<String, Object>();
		try {
			rs = evaluateTempBO.infosave(config);
		} catch (PerfAppException e) {
			rs = e.getRemap();
			rs.put("code",e.getCode());
		} catch (AppException e) {
			logger.error(e.getMessage(), e);
		}
		return rs;
	}
}