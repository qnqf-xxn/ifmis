package gov.mof.fasp2.pmkpi.perfself.pushdatacommun;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 山西推送自评报告到数据交互中心
 */
public class PushDataCommunPage extends PmkpiPage {

    /**
     * 推送自评报告到数据交互中心页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PushDataCommunBO pushDataCommunBO = (PushDataCommunBO) PerfServiceFactory.getBean("pmkpi.perfself.PushDataCommunBOTX");
        request.setAttribute("leftconfig", pushDataCommunBO.getTreeInfo(config));
        config.put("left", "lefttree");
        return config;
    }
}
