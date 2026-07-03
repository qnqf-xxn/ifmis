package gov.mof.fasp2.pmkpi.randomComment.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.randomComment.bo.RandomCommentProjBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RandomCommentProjService extends PmkpiService {
    private RandomCommentProjBO randomCommentProjBO;

    public void setRandomCommentProjBO(RandomCommentProjBO randomCommentProjBO) {
        this.randomCommentProjBO = randomCommentProjBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String pagetype = request.getParameter("pagetype");
        String workflow = request.getParameter("workflow");
        String tablecode = request.getParameter("tablecode");
        String tabcode = request.getParameter("tabcode");
        String bustype = request.getParameter("bustype");
        config.put("tabcode",tabcode);
        config.put("pagetype",pagetype);
        config.put("workflow",workflow);
        config.put("tablecode",tablecode);
        config.put("bustype",bustype);

        return config;
    }

    
	/**  
	 * @Title: submitScope  
	 * @Description: TODO(范围标识)  
	 * @param config
	 * @return
	 * @throws AppException   
	 */ 
	public Map<String, Object> submitProj(HashMap<String,Object> config) throws AppException{
		return randomCommentProjBO.submitProj(config);
	}
	
    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = randomCommentProjBO.submitProj(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * <p>左侧树</p >
     *
     * @author
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return randomCommentProjBO.getTreeData(params);
    }
}
