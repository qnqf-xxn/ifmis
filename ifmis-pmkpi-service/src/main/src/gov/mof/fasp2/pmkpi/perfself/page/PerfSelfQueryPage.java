package gov.mof.fasp2.pmkpi.perfself.page;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfself.bo.PerfSelfQueryBO;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfApplyDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfSelfQueryPage extends PmkpiPage {

    private PerfSelfApplyDAO perfSelfApplyDAO;

    public void setPerfSelfApplyDAO(PerfSelfApplyDAO perfSelfApplyDAO) {
        this.perfSelfApplyDAO = perfSelfApplyDAO;
    }
    /**
     * 页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PerfSelfQueryBO perfSelfQueryBO = (PerfSelfQueryBO) ServiceFactory.getBean("pmkpi.perfSelf.PerfSelfQueryBOTX");
        String menuId = request.getParameter("menuId");
        request.setAttribute("leftconfig", perfSelfQueryBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
    
}
