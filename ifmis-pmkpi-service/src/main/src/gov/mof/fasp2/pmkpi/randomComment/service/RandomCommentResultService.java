package gov.mof.fasp2.pmkpi.randomComment.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.randomComment.bo.RandomCommentResultBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RandomCommentResultService extends PmkpiService {
	private RandomCommentResultBO randomCommentResultBO;

	public void setRandomCommentResultBO(
			RandomCommentResultBO randomCommentResultBO) {
		this.randomCommentResultBO = randomCommentResultBO;
	}

	@Override
	public Map loadComponent(HttpServletRequest request,
			HttpServletResponse response, Map config) throws Exception {
		super.loadComponent(request, response, config);
		String pagetype = request.getParameter("pagetype");
		String workflow = request.getParameter("workflow");
		String tablecode = request.getParameter("tablecode");
		String tabcode = request.getParameter("tabcode");
		config.put("tabcode", tabcode);
		config.put("pagetype", pagetype);
		config.put("workflow", workflow);
		config.put("tablecode", tablecode);
		config.put("tempatecode", request.getParameter("tempatecode"));
		config.put("deptqfdatas", randomCommentResultBO.getQueryFrom("/pmkpi/randomcomment/result/dept"));
		config.put("proqfdatas", randomCommentResultBO.getQueryFrom("/pmkpi/randomcomment/result/index"));
		return config;
	}

	/**
	 * @Title: submit
	 * @Description: TODO(提交)
	 * @param config
	 * @return
	 * @throws AppException
	 */
	public Map<String, Object> submit(HashMap<String, Object> config)
			throws AppException {
		Map<String, Object> rs = new HashMap<String, Object>();
		try {
			rs = randomCommentResultBO.submit(config);
		} catch (PerfAppException e) {
			rs = e.getRemap();
			rs.put("code", e.getCode());
		} catch (AppException e) {
			logger.error(e.getMessage(), e);
		}
		return rs;
	}
	
	public Map<String, Object> expFile(HashMap<String, Object> config)
			throws AppException {
		Map<String, Object> rs = new HashMap<String, Object>();
		try {
			rs = randomCommentResultBO.submit(config);
		} catch (PerfAppException e) {
			rs = e.getRemap();
			rs.put("code", e.getCode());
		} catch (AppException e) {
			logger.error(e.getMessage(), e);
		}
		return rs;
	}

	/**
	 * <p>左侧树</p >
	 *
	 * @author
	 */
	public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
		return randomCommentResultBO.getTreeData(params);
	}

}
