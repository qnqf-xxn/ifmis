package gov.mof.fasp2.pmkpi.evaluation.financial.deptfill;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptScoreService extends PmkpiService {
    private DeptfillBO deptfillBO;

    public void setDeptfillBO(DeptfillBO deptfillBO) {
        this.deptfillBO = deptfillBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String saveAgency = request.getParameter("saveAgency");
        String bustype = request.getParameter("bustype");
        String busguid = request.getParameter("busguid");
        String proguid = request.getParameter("proguid");
        String viewtype = request.getParameter("viewtype");
        String pagetype = request.getParameter("pagetype");
        config.put("mainguid", mainguid);
        config.put("bustype", bustype + "evaluatescore");
        config.put("saveAgency", saveAgency);
        config.put("busguid", busguid);
        config.put("proguid", proguid);
        config.put("viewtype", viewtype);
        config.put("pagetype", pagetype);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptfillBO.getData(parms);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptfillBO.save(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
