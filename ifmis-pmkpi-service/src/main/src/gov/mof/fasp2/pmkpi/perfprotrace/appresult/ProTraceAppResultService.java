package gov.mof.fasp2.pmkpi.perfprotrace.appresult;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>绩效监控结果应用</p >
 *
 * @author hw
 * @date 2022/12/8 17:07
 */
public class ProTraceAppResultService extends PmkpiService {

    private ProTraceAppResultBO proTraceAppResultBO;

    public void setProTraceAppResultBO(ProTraceAppResultBO proTraceAppResultBO) {
        this.proTraceAppResultBO = proTraceAppResultBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String prolev = request.getParameter("prolev");
        config.put("prolev", prolev);
        String istraceinitiateadjust = PerfUtil.getSystemSet("ISTRACEINITIATEADJUST");//调整是否走工作流
        Map<String, Object> mm = PerfUtil.parseString2Map(istraceinitiateadjust);
        String deptwfststus = (String) mm.get("deptwfststus");
        String jxwfststus = (String) mm.get("jxwfststus");
        config.put("deptwfststus", deptwfststus);
        config.put("jxwfststus", jxwfststus);
        return config;
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        return proTraceAppResultBO.getTreeData(params);
    }

}
