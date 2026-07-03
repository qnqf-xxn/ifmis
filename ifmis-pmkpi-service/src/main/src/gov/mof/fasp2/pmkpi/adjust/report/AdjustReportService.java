package gov.mof.fasp2.pmkpi.adjust.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdjustReportService extends PmkpiService {
    private AdjustReportBO adjustReportBO;

    public void setAdjustReportBO(AdjustReportBO adjustReportBO) {
        this.adjustReportBO = adjustReportBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("deptqfdatas", adjustReportBO.getQueryFrom("/pmkpi/adjust/report/dept"));
        config.put("proqfdatas", adjustReportBO.getQueryFrom("/pmkpi/adjust/report/program"));
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return adjustReportBO.getTreeData(params);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = adjustReportBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> deladjust(HashMap<String,Object> parms){
        return adjustReportBO.deladjust(parms);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> delWFAction(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = adjustReportBO.delWFAction(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

//    public Map<String, Object> checkFileData (HashMap<String, Object> params) throws AppException {
//        return adjustReportBO.checkFileData(params);
//    }
}
