package gov.mof.fasp2.pmkpi.setting.fund;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

public class FundtempSetPage extends PmkpiPage {

	public Map<String,Object> index(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException{
		String menuId = request.getParameter("menuId");
		this.getHeadTitle(config, menuId);
		return config;
	}
}
