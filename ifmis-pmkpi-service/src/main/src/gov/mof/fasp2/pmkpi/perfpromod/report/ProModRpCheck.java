package gov.mof.fasp2.pmkpi.perfpromod.report;

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
public class ProModRpCheck extends PmkpiService {
    /**
     * 注入bo.
     */
    private ProModRpBO proModRpBO;

    public void setProModRpBO(ProModRpBO proModRpBO) {
        this.proModRpBO = proModRpBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String prolev = request.getParameter("prolev");
        String saveAgency = request.getParameter("saveAgency");
        String columncode = request.getParameter("columncode");
        String bustype = request.getParameter("bustype");
        String isleaf = request.getParameter("isleaf");
        String modtype = request.getParameter("modtype");
        config.put("workflow", workflow);
        config.put("prolev", prolev);
        config.put("saveAgency", saveAgency);
        config.put("columncode", columncode);
        config.put("bustype", bustype);
        config.put("isleaf", isleaf);
        config.put("modtype", modtype);
        return config;
    }


    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getProgramDatas(HashMap<String,Object> parms) throws AppException {
        return proModRpBO.getProgramDatas(parms);
    }

    /**
     * 保存调整数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> saveProgramadjust(HashMap<String,Object> parms) throws AppException {
        return proModRpBO.saveProgramadjust(parms);
    }

}
