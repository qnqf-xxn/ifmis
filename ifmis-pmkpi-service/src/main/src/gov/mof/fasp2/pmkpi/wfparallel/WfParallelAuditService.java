package gov.mof.fasp2.pmkpi.wfparallel;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WfParallelAuditService extends PmkpiService {

    private WfParallelAuditBO wfParallelAuditBO;

    public void setWfParallelAuditBO(WfParallelAuditBO wfParallelAuditBO) {
        this.wfParallelAuditBO = wfParallelAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String modeltype = request.getParameter("modeltype");//模块类型
        String bustype = request.getParameter("bustype");//业务类型
        String proworkflow = request.getParameter("proworkflow");
        String deptworkflow = request.getParameter("deptworkflow");
        config.put("modeltype", modeltype);
        config.put("bustype", bustype);
        config.put("proworkflow", proworkflow);
        config.put("deptworkflow", deptworkflow);
        if (modeltype != null && "dept".equals(modeltype)){
            config.put("deptcoldatas", wfParallelAuditBO.getCols("/pmkpi/deptperformance/audit/index"));
            config.put("depttabledata", wfParallelAuditBO.getTable("/pmkpi/deptperformance/audit/index"));
            config.put("deptqfdatas", wfParallelAuditBO.getQueryFrom("/pmkpi/deptperformance/audit/index"));
            config.put("deptkey","/pmkpi/deptperformance/audit/index");
            config.put("deptuikey","/pmkpi/deptperformance/report/edit");
            config.put("lefttabtype","dept");
            config.put("lefttreename","部门整体");
        }
        if (modeltype != null && "trace".equals(modeltype)){
            config.put("deptcoldatas", wfParallelAuditBO.getCols("/pmkpi/trace/report/dept"));
            config.put("depttabledata", wfParallelAuditBO.getTable("/pmkpi/trace/report/dept"));
            config.put("deptqfdatas", wfParallelAuditBO.getQueryFrom("/pmkpi/trace/report/dept"));
            config.put("procoldatas", wfParallelAuditBO.getCols("/pmkpi/program/trace/report"));
            config.put("protabledata", wfParallelAuditBO.getTable("/pmkpi/program/trace/report"));
            config.put("proqfdatas", wfParallelAuditBO.getQueryFrom("/pmkpi/program/trace/report"));
            config.put("prokey", "/pmkpi/program/trace/report");
            config.put("deptkey","/pmkpi/trace/report/dept");
            config.put("prouikey", "/pmkpi/program/trace/report/edit");
            config.put("proordinaryuikey","/pmkpi/program/trace/report/ordinaryedit");
            config.put("deptuikey","/pmkpi/trace/report/deptedit");
            config.put("lefttabtype","program");
            config.put("lefttreename","项目支出");
            config.put("aduithide", WfParallelAuditDAO.PERF_STRING_TRACE);
        }
        return config;
    }

    /**
     * 左侧树s数据查询
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return wfParallelAuditBO.getTreeData(params);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        try {
            backmap = wfParallelAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code", e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

}
