package gov.mof.fasp2.pmkpi.evaluate.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.evaluate.bo.PreEvaluateBo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PreEvaluateService extends PmkpiService {

    private PreEvaluateBo preEvaluateBo;

    public void setPreEvaluateBo(PreEvaluateBo preEvaluateBo) {
        this.preEvaluateBo = preEvaluateBo;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("deptcoldatas", preEvaluateBo.getCols("/pmkpi/review/report/dept"));
        config.put("depttabledata", preEvaluateBo.getTable("/pmkpi/review/report/dept"));
        config.put("deptqfdatas", preEvaluateBo.getQueryFrom("/pmkpi/review/report/dept"));
        config.put("procoldatas", preEvaluateBo.getCols("/pmkpi/review/report/program"));
        config.put("protabledata", preEvaluateBo.getTable("/pmkpi/review/report/program"));
        config.put("proqfdatas", preEvaluateBo.getQueryFrom("/pmkpi/review/report/program"));
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
            rs = preEvaluateBo.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return preEvaluateBo.getTreeData(params);
    }
}
