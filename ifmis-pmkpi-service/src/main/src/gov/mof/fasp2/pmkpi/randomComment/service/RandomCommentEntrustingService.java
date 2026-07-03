package gov.mof.fasp2.pmkpi.randomComment.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.randomComment.bo.RandomCommentEntrustingBO;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RandomCommentEntrustingService extends PmkpiService {
    private RandomCommentEntrustingBO randomCommentEntrustingBO;

    public void setRandomCommentEntrustingBO(RandomCommentEntrustingBO randomCommentEntrustingBO) {
        this.randomCommentEntrustingBO = randomCommentEntrustingBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
    	 super.loadComponent(request, response, config);
         String guids = request.getParameter("guids");
         String tablecode = request.getParameter("tablecode");
         String tabcode = request.getParameter("tabcode");
         config.put("tabcode",tabcode);
         config.put("guids",guids);
         config.put("tablecode",tablecode);
         return config;
    }
    
	public Map<String, Object> submit(HashMap<String,Object> config) throws AppException{
		return randomCommentEntrustingBO.submit(config);
	}
	
 
}
