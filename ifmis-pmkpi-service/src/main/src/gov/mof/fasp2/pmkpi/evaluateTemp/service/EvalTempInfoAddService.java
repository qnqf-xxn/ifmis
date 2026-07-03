package gov.mof.fasp2.pmkpi.evaluateTemp.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.evaluateTemp.bo.EvaluateTempInfoBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class EvalTempInfoAddService extends PmkpiService {

	private EvaluateTempInfoBO evaluateTempInfoBO;

	public void setEvaluateTempInfoBO(EvaluateTempInfoBO evaluateTempInfoBO) {
		this.evaluateTempInfoBO = evaluateTempInfoBO;
	}
	//评价模板表
	private final String tablecode = "PERF_T_RANDOMQUALITY";

	@Override
	public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		String tokenid = request.getParameter("tokenid");// 登录凭证
		String tabcode = request.getParameter("tabcode");
		String mainguid = request.getParameter("mainguid");
		String guid = request.getParameter("guid");
		config.put("tokenid", tokenid);
		config.put("tabcode", tabcode);
		config.put("mainguid", mainguid);
		config.put("guid", guid);
		return config;
	}


	public Map getByGuid(HashMap<String,Object> parms) {
		String guid = (String) parms.get("guid");
		Map map = evaluateTempInfoBO.getByGuid(tablecode,guid);
		return  map;
	}

	/**
	 * 评价模板新增(新增一级)
	 * @param config --
	 * @return
	 * @throws AppException
	 */
	public Map infosave(HashMap config) {
		Map<String, Object> rs = new HashMap<String, Object>();
		try {
			rs = evaluateTempInfoBO.infosave(config);
		} catch (PerfAppException e) {
			rs = e.getRemap();
			rs.put("code",e.getCode());
		} catch (AppException e) {
			logger.error(e.getMessage(), e);
		}
		return rs;
	}
}