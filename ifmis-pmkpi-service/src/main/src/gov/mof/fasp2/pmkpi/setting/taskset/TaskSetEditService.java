package gov.mof.fasp2.pmkpi.setting.taskset;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 21:14 2020/8/17  chongdayong
 */
public class TaskSetEditService extends PmkpiService {
    private TaskSetBO taskSetBO;

    public void setTaskSetBO(TaskSetBO taskSetBO) {
        this.taskSetBO = taskSetBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String treeid = request.getParameter("treeid");
        String bustype = request.getParameter("bustype");
        String pagetype = request.getParameter("pagetype");
        String guid = request.getParameter("guid");
        config.put("treeid", treeid);
        config.put("bustype", bustype);
        config.put("pagetype", pagetype);
        config.put("guid", guid);
        if (pagetype != null && "mod".equals(pagetype)) {
            config.put("taskdata", taskSetBO.getDataByGuid(config));
        }
        return config;
    }

    /**
     * 保存指标数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        try {
            taskSetBO.save(params);
            backMap.put("success", true);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
}
