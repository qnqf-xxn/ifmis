package gov.mof.fasp2.pmkpi.randomComment.page;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.randomComment.bo.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class RandomCommentPage extends PmkpiPage {

    
    /**  
     * @Title: index  
     * @Description: TODO(抽评范围标识)  
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception   
     */ 
    public Map scopeIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        RandomCommentScopeBO randomCommentScopeBO = (RandomCommentScopeBO) ServiceFactory.getBean("pmkpi.randomcomment.RandomCommentScopeBOTX");
        String menuId = request.getParameter("menuId");
        String bustype = request.getParameter("bustype");
        config.put("bustype", bustype);
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", randomCommentScopeBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;

    }
    
    /**  
     * @Title: index  
     * @Description: TODO(抽评对象确定)  
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception   
     */ 
    public Map objectIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        RandomCommentObjectBO randomCommentObjectBO = (RandomCommentObjectBO) ServiceFactory.getBean("pmkpi.randomcomment.RandomCommentObjectBOTX");
        String menuId = request.getParameter("menuId");
        String bustype = request.getParameter("bustype");
        config.put("bustype", bustype);
        String isAgency = request.getParameter("isAgency");
        config.put("isAgency", isAgency);
        request.setAttribute("leftconfig", randomCommentObjectBO.getLeftTabTree(config));
        config.put("left", "lefttree");

        this.getHeadTitle(config,menuId);
        return config;
    }
    
    /**  
     * @Title: index  
     * @Description: TODO(随机抽评管理)  
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception   
     */ 
    public Map randomIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        RandomCommentRandomBO randomCommentRandomBO = (RandomCommentRandomBO) ServiceFactory.getBean("pmkpi.randomcomment.RandomCommentRandomBOTX");
        String menuId = request.getParameter("menuId");
        String bustype = request.getParameter("bustype");
        config.put("bustype", bustype);
        String isAgency = request.getParameter("isAgency");
        request.setAttribute("leftconfig", randomCommentRandomBO.getLeftTabTree(config));
        config.put("left", "lefttree");

        this.getHeadTitle(config,menuId);
        return config;
    }
    
    /**  
     * @Title: index  
     * @Description: TODO(抽评选择项目)  
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception   
     */ 
    public Map projIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        RandomCommentProjBO randomCommentProjBO = (RandomCommentProjBO) ServiceFactory.getBean("pmkpi.randomcomment.RandomCommentProjBOTX");
        String menuId = request.getParameter("menuId");
        String bustype = request.getParameter("bustype");
        config.put("bustype", bustype);
        String isAgency = request.getParameter("isAgency");
        request.setAttribute("leftconfig", randomCommentProjBO.getTreeData(menuId,bustype));
        config.put("left", "lefttree");

        return config;
    }
    
    /**  
     * @Title: randomAdd  
     * @Description: TODO(随机抽评设置)  
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception   
     */ 
    public Map randomAdd(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    
    /**  
     * @Title: random  
     * @Description: TODO(随机抽取)  
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception   
     */ 
    public Map random(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    
    public Map resultIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		RandomCommentResultBO randomCommentResultBO = (RandomCommentResultBO) ServiceFactory.getBean("pmkpi.randomcomment.RandomCommentResultBOTX");
		String menuId = request.getParameter("menuId");
		String bustype = request.getParameter("bustype");
        config.put("bustype", bustype);
        String isAgency = request.getParameter("isAgency");
        request.setAttribute("leftconfig", randomCommentResultBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
    	return config;
    }
    
    public Map entrustIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		RandomCommentEntrustBO randomCommentEntrustBO = (RandomCommentEntrustBO) ServiceFactory.getBean("pmkpi.randomcomment.RandomCommentEntrustBOTX");
		String menuId = request.getParameter("menuId");
		String bustype = request.getParameter("bustype");
        config.put("bustype", bustype);
        String isAgency = request.getParameter("isAgency");
        request.setAttribute("leftconfig", randomCommentEntrustBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
    	return config;
    }
    
    public Map entrustingIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
    	return config;
    }
    
    public Map queryIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
    	RandomCommentQueryBO randomCommentQueryBO = (RandomCommentQueryBO) ServiceFactory.getBean("pmkpi.randomcomment.RandomCommentQueryBOTX");
		String menuId = request.getParameter("menuId");
		String bustype = request.getParameter("bustype");
        config.put("bustype", bustype);
        request.setAttribute("leftconfig", randomCommentQueryBO.getLeftTabTree(config));
        config.put("left", "lefttree");

    	return config;
    }
    
    /**
     * 编辑
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map editIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		String menuid = request.getParameter("menuid");
		config.put("menuid", menuid);
        return config;
    }
    
    public Map randomIndexEdit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    
    public Map randomQualityEdit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    
    public Map randomProblemEdit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    
    public Map randomTabEdit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    
    public Map randomSelfEdit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

}
