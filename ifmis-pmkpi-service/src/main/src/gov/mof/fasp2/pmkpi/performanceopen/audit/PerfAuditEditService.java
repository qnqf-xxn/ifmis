package gov.mof.fasp2.pmkpi.performanceopen.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfAuditEditService extends PmkpiService {
    private PerfOpenAuditBO perfOpenAuditBO;

    public void setPerfOpenAuditBO(PerfOpenAuditBO perfOpenAuditBO) {
        this.perfOpenAuditBO = perfOpenAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String[] guids = request.getParameterValues("guids");// guids
        String workflow = request.getParameter("workflow");
        String tablecode = request.getParameter("tablecode");
        String busguid = request.getParameter("busguid");
        List<Map<String, Object>> audittypedatas = null;
        audittypedatas = perfOpenAuditBO.getAudittypeDatas("");
        config.put("guids", guids);
        config.put("audittypedatas", audittypedatas);
        config.put("workflow", workflow);
        config.put("tablecode", tablecode);
        config.put("busguid", busguid);
        return config;
    }

    /**
     * 保存
     * @param params
     * @return
     */
    public Map<String,Object> save (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfOpenAuditBO.saveDatas(params);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs.put("success", false);
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("success", false);
            rs.put("code",e.getCode().replace("-null",""));
            logger.error(e.getMessage(), e);
        }
        return rs;

    }
}
