package gov.mof.fasp2.pmkpi.deptTJformance.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptTJPerftofinintorgService extends PmkpiService {
    private DeptTJPerftofinintorgBO deptTJPerftofinintorgBO;

    public void setDeptTJPerftofinintorgBO(DeptTJPerftofinintorgBO deptTJPerftofinintorgBO) {
        this.deptTJPerftofinintorgBO = deptTJPerftofinintorgBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        config.put("mainguid",mainguid);
        return config;
    }
    
    /**
     * 确认分发/取消分发
     * @param params --
     * @return --
     */
    public Map<String, Object> tofinintorg(HashMap<String,Object> params) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        try {
            backmap = deptTJPerftofinintorgBO.tofinintorg(params);
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code",e.getCode());
        } catch (AppException e) {
            backmap.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

}
