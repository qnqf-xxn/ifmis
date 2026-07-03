package gov.mof.fasp2.pmkpi.perfprogram.yearquery;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class YearProgramQueryPage extends PmkpiPage {

    /**
     * 查询页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        YearProgramQueryBO yearProgramQueryBO = (YearProgramQueryBO) ServiceFactory.getBean("pmkpi.perfprogram.YearProgramQueryBOTX");
        String menuId = request.getParameter("menuId");
        String type = request.getParameter("type");
//        String prolev = request.getParameter("prolev"); //项目一二三级项目
        HashMap<String, Object> params = new HashMap<String, Object>();
        params.put("menuId",menuId);
        params.put("type",type);
        request.setAttribute("leftconfig", yearProgramQueryBO.getTreeData(params));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
}
