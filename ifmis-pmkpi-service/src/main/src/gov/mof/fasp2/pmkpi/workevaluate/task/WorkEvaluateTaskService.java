package gov.mof.fasp2.pmkpi.workevaluate.task;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class WorkEvaluateTaskService extends PmkpiService {

    private WorkEvaluateTaskBO workEvaluateTaskBO;

    public void setWorkEvaluateTaskBO(WorkEvaluateTaskBO workEvaluateTaskBO) {
        this.workEvaluateTaskBO = workEvaluateTaskBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("taskyear", CommonUtil.getYear());
        String bustype = request.getParameter("bustype");
        String tablecode = request.getParameter("tablecode");
        String taskprovince = request.getParameter("province");
        config.put("bustype",bustype);
        config.put("tablecode",tablecode);
        config.put("taskprovince",taskprovince);
        return config;
    }

    /**
     * 查询编辑区数据
     * @param params 参数
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<>();
        rs = workEvaluateTaskBO.queryeditdata(params);
        rs.put("success", true);
        return rs;
    }
    /**
     * 保存任务
     * @param params
     * @return
     */
    public Map<String,Object> infosave (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            workEvaluateTaskBO.saveTask(params);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 删除任务
     * @param params
     * @return
     */
    public Map<String,Object> delTask (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = workEvaluateTaskBO.delTask(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getMessage());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
    /**
     * 获取guid.
     * @return guid.
     * @throws AppException
     */
    public String getGuid() throws AppException{
        return workEvaluateTaskBO.getCreateguid();
    }
}
