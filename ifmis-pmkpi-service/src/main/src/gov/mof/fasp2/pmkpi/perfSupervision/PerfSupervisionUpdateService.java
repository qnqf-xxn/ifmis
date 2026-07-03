package gov.mof.fasp2.pmkpi.perfSupervision;

import gov.mof.fasp2.buscore.framework.component.AbstractComponentService;
import gov.mof.fasp2.buscore.framework.exception.AppException;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PerfSupervisionUpdateService extends AbstractComponentService {

	private PerfSupervisionUpdateBo perfSupervisionUpdateBo;

	public void setPerfSupervisionUpdateBO(PerfSupervisionUpdateBo perfSupervisionUpdateBo) {
		this.perfSupervisionUpdateBo = perfSupervisionUpdateBo;
	}
	
	
	@Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String[] guids = request.getParameterValues("guids");// guids
        config.put("guids", guids);
		return config;
	}
	
	public Map save(HashMap config) throws AppException{
		return perfSupervisionUpdateBo.save(config);
	}
	
}
