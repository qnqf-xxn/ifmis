package gov.mof.fasp2.pmkpi.perfprotrace.dept.task;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptTaskService extends PmkpiService {
    private DeptTaskBO deptTaskBO;

    public void setDeptTaskBO(DeptTaskBO deptTaskBO) {
        this.deptTaskBO = deptTaskBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String mainguid = request.getParameter("mainguid"); //主键
        String proguid = request.getParameter("projguid"); //调整项目guid
        config.put("mainguid",mainguid);
        config.put("proguid",proguid);
        return config;
    }

}
