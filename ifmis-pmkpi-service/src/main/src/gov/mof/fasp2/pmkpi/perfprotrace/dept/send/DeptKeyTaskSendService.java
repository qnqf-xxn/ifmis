package gov.mof.fasp2.pmkpi.perfprotrace.dept.send;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptKeyTaskSendService extends PmkpiService {
    private DeptKeyTaskSendBO deptKeyTaskSendBO;

    public void setDeptKeyTaskSendBO(DeptKeyTaskSendBO deptKeyTaskSendBO) {
        this.deptKeyTaskSendBO = deptKeyTaskSendBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }

    /**
     * <p>下达任务/取消下达</p >
     *
     * @param
     * @author hw
     * @date 2022/4/6 14:53
     */
    public Map<String, Object> sendtask(HashMap<String, Object> parms) throws AppException {
        return deptKeyTaskSendBO.sendtask(parms);
    }

}
