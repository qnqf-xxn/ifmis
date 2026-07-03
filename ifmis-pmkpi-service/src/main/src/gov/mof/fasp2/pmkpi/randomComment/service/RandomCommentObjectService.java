package gov.mof.fasp2.pmkpi.randomComment.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.randomComment.bo.RandomCommentObjectBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RandomCommentObjectService extends PmkpiService {
    private RandomCommentObjectBO randomCommentObjectBO;

    public void setRandomCommentObjectBO(RandomCommentObjectBO randomCommentObjectBO) {
        this.randomCommentObjectBO = randomCommentObjectBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String pagetype = request.getParameter("pagetype");
        String workflow = request.getParameter("workflow");
        String tablecode = request.getParameter("tablecode");
        String tabcode = request.getParameter("tabcode");
        String isAgency = request.getParameter("isAgency");
        config.put("isAgency",isAgency);
        config.put("tabcode",tabcode);
        config.put("pagetype",pagetype);
        config.put("workflow",workflow);
        config.put("tablecode",tablecode);
        config.put("deptqfdatas", randomCommentObjectBO.getQueryFrom("/pmkpi/randomcomment/object/dept"));
        config.put("proqfdatas", randomCommentObjectBO.getQueryFrom("/pmkpi/randomcomment/object/index"));
        return config;
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = randomCommentObjectBO.submitObject(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
    
	public Map<String, Object> delByGuids(HashMap<String,Object> config) throws AppException{
		return randomCommentObjectBO.delByGuids(config);
	}

    /**
     * <p>左侧树</p >
     *
     * @author
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return randomCommentObjectBO.getTreeData(params);
    }
}
