package gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProConfirmCheckService extends PmkpiService {
    private ProConfirmBO proConfirmBO;

    public void setProConfirmBO(ProConfirmBO proConfirmBO) {
        this.proConfirmBO = proConfirmBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String prolev = request.getParameter("prolev");
        String saveAgency = request.getParameter("saveAgency");
        String bustype = request.getParameter("bustype");
        String leftmenuid = request.getParameter("leftmenuid");
        String defquery = request.getParameter("defquery");
        String tablesql = request.getParameter("tablesql");
        config.put("workflow", workflow);
        config.put("prolev", prolev);
        config.put("saveAgency", saveAgency);
        config.put("bustype", bustype);
        config.put("leftmenuid", leftmenuid);
        config.put("defquery", defquery);
        config.put("tablesql", tablesql);
        return config;
    }

    /**
     * 保存数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> saveProgramProConfirm(HashMap<String,Object> parms) throws AppException {
        return proConfirmBO.saveProgramProConfirm(parms);
    }

}
