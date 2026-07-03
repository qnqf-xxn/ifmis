package gov.mof.fasp2.pmkpi.randomComment.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.randomComment.bo.RandomCommentRandomBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RandomCommentRandomService extends PmkpiService {
    private RandomCommentRandomBO randomCommentRandomBO;

    public void setRandomCommentRandomBO(RandomCommentRandomBO randomCommentRandomBO) {
        this.randomCommentRandomBO = randomCommentRandomBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String pagetype = request.getParameter("pagetype");
        String workflow = request.getParameter("workflow");
        String tablecode = request.getParameter("tablecode");
        String tabcode = request.getParameter("tabcode");
        config.put("tabcode",tabcode);
        config.put("pagetype",pagetype);
        config.put("workflow",workflow);
        config.put("tablecode",tablecode);
        config.put("deptqfdatas", randomCommentRandomBO.getQueryFrom("/pmkpi/randomcomment/random/dept"));
        config.put("proqfdatas", randomCommentRandomBO.getQueryFrom("/pmkpi/randomcomment/random/index"));
        return config;
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

    /**
     * <p>左侧树</p >
     *
     * @author
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return randomCommentRandomBO.getTreeData(params);
    }

    public Map<String, Object> delByGuids(HashMap<String,Object> config) throws AppException{
        return randomCommentRandomBO.delByGuids(config);
    }
}
