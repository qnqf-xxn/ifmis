package gov.mof.fasp2.pmkpi.evaluation.dept.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptReportCheckService extends PmkpiService {
    private DeptReportBO deptReportBO;

    public void setDeptReportBO(DeptReportBO deptReportBO) {
        this.deptReportBO = deptReportBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String prolev = request.getParameter("prolev");
        String saveAgency = request.getParameter("saveAgency");
        String hidename = request.getParameter("hidename");//隐藏菜单名称
        String bustype = request.getParameter("bustype");
        String leftmenuid = request.getParameter("leftmenuid");
        config.put("workflow", workflow);
        config.put("prolev", prolev);
        config.put("saveAgency", saveAgency);
        config.put("bustype", bustype);
        config.put("hidename",hidename);
        config.put("leftmenuid", leftmenuid);
        return config;
    }

    /**
     * 保存数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> saveProgram(HashMap<String,Object> parms) throws AppException {
        return deptReportBO.saveProgram(parms);
    }
}
