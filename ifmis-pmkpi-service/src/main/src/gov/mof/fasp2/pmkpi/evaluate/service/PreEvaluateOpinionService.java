package gov.mof.fasp2.pmkpi.evaluate.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.evaluate.bo.PreEvaluateOpinionBo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PreEvaluateOpinionService extends PmkpiService {

    private PreEvaluateOpinionBo preEvaluateOpinionBo;

    public void setPreEvaluateOpinionBo(PreEvaluateOpinionBo preEvaluateOpinionBo) {
        this.preEvaluateOpinionBo = preEvaluateOpinionBo;
    }

    /**
     * 初始化页面.
     * <p>Title: loadComponent</p>
     * <p>Description: </p>
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config -- 参数.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        String guid = request.getParameter("guid");
        config.put("proguid", guid);
        config.put("editinfo", preEvaluateOpinionBo.getGoalByGuid(guid));
        return config;
    }

    /**
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> saveOpinion(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = preEvaluateOpinionBo.saveData(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 触发查询方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> findOpinion(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            List<Map<String, Object>> list = preEvaluateOpinionBo.getGoalByGuid((String) params.get("projguid"));
            if(list.size()>0){
                rs = list.get(0);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
