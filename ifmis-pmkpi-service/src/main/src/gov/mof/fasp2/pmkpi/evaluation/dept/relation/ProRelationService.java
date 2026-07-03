package gov.mof.fasp2.pmkpi.evaluation.dept.relation;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProRelationService extends PmkpiService {
    private ProRelationBO proRelationBO;

    public void setProRelationBO(ProRelationBO proRelationBO) {
        this.proRelationBO = proRelationBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid"); //主键
        String procode = request.getParameter("projcode");
        String viewtype = request.getParameter("viewtype"); //页面状态
        String leftmenuid = request.getParameter("leftmenuid"); //菜单guid
        config.put("leftmenuid", leftmenuid);
        config.put("mainguid", mainguid);
        config.put("viewtype",viewtype);
        config.put("procode", procode);
        return config;
    }

    /**
     * 删除关联项目
     * @param
     * @author zxt
     * @date 2026/3/02 16:43
     */
    public Map<String, Object> del(HashMap<String, Object> parms) throws AppException {
        return proRelationBO.del(parms);
    }

}
