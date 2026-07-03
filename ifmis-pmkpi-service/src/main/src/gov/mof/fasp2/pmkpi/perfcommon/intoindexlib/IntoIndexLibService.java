package gov.mof.fasp2.pmkpi.perfcommon.intoindexlib;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class IntoIndexLibService extends PmkpiService {
    private IntoIndexLibBO intoIndexLibBO;

    public void setIntoIndexLibBO(IntoIndexLibBO intoIndexLibBO) {
        this.intoIndexLibBO = intoIndexLibBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("bustype", request.getParameter("bustype"));
        config.put("workflow", request.getParameter("workflow"));
        config.put("agency_code", request.getParameter("agency_code"));
        config.put("pro_name", request.getParameter("pro_name"));
        return config;
    }

    /**
     * 纳入指标库.
     * @param params 参数.
     * @return
     * @throws Exception
     */
    public Map<String, Object> intoindexlib(HashMap<String, Object> params) {
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            intoIndexLibBO.intoindexlib(params);
            remp.put("success", true);
        } catch (PerfAppException e) {
            remp = e.getRemap();
            remp.put("code",e.getCode());
        } catch (AppException e) {
            remp.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return remp;
    }

    /**
     * 指标重复校验.
     * @param params 参数.
     * @return
     * @throws Exception
     */
    public Map<String, Object> checkExists(HashMap<String, Object> params) {
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            remp = intoIndexLibBO.checkExists(params);
            remp.put("success", true);
        } catch (PerfAppException e) {
            remp = e.getRemap();
            remp.put("code",e.getCode());
        } catch (AppException e) {
            remp.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return remp;
    }
}
