package gov.mof.fasp2.pmkpi.perfcommon.aisupportaudit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
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
public class AIPrePerfAuditService extends PmkpiService {
    /**
     * 注入bo.
     */
    private AIPrePerfAuditBO aIPrePerfAuditBO;

    /**
     * 注入bo.
     * @param aIPrePerfAuditBO -- bo.
     * @throws
     */
    public void setAIPrePerfAuditBO(AIPrePerfAuditBO aIPrePerfAuditBO) {
        this.aIPrePerfAuditBO = aIPrePerfAuditBO;
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
        String aitaskparams = PerfUtil.getSystemSet("aitaskparams");
        logger.info("-----------AI后台任务,系统参数："+aitaskparams);
        Map<String, Object> aitaskparamsmap = PerfUtil.parseString2Map(aitaskparams);
        int singletimeoutms = Integer.parseInt((String) aitaskparamsmap.get("singletimeoutms"));
        config.put("timeout_ms", singletimeoutms);
        config.put("isHuBei", PerfUtil.getIS_HUBEI());
        HashMap<String, Object> params = new HashMap<>();
        params.putAll(config);
        return config;
    }

    /**
     * 获取项目提示词
     * @param params --
     * @return --
     */
    public Map<String, Object> getProPrompt(HashMap<String, Object> params) {
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            remp = aIPrePerfAuditBO.getProPrompt(params);
            remp.put("msg", "Y");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
            remp.put("msg", e.getMessage());
        }
        return remp;
    }

    /**
     * 获取审核结果
     * @param params --
     * @return --
     */
    public Map<String, Object> getAuditData(HashMap<String, Object> params) {
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            remp = aIPrePerfAuditBO.getAuditData(params);
            remp.put("msg", "Y");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
            remp.put("msg", e.getMessage());
        }
        return remp;
    }

    /**
     * 保存新的实时辅助审核结果
     * @param params --
     * @return --
     */
    public Map<String, Object> saveNewAISupportAuditDatas(HashMap<String, Object> params) {
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            remp = aIPrePerfAuditBO.saveNewAISupportAuditDatas(params);
            remp.put("msg", "Y");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
            remp.put("msg", e.getMessage());
        }
        return remp;
    }

}
