package gov.mof.fasp2.pmkpi.prorevision.empower;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProrevisionPowerService extends PmkpiService {
    private ProrevisionPowerBO revisionPowerBO;

    public void setRevisionPowerBO(ProrevisionPowerBO revisionPowerBO) {
        this.revisionPowerBO = revisionPowerBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }
    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> revisionpower(HashMap<String,Object> parms){
        return revisionPowerBO.revisionpower(parms);
    }

}
