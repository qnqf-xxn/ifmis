package gov.mof.fasp2.pmkpi.allseo;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProSeoService extends PmkpiService {

    private ProSeoBO proSeoBO;

    public void setProSeoBO(ProSeoBO proSeoBO) {
        this.proSeoBO = proSeoBO;
    }


    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String type = request.getParameter("type"); // 1-事前绩效评估查询；2-项目绩效目标查询
        config.put("type", type);
        return config;
    }
}
