package gov.mof.fasp2.pmkpi.evaluation.financial.relation;

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
        String saveAgency = request.getParameter("saveAgency"); //主键
        String mainguid = request.getParameter("mainguid"); //主键
        String proguid = request.getParameter("projguid"); //调整项目guid
        String workflow = request.getParameter("workflow"); //审核定义的guid
        String prolev = request.getParameter("prolev"); //项目一二三级
        String procode = request.getParameter("projcode");
        String bustype = request.getParameter("bustype");
        String viewtype = request.getParameter("viewtype"); //页面状态，修改/查看
        String leftmenuid = request.getParameter("leftmenuid"); //菜单guid
        config.put("leftmenuid", leftmenuid);
        config.put("mainguid", mainguid);
        config.put("viewtype",viewtype);
        config.put("procode", procode);
        return config;
    }

    /**
     * <p>删除关联项目</p >
     *
     * @param
     * @author hw
     * @date 2022/4/8 10:48
     */
    public Map<String, Object> del(HashMap<String, Object> parms) throws AppException {
        return proRelationBO.del(parms);
    }

}
