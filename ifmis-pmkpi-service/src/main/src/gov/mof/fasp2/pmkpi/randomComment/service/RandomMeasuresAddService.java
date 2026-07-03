package gov.mof.fasp2.pmkpi.randomComment.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.randomComment.bo.RandomMeasuresAddBO;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RandomMeasuresAddService extends PmkpiService {
    private RandomMeasuresAddBO randomMeasuresAddBO;

    public void setRandomMeasuresAddBO(RandomMeasuresAddBO randomMeasuresAddBO) {
        this.randomMeasuresAddBO = randomMeasuresAddBO;
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
        String agencyguid = request.getParameter("agencyguid");
        config.put("mainguid",mainguid);
        config.put("ordernum",ordernum);
        config.put("guid",guid);
        config.put("levelno",levelno);
        config.put("superid",superid);
        config.put("projguid",projguid);
        config.put("agencyguid",agencyguid);
        return config;
    }
    
    public Map save(Map map) throws AppException{
		return randomMeasuresAddBO.save(map);
	}
	
}
