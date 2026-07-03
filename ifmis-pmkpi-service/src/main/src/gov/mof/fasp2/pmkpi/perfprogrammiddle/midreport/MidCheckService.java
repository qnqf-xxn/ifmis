package gov.mof.fasp2.pmkpi.perfprogrammiddle.midreport;

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
public class MidCheckService extends PmkpiService {
    /**
     * 注入bo.
     */
    private MidCheckBO midCheckBO;

    public void setMidCheckBO(MidCheckBO midCheckBO) {
        this.midCheckBO = midCheckBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String prolev = request.getParameter("prolev");
        String saveAgency = request.getParameter("saveAgency");
        String nodeguid = request.getParameter("nodeguid");
        String bustype = "program";
        String isleaf = request.getParameter("isleaf");
        config.put("workflow", workflow);
        config.put("prolev", prolev);
        config.put("saveAgency", saveAgency);
        config.put("nodeguid", nodeguid);
        config.put("bustype", bustype);
        config.put("isleaf", isleaf);
        return config;
    }

    /**
     * 保存调整数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> saveProgramadjust(HashMap<String,Object> parms) throws AppException {
        return midCheckBO.saveProgramadjust(parms);
    }

}
