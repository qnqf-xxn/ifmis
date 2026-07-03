package gov.mof.fasp2.pmkpi.randomComment.service;

import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.randomComment.bo.RandomCommentRandomBO;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RandomService extends PmkpiService {
    private RandomCommentRandomBO randomCommentRandomBO;

    public void setRandomCommentRandomBO(RandomCommentRandomBO randomCommentRandomBO) {
        this.randomCommentRandomBO = randomCommentRandomBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String tablecode = request.getParameter("tablecode");
        config.put("tablecode",tablecode);
        return config;
    }	
	
}
