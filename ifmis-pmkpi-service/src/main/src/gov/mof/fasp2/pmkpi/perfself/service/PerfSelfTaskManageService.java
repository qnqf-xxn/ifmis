package gov.mof.fasp2.pmkpi.perfself.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfself.bo.PerfSelfTaskManageBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfSelfTaskManageService extends PmkpiService {
    private PerfSelfTaskManageBO perfSelfTaskManageBO;

    public void setPerfSelfTaskManageBO(PerfSelfTaskManageBO perfSelfTaskManageBO) {
        this.perfSelfTaskManageBO = perfSelfTaskManageBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("deptqfdatas", perfSelfTaskManageBO.getQueryFrom("/pmkpi/perfselftaskmanage/dept"));
        config.put("proqfdatas", perfSelfTaskManageBO.getQueryFrom("/pmkpi/perfselftaskmanage/index"));
        return config;
    }


    /**
     * 保存
     * @param parms --
     * @return
     */
    public Map<String, Object> saveTask(HashMap<String,Object> parms) throws AppException {
        return perfSelfTaskManageBO.saveTask(parms);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> delTask(HashMap<String,Object> parms){
        return perfSelfTaskManageBO.delTask(parms);
    }

    /**
     * <p>左侧树-整合菜单首次进入页面</p >
     *
     * @author hw
     * @date 2021/7/17 16:06
     * @param
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return perfSelfTaskManageBO.getTreeData(params);
    }

    /**
     * 标记、取消标记项目
     * @param
     */
    public Map<String, Object> provincetask (HashMap<String, Object> params) throws AppException {
        return perfSelfTaskManageBO.provincetask(params);
    }
}
