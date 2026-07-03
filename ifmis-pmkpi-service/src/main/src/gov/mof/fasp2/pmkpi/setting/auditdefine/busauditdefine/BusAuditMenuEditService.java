package gov.mof.fasp2.pmkpi.setting.auditdefine.busauditdefine;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class BusAuditMenuEditService extends PmkpiService {
    private BusAuditDefineBO busAuditDefineBO;

    public void setBusAuditDefineBO(BusAuditDefineBO busAuditDefineBO) {
        this.busAuditDefineBO = busAuditDefineBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuid = request.getParameter("menuid");
        String levelno = request.getParameter("levelno");
        Map<String, Object> map = busAuditDefineBO.getEditData(menuid);
        config.put("infodata",map);
        config.put("levelno",levelno);
        return config;
    }

    /**
     * 审核定义扩展菜单保存 / 修改
     * @param parms --
     * @return --
     */
    public Map<String, Object> infosave(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            busAuditDefineBO.infosave(parms);
            rs.put("success", true);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
