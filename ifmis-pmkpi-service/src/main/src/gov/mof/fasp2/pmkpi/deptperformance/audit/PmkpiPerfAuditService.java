
package gov.mof.fasp2.pmkpi.deptperformance.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PmkpiPerfAuditService extends PmkpiService {
    private PmkpiPerfAuditBO pmkpiPerfAuditBO;

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String nodeguid = request.getParameter("nodeguid");
        String audittype = request.getParameter("audittype");
        if (StringUtil.isEmpty(nodeguid) || StringUtil.isEmpty(audittype)) {
            String workflow = request.getParameter("workflow");
            String wfstatus = request.getParameter("wfstatus");
            List<Map<String, Object>> auditmain = pmkpiPerfAuditBO.queryPrevAuditType(workflow, wfstatus);
            if (!auditmain.isEmpty()) {
                audittype = auditmain.get(0).get("audittype") + "";
                nodeguid = auditmain.get(0).get("nodeguid") + "";
            }
            config.put("nodeguid", nodeguid);
            config.put("audittype", audittype);
        }
        if (StringUtil.isEmpty(request.getParameter("proguid"))) {
            config.put("proguid", request.getParameter("projguid"));
        }
        if (StringUtil.isEmpty(request.getParameter("pro_code"))) {
            config.put("pro_code", request.getParameter("procode"));
        }
        Enumeration paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = (String) paramNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            if (paramValues.length == 1) {
                String paramValue = paramValues[0];
                if (paramValue.length() != 0) {
                    config.put(paramName, paramValue);
                }
            }
        }
        return config;
    }

    public Map<String, Object> query(HashMap<String, Object> params) throws AppException {
        Map<String, Object> resmap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String audittype = (String) params.get("audittype");
        String agency = (String) params.get("agency");
        String nodeguid = (String) params.get("nodeguid");
        resmap.putAll(pmkpiPerfAuditBO.getTableData(mainguid, audittype, agency, nodeguid));
        resmap.put("status", "1");
        return resmap;
    }

    public Map<String, Object> save(HashMap<String, Object> param) throws AppException {
        Map<String, Object> data = new HashMap();
        data = pmkpiPerfAuditBO.save(param);
        data.put("status", "1");
        return data;

    }
    public void setPmkpiPerfAuditBO(PmkpiPerfAuditBO pmkpiPerfAuditBO) {
        this.pmkpiPerfAuditBO = pmkpiPerfAuditBO;
    }

    /**
     * 事前绩效评估审核页面，审核时判断是否上传附件
     * @param params
     */
    public Map<String, Object> queryFileCount(HashMap<String,Object> params){
        Integer integer = pmkpiPerfAuditBO.queryFileCount(params);
        Map<String, Object> backmap = new HashMap<>();
        backmap.put("result",integer);
        return backmap;
    }

}
