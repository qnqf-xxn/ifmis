package gov.mof.fasp2.pmkpi.evaluate.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.evaluate.bo.ThirdEvaluateBo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ThirdEvaluateService extends PmkpiService {

    private ThirdEvaluateBo thirdEvaluateBo;

    public void setThirdEvaluateBo(ThirdEvaluateBo thirdEvaluateBo) {
        this.thirdEvaluateBo = thirdEvaluateBo;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("deptcoldatas", thirdEvaluateBo.getCols("/pmkpi/evaluate/thirdevaluate/dept/index"));
        config.put("depttabledata", thirdEvaluateBo.getTable("/pmkpi/evaluate/thirdevaluate/dept/index"));
        config.put("deptqfdatas", thirdEvaluateBo.getQueryFrom("/pmkpi/evaluate/thirdevaluate/dept/index"));
        config.put("procoldatas", thirdEvaluateBo.getCols("/pmkpi/evaluate/thirdevaluate/index"));
        config.put("protabledata", thirdEvaluateBo.getTable("/pmkpi/evaluate/thirdevaluate/index"));
        config.put("proqfdatas", thirdEvaluateBo.getQueryFrom("/pmkpi/evaluate/thirdevaluate/index"));
        config.put("workflow", request.getParameter("workflow"));
        return config;
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = thirdEvaluateBo.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return thirdEvaluateBo.getTreeData(params);
    }

    /**
     * 是否确认第三方机构评审
     * @param params
     * @return
     */
    public Map<String, Object> isConfirm(HashMap<String, Object> params) throws AppException {
        return thirdEvaluateBo.isConfirm(params);
    }
}
