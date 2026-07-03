package gov.mof.fasp2.pmkpi.randomComment.tab;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RandomProblemEditService extends PmkpiService {
    private RandomProblemEditBO randomProblemEditBO;

    public void setRandomProblemEditBO(RandomProblemEditBO randomProblemEditBO) {
        this.randomProblemEditBO = randomProblemEditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String tablecode = request.getParameter("tabcode");
        String projguid = request.getParameter("projguid");
        String mainguid = request.getParameter("mainguid");
        String procode = request.getParameter("procode");
        config.put("mainguid",mainguid);
        config.put("projguid",projguid);
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
        return randomProblemEditBO.getDatas(parms);
    }
    
    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        return randomProblemEditBO.savePro(parms);
    }

	
}
