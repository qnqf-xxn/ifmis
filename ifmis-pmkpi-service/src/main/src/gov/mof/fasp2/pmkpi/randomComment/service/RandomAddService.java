package gov.mof.fasp2.pmkpi.randomComment.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.randomComment.bo.RandomCommentRandomBO;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RandomAddService extends PmkpiService {
    private RandomCommentRandomBO randomCommentRandomBO;

    public void setRandomCommentRandomBO(RandomCommentRandomBO randomCommentRandomBO) {
        this.randomCommentRandomBO = randomCommentRandomBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String bustype = request.getParameter("bustype");
        String randomprojcount = request.getParameter("randomprojcount");
        String tabcode = request.getParameter("tabcode");
        config.put("bustype",bustype);
        config.put("tabcode",tabcode);
        config.put("randomprojcount",randomprojcount);
        config.put("random",randomCommentRandomBO.queryRandomCount(bustype));
        return config;
    }
    
    
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        return randomCommentRandomBO.editquery(params);
    }
    
	public Map save(HashMap config) throws AppException{
		return randomCommentRandomBO.save(config);
	}
	
	/**  
	 * @Title: submitScope  
	 * @Description: TODO(随机抽取)  
	 * @param config
	 * @return
	 * @throws AppException   
	 */ 
	public Map<String, Object> submitRandom(HashMap<String,Object> config) throws AppException{
		return randomCommentRandomBO.submitRandom(config);
	}
	
	public boolean queryRandom(String bustype) throws AppException{
		return randomCommentRandomBO.queryRandom(bustype);
	}

    public String queryRandomCount(String bustype) throws AppException{
        return randomCommentRandomBO.queryRandomCount(bustype);
    }
	
}
