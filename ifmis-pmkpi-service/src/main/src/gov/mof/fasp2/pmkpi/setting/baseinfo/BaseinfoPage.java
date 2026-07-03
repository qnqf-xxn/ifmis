package gov.mof.fasp2.pmkpi.setting.baseinfo;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class BaseinfoPage extends PmkpiPage {


    /**
     * 编辑页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map editindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
    /**
     * 中介库
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map zjindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String leftflag = request.getParameter("leftflag");
        BaseinfoBO baseinfoBO = (BaseinfoBO) ServiceFactory.getBean("pmkpi.baseinfo.BaseinfoBOTX");
        request.setAttribute("leftconfig", baseinfoBO.getTreeData(leftflag));
        config.put("leftflag",leftflag);
        config.put("left", "lefttree");
        config.put("filterbeanid", "pmkpi.filter.PonentUIFilter");
        return config;
    }

    /**
     * 评价列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map pjindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

}
