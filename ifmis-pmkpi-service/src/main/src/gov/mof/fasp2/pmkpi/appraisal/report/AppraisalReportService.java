package gov.mof.fasp2.pmkpi.appraisal.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AppraisalReportService extends PmkpiService {

    private AppraisalReportBO appraisalReportBO;

    public void setAppraisalReportBO(AppraisalReportBO appraisalReportBO) {
        this.appraisalReportBO = appraisalReportBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("workflow", request.getParameter("workflow"));
        List list = PerfUtil.getSourceData(AppraisalReportDAO.AGENCY_SOURCE, null);
        Map<String, Object> map = new HashMap<>();
        for (Object obj : list) {
            Map m = (Map) obj;
            map.put((String) m.get("guid"), m.get("finintorg"));
        }
        config.put("finintorgs", map);
        return config;
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            appraisalReportBO.save(parms);
            rs.put("success", true);
            rs.put("msg","保存成功！");
        } catch (PerfAppException e) {
            rs.put("success", false);
            rs.put("msg",e.getCode());
        } catch (AppException e) {
            rs.put("success", false);
            rs.put("msg",e.getMessage());
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
        return appraisalReportBO.del(parms);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = appraisalReportBO.wfAudit(params);
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
     * 根据单位编码，查询数据
     * @param params
     * @return
     */
    public Map<String, Object> getDataByAgencyCode(HashMap<String,Object> params) {
        return appraisalReportBO.getDataByAgencyCode(params);
    }
}
