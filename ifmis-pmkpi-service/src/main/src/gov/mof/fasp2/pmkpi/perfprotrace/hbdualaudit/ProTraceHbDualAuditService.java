package gov.mof.fasp2.pmkpi.perfprotrace.hbdualaudit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProTraceHbDualAuditService extends PmkpiService {

    private ProTraceHbDualAuditBO proTraceHbDualAuditBO;

    public void setProTraceHbDualAuditBO(ProTraceHbDualAuditBO proTraceHbDualAuditBO) {
        this.proTraceHbDualAuditBO = proTraceHbDualAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String proworkflow = request.getParameter("proworkflow");
        String deptworkflow = request.getParameter("deptworkflow");
        String prolev = request.getParameter("prolev");
        config.put("proworkflow", proworkflow);
        config.put("deptworkflow", deptworkflow);
        config.put("prolev", prolev);
        config.put("deptcoldatas", proTraceHbDualAuditBO.getCols("/pmkpi/trace/report/dept"));
        config.put("depttabledata", proTraceHbDualAuditBO.getTable("/pmkpi/trace/report/dept"));
        config.put("deptqfdatas", proTraceHbDualAuditBO.getQueryFrom("/pmkpi/trace/report/dept"));
        config.put("procoldatas", proTraceHbDualAuditBO.getCols("/pmkpi/program/trace/hbreport"));
        config.put("protabledata", proTraceHbDualAuditBO.getTable("/pmkpi/program/trace/hbreport"));
        config.put("proqfdatas", proTraceHbDualAuditBO.getQueryFrom("/pmkpi/program/trace/report"));
        config.put("audittrace", ProTraceHbDualAuditDAO.PERF_STRING_TRACE);
        config.put("tempatecode", request.getParameter("tempatecode"));
        return config;
    }

    /**
     * 审核/送审/取消审核/退回
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        try {
            backmap = proTraceHbDualAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code", e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        return proTraceHbDualAuditBO.getTreeData(params);
    }


    /**
     * <p>发起目标调整</p >
     *
     * @param
     * @author hw
     * @date 2021/5/26 14:58
     */
    public Map<String, Object> adjustTarget(HashMap<String, Object> datas) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        backmap.put("success", true);
        backmap.put("code", "200");
        backmap.put("message", "发起调整成功!");
        backmap.put("resp", null);
        try {
            proTraceHbDualAuditBO.savePushremind(datas);
        } catch (AppException e) {
            backmap.put("success", false);
            backmap.put("code", "400");
            backmap.put("message", "发起调整失败!");
        }
        return backmap;
    }

    /**
     * <p>发起监控整改</p >
     *
     * @author hw
     * @date 2021/5/28 11:01
     * @param
     */
    public Map<String, Object> monRect(HashMap<String, Object> datas) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        backmap.put("success", true);
        backmap.put("code", "200");
        backmap.put("message", "发起调整成功!");
        backmap.put("resp", null);
        try {
            proTraceHbDualAuditBO.monRect(datas);
        } catch (AppException e) {
            backmap.put("success", false);
            backmap.put("code", "400");
            backmap.put("message", "发起调整失败!");
        }
        return backmap;
    }


}
