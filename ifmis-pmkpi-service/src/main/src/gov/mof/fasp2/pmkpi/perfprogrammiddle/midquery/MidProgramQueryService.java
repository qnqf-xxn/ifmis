package gov.mof.fasp2.pmkpi.perfprogrammiddle.midquery;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class MidProgramQueryService extends PmkpiService {
	
	private MidProgramQueryBO midProgramQueryBO;

	public void setMidProgramQueryBO(MidProgramQueryBO midProgramQueryBO) {
		this.midProgramQueryBO = midProgramQueryBO;
	}
	
	@Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }
}
