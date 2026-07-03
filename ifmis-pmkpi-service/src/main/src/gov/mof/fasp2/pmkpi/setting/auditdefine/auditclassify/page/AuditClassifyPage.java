package gov.mof.fasp2.pmkpi.setting.auditdefine.auditclassify.page;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class AuditClassifyPage extends PmkpiPage {

    /**
     * 审核定义分类
     * @param request
     * @param response
     * @param config
     * @return
     * @throws AppException
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        return config;
    }

}
