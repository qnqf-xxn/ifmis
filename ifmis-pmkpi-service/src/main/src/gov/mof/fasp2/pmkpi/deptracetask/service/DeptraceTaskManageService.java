package gov.mof.fasp2.pmkpi.deptracetask.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.deptracetask.bo.DeptraceTaskManageBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptraceTaskManageService extends PmkpiService {
    private DeptraceTaskManageBO deptraceTaskManageBO;

    public void setDeptraceTaskManageBO(DeptraceTaskManageBO deptraceTaskManageBO) {
        this.deptraceTaskManageBO = deptraceTaskManageBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String tablecode = request.getParameter("tablecode");
        config.put("workflow", workflow);
        config.put("tablecode", tablecode);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptraceTaskManageBO.getData(parms);
    }

    /**
     * 保存绩效监控
     * @param parms --
     * @return
     */
    public Map<String, Object> saveTask(HashMap<String,Object> parms) throws AppException {
        return deptraceTaskManageBO.saveTask(parms);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
        return deptraceTaskManageBO.del(parms);
    }
}
