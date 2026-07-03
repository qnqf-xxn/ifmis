package gov.mof.fasp2.pmkpi.perfself.page;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfself.bo.PerfSelfTaskManageBO;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfTaskManageDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfSelfTaskManagePage extends PmkpiPage {

    private PerfSelfTaskManageDAO perfSelfTaskManageDAO;

    public void setPerfSelfTaskManageDAO(PerfSelfTaskManageDAO perfSelfTaskManageDAO) {
        this.perfSelfTaskManageDAO = perfSelfTaskManageDAO;
    }

    /**
     * 下达页面
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PerfSelfTaskManageBO perfSelfTaskManageBO = (PerfSelfTaskManageBO) ServiceFactory.getBean("pmkpi.perfSelf.PerfSelfTaskManageBOTX");
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        request.setAttribute("leftconfig", perfSelfTaskManageBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config, menuId);
        return config;
    }

    /**
     * 下达编辑
     *
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map edit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
