package gov.mof.fasp2.pmkpi.deptperformance.task;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptTaskService extends PmkpiService {
    private DeptTaskBO deptTaskBO;

    public void setDeptTaskBO(DeptTaskBO deptTaskBO) {
        this.deptTaskBO = deptTaskBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String pagetype = request.getParameter("pagetype");
        String workflow = request.getParameter("workflow");
        String checksuperid = request.getParameter("checksuperid");
        String mainguid = request.getParameter("mainguid");
        String agency = request.getParameter("saveAgency");
        String busguid = request.getParameter("busguid");
        String viewtype = request.getParameter("viewtype");
        config.put("mainguid", mainguid);
        config.put("agency", agency);
        config.put("pagetype", pagetype);
        config.put("workflow",workflow);
        config.put("busguid",busguid);
        config.put("checksuperid",checksuperid);
        config.put("viewtype", viewtype);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptTaskBO.getData(parms);
    }

    /**
     * 保存
     * @param params --
     * @return
     * @throws AppException
     */
	public Map save(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptTaskBO.save(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
	}

}
