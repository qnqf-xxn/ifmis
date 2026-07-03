package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class PrjSumIndexService extends PmkpiService {
    private PrjSumIndexBO prjSumIndexBO;

    public void setPrjSumIndexBO(PrjSumIndexBO prjSumIndexBO) {
        this.prjSumIndexBO = prjSumIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("pro_code", request.getParameter("pro_code"));//一级项目编码
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return prjSumIndexBO.getDatas(parms);
    }
}
