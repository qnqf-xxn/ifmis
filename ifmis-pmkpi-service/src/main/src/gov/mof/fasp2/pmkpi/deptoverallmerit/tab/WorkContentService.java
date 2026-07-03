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
public class WorkContentService extends PmkpiService {
    private WorkContentBO workContentBO;

    public void setWorkContentBO(WorkContentBO workContentBO) {
        this.workContentBO = workContentBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String projguid = request.getParameter("projguid");
        String viewtype = request.getParameter("viewtype");
        String contenttype = request.getParameter("contenttype");
        config.put("mainguid", mainguid);
        config.put("projguid", projguid);
        config.put("viewtype", viewtype);
        config.put("contenttype", contenttype);

        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return workContentBO.getData(parms);
    }
    
    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        return workContentBO.save(parms);
    }

}
