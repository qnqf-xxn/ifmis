package gov.mof.fasp2.pmkpi.evaluate.audit;

import gov.mof.fasp2.buscore.framework.util.GlobalConfig;
import gov.mof.fasp2.buscore.framework.util.JsonUtils;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class EvaluateAuditPage extends PmkpiPage {

    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String systemStyle = GlobalConfig.getConfigData("SYSTEM_STYLE");
        request.setAttribute("SYSTEM_STYLE", systemStyle);
        EvaluateAuditBO evaluateAuditBO  = (EvaluateAuditBO) PerfServiceFactory.getBean("pmkpi.evaluate.EvaluateAuditBO");
        String mainguid = request.getParameter("mainguid");
        String saveAgency = request.getParameter("saveAgency");
        config.put("tabledata", JsonUtils.ListToRecordSet(evaluateAuditBO.getFile(mainguid)));
        config.put("mainguid", mainguid);
        config.put("saveAgency", saveAgency);
        return config;
    }
}
