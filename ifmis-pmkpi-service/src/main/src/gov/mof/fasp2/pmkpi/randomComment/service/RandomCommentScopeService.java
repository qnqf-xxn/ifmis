package gov.mof.fasp2.pmkpi.randomComment.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.randomComment.bo.RandomCommentScopeBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RandomCommentScopeService extends PmkpiService {
    private RandomCommentScopeBO randomCommentScopeBO;

    public void setRandomCommentScopeBO(RandomCommentScopeBO randomCommentScopeBO) {
        this.randomCommentScopeBO = randomCommentScopeBO;
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
        config.put("deptqfdatas", randomCommentScopeBO.getQueryFrom("/pmkpi/randomcomment/scope/dept"));
        config.put("proqfdatas", randomCommentScopeBO.getQueryFrom("/pmkpi/randomcomment/scope/index"));
        return config;
    }
    
	/**  
	 * @Title: submitScope  
	 * @Description: TODO(范围标识)  
	 * @param config
	 * @return
	 * @throws AppException   
	 */ 
	public Map<String, Object> submitScope(HashMap<String,Object> config) throws AppException{
		return randomCommentScopeBO.submitScope(config);
	}
	
	public Map<String, Object> delByGuids(HashMap<String,Object> config) throws AppException{
		return randomCommentScopeBO.delByGuids(config);
	}

    /**
     * <p>左侧树</p >
     *
     * @author
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return randomCommentScopeBO.getTreeData(params);
    }

}
