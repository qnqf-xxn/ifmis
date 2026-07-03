package gov.mof.fasp2.pmkpi.perfpromod.query;

import java.util.Map;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProModQyService extends PmkpiService {

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
	    String prolev = request.getParameter("prolev"); //项目一二三级项目
        config.put("prolev",prolev);
	    return config;
    }
}
