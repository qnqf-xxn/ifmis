package gov.mof.fasp2.pmkpi.perfprotrace.deptsum;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptSumService extends PmkpiService {
    private DeptSumBO deptSumBO;

    public void setDeptSumBO(DeptSumBO deptSumBO) {
        this.deptSumBO = deptSumBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String bustype = request.getParameter("bustype");
        String mainguid = request.getParameter("mainguid");
        String proguid = request.getParameter("projguid");
        String taskguid = request.getParameter("taskguid");
        String busguid = request.getParameter("busguid");
        String saveAgency = request.getParameter("saveAgency");
        String viewtype = request.getParameter("viewtype");
        config.put("bustype", bustype);
        config.put("mainguid", mainguid);
        config.put("proguid", proguid);
        config.put("taskguid", taskguid);
        config.put("busguid", busguid);
        config.put("saveAgency", saveAgency);
        config.put("viewtype", viewtype);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptSumBO.getDatas(parms);
    }

    /**
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptSumBO.saveData(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
