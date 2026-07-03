package gov.mof.fasp2.pmkpi.deptperformance.func;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:44 2020/8/24  chongdayong
 */
public class DeptFuncService extends PmkpiService {
    private DeptFuncBO deptFuncBO;

    public void setDeptFuncBO(DeptFuncBO deptFuncBO) {
        this.deptFuncBO = deptFuncBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String proguid = request.getParameter("proguid");
        String saveAgency = request.getParameter("saveAgency");
        String viewtype = request.getParameter("viewtype");
        String busguid = request.getParameter("busguid");
        config.put("mainguid", mainguid);
        config.put("proguid", proguid);
        config.put("saveAgency", saveAgency);
        config.put("viewtype", viewtype);
        config.put("busguid", busguid);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptFuncBO.getData(parms);
    }

    /**
     * 查询职责数据.
     * @param params --
     * @return --
     */
    public String queryByFunctional(Map params) throws AppException {
        return deptFuncBO.queryByFunctional(params);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptFuncBO.save(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
