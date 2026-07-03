package gov.mof.fasp2.pmkpi.evaluateTemp.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.evaluateTemp.bo.EvaluateTempBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class EvaluateTempService extends PmkpiService {

	private EvaluateTempBO evaluateTempBO;

	public void setEvaluateTempBO(EvaluateTempBO evaluateTempBO) {
		this.evaluateTempBO = evaluateTempBO;
	}

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		String tokenid = request.getParameter("tokenid");// 登录凭证
		config.put("tokenid", tokenid);
		return config;
	}

	/**
	 * 查询数据.
	 * @param parms --
	 * @return --
	 */
	public Map<String, Object> getData(HashMap<String,Object> parms) throws AppException {
		return evaluateTempBO.getData(parms);
	}

	/**
	 * 删除
	 * @param parms --
	 * @return
	 */
	public Map<String, Object> deldatas(HashMap<String,Object> parms) throws AppException {
		return evaluateTempBO.deldatas(parms);
	}
}
