package gov.mof.fasp2.pmkpi.workevaluate.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WorkEvaluateReportService extends PmkpiService {
    private WorkEvaluateReportBO workEvaluateReportBO;

    public void setWorkEvaluateReportBO(WorkEvaluateReportBO workEvaluateReportBO) {
        this.workEvaluateReportBO = workEvaluateReportBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String provincescoretype = request.getParameter("provincescoretype");
        config.put("provincescoretype", provincescoretype);
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
            rs = workEvaluateReportBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询左侧树
     * @param params ---
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return workEvaluateReportBO.getTreeData(params);
    }

    /**
     * 区县审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> subProvinceAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = workEvaluateReportBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
