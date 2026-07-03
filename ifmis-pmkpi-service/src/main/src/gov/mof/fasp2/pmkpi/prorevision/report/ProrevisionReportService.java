package gov.mof.fasp2.pmkpi.prorevision.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProrevisionReportService extends PmkpiService {
    private ProrevisionReportBO revisionReportBO;

    public void setRevisionReportBO(ProrevisionReportBO revisionReportBO) {
        this.revisionReportBO = revisionReportBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("deptqfdatas", revisionReportBO.getQueryFrom("/pmkpi/prorevision/report/dept"));
        config.put("proqfdatas", revisionReportBO.getQueryFrom("/pmkpi/prorevision/report/program"));
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return revisionReportBO.getTreeData(params);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = revisionReportBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getCode() + e.getMessage().replace(e.getCode(), ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> delrevision(HashMap<String,Object> parms){
        return revisionReportBO.delrevision(parms);
    }

}
