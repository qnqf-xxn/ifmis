package gov.mof.fasp2.pmkpi.perfcommon.aisupportaudit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName: AISupportAuditService
 * @Description: Description of this class
 */
public class AISupportAuditExeService extends PmkpiService {
    /**
     * 注入bo.
     */
    private AISupportAuditExeBO aISupportAuditExeBO;

    /**
     * 注入bo.
     * @param aISupportAuditExeBO -- bo.
     * @throws
     */
    public void setAISupportAuditExeBO(AISupportAuditExeBO aISupportAuditExeBO) {
        this.aISupportAuditExeBO = aISupportAuditExeBO;
    }
    /**
     * 初始化加载页面.
     * <p>Title: loadComponent</p>
     * <p>Description: </p>
     * @param request -- 请求
     * @param response -- 响应
     * @param config -- 配置
     * @return
     * @throws AppException
     * @see gov.mof.fasp2.buscore.framework.component.AbstractComponentService#loadComponent(HttpServletRequest, HttpServletResponse, Map)
     */
    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("apikey", request.getParameter("api_key"));
        config.put("apicode", request.getParameter("api_code"));
        config.put("pro_code", request.getParameter("pro_code"));
        config.put("isShowThink", PerfUtil.get_isShowAIThink());//是否显示AI思考过程，兼容无思考过程的的AI模型
        String isloadtaskdata = request.getParameter("isloadtaskdata");
        config.put("isLoadTaskData", isloadtaskdata);
        String isautosave = request.getParameter("isautosave")!=null ? request.getParameter("isautosave") : "1";
        config.put("isautosave", isautosave);
        config.put("isHuBei", PerfUtil.getIS_HUBEI());
        HashMap<String, Object> params = new HashMap<>();
        params.putAll(config);
        return config;
    }

    public Map<String, Object> batchAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = aISupportAuditExeBO.batchAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    public Map<String, Object> clearAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = aISupportAuditExeBO.clearAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    public Map<String, Object> clearError(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = aISupportAuditExeBO.clearError(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
