package gov.mof.fasp2.pmkpi.evaluation.financial.word;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

public class FinWordService   extends PmkpiService {
    private FinWordBO FinWordBO;


    public void setFinWordBO(FinWordBO FinWordBO) {
        this.FinWordBO = FinWordBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String mainguid = request.getParameter("mainguid");
        String proguid = request.getParameter("proguid");
        String procode = request.getParameter("procode");
        String bustype = request.getParameter("bustype");
        String type = request.getParameter("type");  //项目编码
        config.put("bustype",bustype);
        config.put("proguid", proguid);
        config.put("procode", procode);
        config.put("type", type);
        config.put("mainguid",mainguid);
        return config;

    }

    public Map save(HashMap config) throws AppException, ParseException {
        return FinWordBO.save(config);
    }

    public Map getText(Map config) throws AppException{
        Map configMap = FinWordBO.getText(config);
        return configMap;
    }

}
