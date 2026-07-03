package gov.mof.fasp2.pmkpi.deptoverallmerit.tab;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:44 2020/8/24  chongdayong
 */
public class DeptScoreService extends PmkpiService {
    private DeptScoreBO deptScoreBO;

    public void setDeptScoreBO(DeptScoreBO deptScoreBO) {
        this.deptScoreBO = deptScoreBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String projguid = request.getParameter("projguid");
        String tablecode = request.getParameter("tablecode");
        String bustype = request.getParameter("bustype");
        String saveAgency = request.getParameter("saveAgency");
        String viewtype = request.getParameter("viewtype");
        String querytype = request.getParameter("querytype");
        config.put("mainguid", mainguid);
        config.put("projguid", projguid);
        config.put("tablecode", tablecode);
        config.put("saveAgency", saveAgency);
        config.put("viewtype", viewtype);
        config.put("querytype", querytype);
        config.put("bustype", bustype);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptScoreBO.getData(parms);
    }
    
    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        return deptScoreBO.save(parms);
    }

}
