package gov.mof.fasp2.pmkpi.workevaluate.score;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class WorkEvaluateScoreService extends PmkpiService {
    private WorkEvaluateScoreBO workEvaluateScoreBO;

    public void setWorkEvaluateScoreBO(WorkEvaluateScoreBO workEvaluateScoreBO) {
        this.workEvaluateScoreBO = workEvaluateScoreBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String saveAgency = request.getParameter("saveAgency");
        String tasktype = request.getParameter("tasktype");
        String bustype = request.getParameter("bustype");
        String scoretype = "";
        if (bustype != null && "subprovince".equals(bustype)) {
            scoretype = request.getParameter("provincescoretype");
        } else {
            scoretype = request.getParameter("scoretype");
        }
        String busguid = request.getParameter("busguid");
        String viewtype = request.getParameter("viewtype");
        String subprovince = request.getParameter("subprovince");
        String pagetype = request.getParameter("pagetype");//页面类型，查询，audit审核，编辑
        config.put("mainguid", mainguid);
        config.put("tasktype", tasktype);
        config.put("saveAgency", saveAgency);
        config.put("busguid", busguid);
        config.put("viewtype", viewtype);
        config.put("scoretype", scoretype);
        config.put("bustype", bustype);
        config.put("subprovince", subprovince);
        config.put("pagetype", pagetype);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return workEvaluateScoreBO.getData(parms);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = workEvaluateScoreBO.save(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
