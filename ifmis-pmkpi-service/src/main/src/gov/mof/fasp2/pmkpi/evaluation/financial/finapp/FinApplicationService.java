package gov.mof.fasp2.pmkpi.evaluation.financial.finapp;


import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Map;

public class FinApplicationService extends PmkpiService {

    private FinApplicationBO finApplicationBO;

    public void setFinApplicationBO(FinApplicationBO finApplicationBO) {
        this.finApplicationBO = finApplicationBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String bustype = request.getParameter("bustype");
        String saveAgency = request.getParameter("saveAgency");
        config.put("mainguid", mainguid);
        config.put("bustype", bustype);
        config.put("saveAgency", saveAgency);

        return config;
    }

}