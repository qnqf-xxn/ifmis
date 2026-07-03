package gov.mof.fasp2.pmkpi.setting.casepage.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CaseCheckService extends PmkpiService {
    private CaseReportBO caseReportBO;

    public void setCaseReportBO(CaseReportBO caseReportBO) {
        this.caseReportBO = caseReportBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String bustype = request.getParameter("bustype");
        String leftmenuid = request.getParameter("leftmenuid");
        String isCasetype = request.getParameter("isCasetype");
        String leftsource = request.getParameter("leftsource");
        config.put("workflow", workflow);
        config.put("bustype", bustype);
        config.put("leftmenuid", leftmenuid);
        config.put("isCasetype", isCasetype);
        config.put("leftsource", leftsource);
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> datatype = dss.getRangesByWhereSql("PERFDATATYPE", " guid in('2','3')");
        config.put("datatype", datatype);
        return config;
    }

    /**
     * 保存调整数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> saveAdjuctCase(HashMap<String,Object> parms) throws AppException {
        return caseReportBO.saveAdjuctCase(parms);
    }
}
