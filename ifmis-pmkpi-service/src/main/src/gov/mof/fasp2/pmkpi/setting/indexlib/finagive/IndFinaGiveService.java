package gov.mof.fasp2.pmkpi.setting.indexlib.finagive;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IndFinaGiveService extends PmkpiService {

    private IndFinaGiveBO indFinaGiveBO;

    public void setIndFinaGiveBO(IndFinaGiveBO indFinaGiveBO) {
        this.indFinaGiveBO = indFinaGiveBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String menutype = request.getParameter("menutype");
        config.put("menutype",menutype);

        return config;
    }
}
