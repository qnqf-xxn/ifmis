package gov.mof.fasp2.pmkpi.projapplyjs.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.projapplyjs.bo.PerfAdvEvalBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class PerfAdvEvalService extends PmkpiService {
    private PerfAdvEvalBO perfAdvEvalBO;

    public void setPerfAdvEvalBO(PerfAdvEvalBO perfAdvEvalBO) {
        this.perfAdvEvalBO = perfAdvEvalBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String projguid = request.getParameter("projguid");
        String viewtype = request.getParameter("viewtype");
        config.put("mainguid", mainguid);
        config.put("projguid", projguid);
        config.put("viewtype", viewtype);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return perfAdvEvalBO.getData(parms);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        return perfAdvEvalBO.save(parms);
    }
}
