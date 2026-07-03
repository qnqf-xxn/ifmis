package gov.mof.fasp2.pmkpi.appraisal.query;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class AppraisalQueryPage extends PmkpiPage {

    /**
     * 绩效考核查询
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        AppraisalQueryBO appraisalQueryBO = (AppraisalQueryBO) ServiceFactory.getBean("pmkpi.appraisal.AppraisalQueryBOTX");
        String menuId = StringUtil.isEmpty(request.getParameter("menuId")) ? request.getParameter("menuguid") : request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", appraisalQueryBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;
    }
}
