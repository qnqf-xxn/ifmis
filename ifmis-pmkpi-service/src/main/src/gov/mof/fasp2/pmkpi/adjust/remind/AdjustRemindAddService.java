package gov.mof.fasp2.pmkpi.adjust.remind;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AdjustRemindAddService   extends PmkpiService {
    private AdjustRemindAddBO adjustRemindAddBO;

    public void setAdjustRemindAddBO(AdjustRemindAddBO adjustRemindAddBO) {
        this.adjustRemindAddBO = adjustRemindAddBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String proguid = request.getParameter("proguid");
        String mainguid = request.getParameter("mainguid");
        String agencyguid = request.getParameter("agencyguid");
        String finintorgguid = request.getParameter("finintorgguid");
        config.put("proguid",proguid);
        config.put("mainguid",mainguid);
        config.put("agencyguid",agencyguid);
        config.put("finintorgguid",finintorgguid);
        return config;
    }

    /**
     * 保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map save(HashMap config) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = adjustRemindAddBO.infosave(config);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
