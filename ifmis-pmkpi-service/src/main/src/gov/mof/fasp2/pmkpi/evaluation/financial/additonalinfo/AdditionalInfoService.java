package gov.mof.fasp2.pmkpi.evaluation.financial.additonalinfo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AdditionalInfoService extends PmkpiService {
    private AdditionalInfoBO additionalInfoBO;

    public void setAdditionalInfoBO(AdditionalInfoBO additionalInfoBO) {
        this.additionalInfoBO = additionalInfoBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String proguid = request.getParameter("proguid");
        String procode = request.getParameter("procode");
        String viewtype = request.getParameter("viewtype");
        String busguid = request.getParameter("busguid");
        config.put("mainguid", mainguid);
        config.put("proguid", proguid);
        config.put("procode", procode);
        config.put("viewtype", viewtype);
        config.put("busguid", busguid);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return additionalInfoBO.getData(parms);
    }
    
    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        return additionalInfoBO.save(parms);
    }

}
