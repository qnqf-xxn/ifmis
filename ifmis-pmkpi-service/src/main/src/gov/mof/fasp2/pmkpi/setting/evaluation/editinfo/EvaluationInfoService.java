package gov.mof.fasp2.pmkpi.setting.evaluation.editinfo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class EvaluationInfoService extends PmkpiService {

    private EvaluationInfoBO evaluationInfoBO;

    public void setEvaluationInfoBO (EvaluationInfoBO evaluationInfoBO){
        this.evaluationInfoBO = evaluationInfoBO;
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
    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String prolev = request.getParameter("prolev"); //项目等级
        String mainguid = request.getParameter("mainguid");
        String proguid = request.getParameter("projguid");
        String procode = request.getParameter("procode");
        String viewtype = request.getParameter("viewtype");
        config.put("prolev", prolev); //项目等级123级项目
        config.put("mainguid", mainguid);
        config.put("viewtype", viewtype);
        config.put("proguid", proguid);
        config.put("procode", procode);
        return config;
    }

    /**
     * 绩效保存方法.保存事前绩效评估信息
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> saveDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = evaluationInfoBO.saveDatas(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询项目评估信息
     * @param parms -- 前端参数.
     * @return -- list.
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return evaluationInfoBO.getDatas(parms);
    }
}
