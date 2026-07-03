package gov.mof.fasp2.pmkpi.randomComment.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.randomComment.bo.RandomCommentEntrustBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RandomCommentEntrustService extends PmkpiService {
    private RandomCommentEntrustBO randomCommentEntrustBO;

    public void setRandomCommentEntrustBO(RandomCommentEntrustBO randomCommentEntrustBO) {
        this.randomCommentEntrustBO = randomCommentEntrustBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String tablecode = request.getParameter("tablecode");
        String tabcode = request.getParameter("tabcode");
        config.put("tabcode",tabcode);
        config.put("tablecode",tablecode);
        config.put("deptqfdatas", randomCommentEntrustBO.getQueryFrom("/pmkpi/randomcomment/entrust/dept"));
        config.put("proqfdatas", randomCommentEntrustBO.getQueryFrom("/pmkpi/randomcomment/entrust/index"));
        return config;
    }
    
	public Map<String, Object> delByGuids(HashMap<String,Object> config) throws AppException{
		return randomCommentEntrustBO.delByGuids(config);
	}

    /**
     * <p>左侧树</p >
     *
     * @author
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return randomCommentEntrustBO.getTreeData(params);
    }
	
}
