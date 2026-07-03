package gov.mof.fasp2.pmkpi.prorevision.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:53 2020/8/27  chongdayong
 */
public class ProrevisionCheckService extends PmkpiService {
    /**
     * 注入bo.
     */
    private ProrevisionCheckBO revisionCheckBO;

    public void setRevisionCheckBO(ProrevisionCheckBO revisionCheckBO) {
        this.revisionCheckBO = revisionCheckBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String prolev = request.getParameter("prolev");
        String saveAgency = request.getParameter("saveAgency");
        String bustype = request.getParameter("bustype");
        String leftmenuid = request.getParameter("leftmenuid");
        config.put("workflow", workflow);
        config.put("prolev", prolev);
        config.put("saveAgency", saveAgency);
        config.put("bustype", bustype);
        config.put("leftmenuid", leftmenuid);
        return config;
    }

    /**
     * 保存调整数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> saveProgramadjust(HashMap<String,Object> parms) throws AppException {
        return revisionCheckBO.saveProgramadjust(parms);
    }

}
