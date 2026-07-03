package gov.mof.fasp2.pmkpi.deptoverallmerit.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.deptoverallmerit.bo.DeptOverallMeritAuditBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeptOverallMeritAuditService extends PmkpiService {
    private DeptOverallMeritAuditBO deptOverallMeritAuditBO;

    public void setDeptOverallMeritAuditBO(DeptOverallMeritAuditBO deptOverallMeritAuditBO) {
        this.deptOverallMeritAuditBO = deptOverallMeritAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String guid = request.getParameter("guid");
        String workflow = request.getParameter("workflow");
        String tablecode = request.getParameter("tablecode");
        String wfstatus = request.getParameter("wfstatus");
        String audittype = request.getParameter("audittype");
        String nodeguid = request.getParameter("nodeguid");
        String uikey = request.getParameter("uikey");
        config.put("tablecode", tablecode);
        config.put("wfstatus", wfstatus);
        config.put("workflow", workflow);
        if (nodeguid == null || StringUtils.isEmpty(nodeguid) || audittype == null || StringUtils.isEmpty(audittype)) {
            List<Map<String, Object>> auditmain = deptOverallMeritAuditBO.queryPrevAuditType(workflow, wfstatus);
            if (auditmain.isEmpty()) {
//                audittype = "opinion";
            } else {
                audittype = auditmain.get(0).get("audittype") + "";
                nodeguid = auditmain.get(0).get("nodeguid") + "";
            }
        }
        config.put("guid", guid);
        config.put("audittype", audittype);
        config.put("nodeguid", nodeguid);
        config.put("agency", request.getParameter("agency"));
        config.put("uikey", uikey);
        return config;
    }

    public Map<String, Object> query(HashMap<String, Object> params) throws AppException {
        Map<String, Object> resmap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String audittype = (String) params.get("audittype");
        String agency = (String) params.get("agency");
        String nodeguid = (String) params.get("nodeguid");
        resmap.putAll(deptOverallMeritAuditBO.getTableData(mainguid, audittype, agency, nodeguid));
        resmap.put("status", "1");
        return resmap;
    }

    public Map<String, Object> save(HashMap<String, Object> param) throws AppException {
        Map<String, Object> data = new HashMap();
        data = deptOverallMeritAuditBO.save(param);
        data.put("status", "1");
        return data;

    }
    
    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptOverallMeritAuditBO.getData(parms);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptOverallMeritAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
    
    /**
     * 自评提交
     * @param params --
     * @return --
     */
    public Map<String, Object> sendtonext(HashMap<String,Object> params) {
    	Map<String, Object> rs = new HashMap<String, Object>();
    	try {
    		rs = deptOverallMeritAuditBO.sendtonext(params);
    	} catch (PerfAppException e) {
    		rs = e.getRemap();
    		rs.put("code",e.getCode());
    	} catch (AppException e) {
    		logger.error(e.getMessage(), e);
    	}
    	return rs;
    }
}
