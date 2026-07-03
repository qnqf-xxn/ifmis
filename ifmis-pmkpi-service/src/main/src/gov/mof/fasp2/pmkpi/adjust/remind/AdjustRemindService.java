package gov.mof.fasp2.pmkpi.adjust.remind;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdjustRemindService  extends PmkpiService {

    private AdjustRemindBO adjustRemindBO;

    public void setAdjustRemindBO(AdjustRemindBO adjustRemindBO) {
        this.adjustRemindBO = adjustRemindBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("deptcoldatas", adjustRemindBO.getCols("/pmkpi/adjust/report/dept"));
        config.put("depttabledata", adjustRemindBO.getTable("/pmkpi/adjust/report/dept"));
        config.put("deptqfdatas", adjustRemindBO.getQueryFrom("/pmkpi/adjust/report/dept"));
        config.put("procoldatas", adjustRemindBO.getCols("/pmkpi/adjust/report/program"));
        config.put("protabledata", adjustRemindBO.getTable("/pmkpi/adjust/report/program"));
        config.put("proqfdatas", adjustRemindBO.getQueryFrom("/pmkpi/adjust/report/program"));
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return adjustRemindBO.getTreeData(params);
    }
}
