package gov.mof.fasp2.pmkpi.deptoverallmerit.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.deptoverallmerit.bo.DeptOverallMeritManageBO;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeptOverallMeritManageService extends PmkpiService {
    private DeptOverallMeritManageBO deptOverallMeritManageBO;

    public void setDeptOverallMeritManageBO(DeptOverallMeritManageBO deptOverallMeritManageBO) {
        this.deptOverallMeritManageBO = deptOverallMeritManageBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String tablecode = request.getParameter("tablecode");
        String bustype = request.getParameter("bustype");
        String fromtables = request.getParameter("fromtables");
        String modelguid = request.getParameter("modelguid");
        config.put("workflow", workflow);
        config.put("tablecode", tablecode);
        config.put("bustype", bustype);
        config.put("fromtables", fromtables);
        config.put("modelguid", modelguid);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptOverallMeritManageBO.getData(parms);
    }

    /**
     * 保存
     * @param parms --
     * @return
     */
    public Map<String, Object> saveTask(HashMap<String,Object> parms) throws AppException {
        return deptOverallMeritManageBO.saveTask(parms);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
        return deptOverallMeritManageBO.del(parms);
    }
}
