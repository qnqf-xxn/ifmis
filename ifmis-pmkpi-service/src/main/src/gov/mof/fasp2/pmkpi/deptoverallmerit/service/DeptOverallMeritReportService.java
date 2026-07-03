package gov.mof.fasp2.pmkpi.deptoverallmerit.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.deptoverallmerit.bo.DeptOverallMeritReportBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptOverallMeritReportService extends PmkpiService {
    private DeptOverallMeritReportBO deptOverallMeritReportBO;

    public void setDeptOverallMeritReportBO(DeptOverallMeritReportBO deptOverallMeritReportBO) {
        this.deptOverallMeritReportBO = deptOverallMeritReportBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String tablecode = request.getParameter("tablecode");
        config.put("workflow", workflow);
        config.put("tablecode", tablecode);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptOverallMeritReportBO.getData(parms);
    }
 
    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptOverallMeritReportBO.wfAudit(params);
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
    		rs = deptOverallMeritReportBO.sendtonext(params);
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
    public Map<String, Object> sendToFinintorg(HashMap<String,Object> params) {
    	Map<String, Object> rs = new HashMap<String, Object>();
    	try {
    		rs = deptOverallMeritReportBO.sendToFinintorg(params);
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
    public Map<String, Object> checkSubmitstatus(HashMap<String,Object> params) {
    	Map<String, Object> rs = new HashMap<String, Object>();
    	try {
    		rs = deptOverallMeritReportBO.checkSubmitstatus(params);
    	} catch (AppException e) {
    		logger.error(e.getMessage(), e);
    	}
    	return rs;
    }

    public Map<String,Object> checkFile (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        rs = deptOverallMeritReportBO.checkFile(params);
        return rs;

    }
}
