package gov.mof.fasp2.pmkpi.randomComment.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.randomComment.bo.RandomChooseMeasuresAddBO;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RandomChooseMeasuresAddService extends PmkpiService {
    private RandomChooseMeasuresAddBO randomChooseMeasuresAddBO;

    public void setRandomChooseMeasuresAddBO(RandomChooseMeasuresAddBO randomChooseMeasuresAddBO) {
        this.randomChooseMeasuresAddBO = randomChooseMeasuresAddBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String guid = request.getParameter("guid");
        String levelno = request.getParameter("levelno");
        String superid = request.getParameter("superid");
        String projguid = request.getParameter("projguid");
        String ordernum = request.getParameter("ordernum");
        String mainguid = request.getParameter("mainguid");
        config.put("mainguid",mainguid);
        config.put("ordernum",ordernum);
        config.put("guid",guid);
        config.put("levelno",levelno);
        config.put("superid",superid);
        config.put("projguid",projguid);
        return config;
    }
    
    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return randomChooseMeasuresAddBO.getDatas(parms);
    }
	
}
