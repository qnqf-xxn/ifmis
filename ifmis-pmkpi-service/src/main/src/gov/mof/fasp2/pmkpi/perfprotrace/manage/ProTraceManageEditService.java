package gov.mof.fasp2.pmkpi.perfprotrace.manage;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProTraceManageEditService extends PmkpiService {
    private ProTraceManageBO proTraceManageBO;

    public void setProTraceManageBO(ProTraceManageBO proTraceManageBO) {
        this.proTraceManageBO = proTraceManageBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String pagetype = request.getParameter("pagetype");
        String taskguid = request.getParameter("taskguid");
        String tabcode = request.getParameter("tabcode");
        String prolev = request.getParameter("prolev");
        String tasktype = request.getParameter("tasktype");
        String tablecode = request.getParameter("tablecode");
        String taskstage = request.getParameter("taskstage");
        String tasksname = request.getParameter("tasksname");
        String tasksenddate = request.getParameter("tasksenddate");
        String isSx = PerfUtil.getSystemSet("isSX");
        config.put("isSx",isSx);  //是否山西模式
        config.put("isdismodel", PerfUtil.getDismodel());
        config.put("pagetype", pagetype);
        config.put("taskguid", taskguid);
        config.put("tabcode", tabcode);
        config.put("prolev", prolev);
        config.put("tasktype", tasktype);
        config.put("tablecode", tablecode);
        config.put("taskstage", taskstage);
        config.put("tasksname", tasksname);
        config.put("tasksenddate", tasksenddate);
        return config;
    }

    /**
     * 保存绩效监控
     * @param parms --
     * @return
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        return proTraceManageBO.save(parms);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms) throws AppException {
        return proTraceManageBO.del(parms);
    }


    /**
     * 根据业务类型查询任务.
     * @param taskguid --任务guid
     * @return
     */
    public List<Map<String, Object>> getTaskByBusType(String taskguid){
        return proTraceManageBO.getTaskByBusType(taskguid);
    }

    /**
     * 复制任务
     * @param parms
     * @return
     */
    public Map<String, Object> taskCopy(HashMap<String,Object> parms) throws AppException {
        return proTraceManageBO.taskCopy(parms);
    }

    /**
     * 校验任务是否可删除
     * @param parms --
     * @return
     */
    public int checkdeltask(HashMap<String,Object> parms){
        return proTraceManageBO.checkdeltask(parms);
    }

    /**
     * 获取任务布置页面左侧树数据
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap params) throws AppException {
        return proTraceManageBO.getTreeData(params);
    }

    /**
     * 获取是否标记重点数据
     * @return
     */
    public List<Map<String, Object>> getProDatas(HashMap<String, Object> params){
        return proTraceManageBO.getProDatas(params);
    }
}
