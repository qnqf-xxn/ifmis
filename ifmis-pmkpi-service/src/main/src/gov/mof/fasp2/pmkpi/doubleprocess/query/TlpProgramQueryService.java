package gov.mof.fasp2.pmkpi.doubleprocess.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class TlpProgramQueryService extends PmkpiService {
	
	private TlpProgramQueryBO tlpProgramQueryBO;

	public void setTlpProgramQueryBO(TlpProgramQueryBO tlpProgramQueryBO) {
		this.tlpProgramQueryBO = tlpProgramQueryBO;
	}
	
	@Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return tlpProgramQueryBO.getData(parms);
    }
}
