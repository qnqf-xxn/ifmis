package gov.mof.fasp2.pmkpi.autoview;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ReportService extends PmkpiService {

    private ReportBO reportBO;
    public void setReportBO(ReportBO reportBO) {
        this.reportBO = reportBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String querykey = request.getParameter("querykey");
        config.put("querykey",querykey);
        config.put("querydata", reportBO.getQueryFrom(querykey));
        config.put("tabledata", reportBO.getTable(querykey));
        config.put("coldatas", reportBO.getCols(querykey));
        return config;
    }
}
