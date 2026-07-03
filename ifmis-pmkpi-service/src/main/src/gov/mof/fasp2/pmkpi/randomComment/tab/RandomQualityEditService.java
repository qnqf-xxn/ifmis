package gov.mof.fasp2.pmkpi.randomComment.tab;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RandomQualityEditService extends PmkpiService {
    private RandomQualityEditBO randomQualityEditBO;

    public void setRandomQualityEditBO(RandomQualityEditBO randomQualityEditBO) {
        this.randomQualityEditBO = randomQualityEditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String tablecode = request.getParameter("tabcode");
        String bustype = request.getParameter("bustype");
        String menuid = request.getParameter("menuid");
        String procode = request.getParameter("procode");
        config.put("menuid",menuid);
        config.put("bustype",bustype);
        config.put("mainguid",mainguid);
        config.put("tablecode",tablecode);
        config.put("procode",procode);
        return config;
    }
    
    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return randomQualityEditBO.getDatas(parms);
    }
    
    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        return randomQualityEditBO.saveQual(parms);
    }
	
}
