package gov.mof.fasp2.pmkpi.setting.perfcarryover;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class PerfCarryOverService extends PmkpiService {

    private PerfCarryOverBO perfCarryOverBO;

    public void setPerfCarryOverBO(PerfCarryOverBO perfCarryOverBO) {
        this.perfCarryOverBO = perfCarryOverBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String workflow = request.getParameter("workflow");
        String pagetype = request.getParameter("pagetype");
        String viewtype = request.getParameter("viewtype");
        String taskguid = request.getParameter("taskguid");
        String mainguid = request.getParameter("mainguid");
        config.put("workflow", workflow);
        config.put("pagetype", pagetype);
        config.put("viewtype", viewtype);
        config.put("taskguid", taskguid);
        config.put("mainguid", mainguid);
        String menuid = request.getParameter("menuId");
        return super.loadComponent(request, response, config);
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return perfCarryOverBO.getTreeData(params);
    }

    /**
     * 结转/取消结转
     * @param parms --
     * @return --
     */
    public Map<String, Object> carryover(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfCarryOverBO.carryover(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
