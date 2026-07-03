package gov.mof.fasp2.pmkpi.setting.taskset;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TaskSetService extends PmkpiService {
    private TaskSetBO taskSetBO;

    public void setTaskSetBO(TaskSetBO taskSetBO) {
        this.taskSetBO = taskSetBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }

    /**
     * 查询
     * @param params
     * @return
     */
    public List<Map<String, Object>> getData(HashMap<String, Object> params) throws AppException {
        return taskSetBO.getData(params);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
        return taskSetBO.del(parms);
    }

    /**
     * 校验任务是否可删除
     * @param parms --
     * @return
     */
    public int checkdel(HashMap<String,Object> parms){
        return taskSetBO.checkdel(parms);
    }
}
