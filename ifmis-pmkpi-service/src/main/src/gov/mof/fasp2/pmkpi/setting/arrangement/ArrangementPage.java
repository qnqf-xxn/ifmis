package gov.mof.fasp2.pmkpi.setting.arrangement;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ArrangementPage extends PmkpiPage {

    /**
     * 层次分类
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map toIndex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ArrangementBO arrangementBO = (ArrangementBO) ServiceFactory.getBean("pmkpi.arrangement.ArrangementBOTX");
        request.setAttribute("leftconfig", arrangementBO.getTreeData());
        config.put("left", "lefttree");
        return config;
    }
}
