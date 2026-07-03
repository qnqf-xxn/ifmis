package gov.mof.fasp2.pmkpi.evaluateTemp.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.evaluateTemp.bo.EvaluateTempInfoBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class EvaluateTempInfoService extends PmkpiService {

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
		config.put("tokenid", tokenid);
		config.put("tabcode", tabcode);
		config.put("mainguid", mainguid);
		String guid = request.getParameter("guid");
		if(!StringUtils.isEmpty(guid)){
			config.put("evaluateTemp", evaluateTempInfoBO.getByGuid(tablecode,guid));
		}
		return config;

	}

	/**
	 * 查询数据.
	 * @param parms --
	 * @return --
	 */
	public Map<String, Object> getData(HashMap<String,Object> parms) throws AppException {
		return evaluateTempInfoBO.getData(parms);
	}

	/**
	 * 保存.
	 * @param parms --
	 * @return --
	 */
	public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
		Map<String, Object> rs = new HashMap<String, Object>();
		try {
			rs = evaluateTempInfoBO.save(parms);
		} catch (PerfAppException e) {
			rs = e.getRemap();
			rs.put("code",e.getCode());
		} catch (AppException e) {
			logger.error(e.getMessage(), e);
		}
		return rs;
	}
}