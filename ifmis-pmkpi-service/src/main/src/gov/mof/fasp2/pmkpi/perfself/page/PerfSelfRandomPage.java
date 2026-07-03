package gov.mof.fasp2.pmkpi.perfself.page;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageBO;
import gov.mof.fasp2.pmkpi.perfself.bo.PerfSelfApplyBO;
import gov.mof.fasp2.pmkpi.perfself.bo.PerfSelfRandomBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfSelfRandomPage extends PmkpiPage {

    /**
     * 自评抽取
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PerfSelfRandomBO perfSelfRandomBO = (PerfSelfRandomBO) ServiceFactory.getBean("pmkpi.perfSelf.PerfSelfRandomBOTX");
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", perfSelfRandomBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;
    }

    /**
     * 人工选择
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map check(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PerfSelfRandomBO perfSelfRandomBO = (PerfSelfRandomBO) ServiceFactory.getBean("pmkpi.perfSelf.PerfSelfRandomBOTX");
        String menuId = request.getParameter("menuId");
        String dept_code = request.getParameter("dept_code");
        request.setAttribute("leftconfig", perfSelfRandomBO.getLeftData(menuId,dept_code));
        config.put("left", "lefttree");
        return config;
    }

}
