package gov.mof.fasp2.pmkpi.randomComment.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.randomComment.bo.RandomCommentQueryBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RandomCommentQueryService extends PmkpiService {
    private RandomCommentQueryBO randomCommentQueryBO;

    public void setRandomCommentQueryBO(RandomCommentQueryBO randomCommentQueryBO) {
        this.randomCommentQueryBO = randomCommentQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String tablecode = request.getParameter("tablecode");
        String tabcode = request.getParameter("tabcode");
        config.put("tabcode",tabcode);
        config.put("tablecode",tablecode);
        String tempatecode = request.getParameter("tempatecode");
        config.put("tempatecode", tempatecode);
        config.put("deptqfdatas", randomCommentQueryBO.getQueryFrom("/pmkpi/randomcomment/query/dept"));
        config.put("proqfdatas", randomCommentQueryBO.getQueryFrom("/pmkpi/randomcomment/query/index"));
        return config;
    }

    /**
     * <p>左侧树</p >
     *
     * @author
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return randomCommentQueryBO.getTreeData(params);
    }
}
