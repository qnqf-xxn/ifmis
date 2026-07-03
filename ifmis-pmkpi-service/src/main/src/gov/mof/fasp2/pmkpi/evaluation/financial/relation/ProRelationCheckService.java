package gov.mof.fasp2.pmkpi.evaluation.financial.relation;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProRelationCheckService extends PmkpiService {
    private ProRelationBO proRelationBO;

    public void setProRelationBO(ProRelationBO proRelationBO) {
        this.proRelationBO = proRelationBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid"); //主键
        String leftmenuid = request.getParameter("leftmenuid"); //主键
        config.put("leftmenuid", leftmenuid);
        config.put("mainguid", mainguid);
        return config;
    }

    /**
     * <p>保存关联项目</p >
     *
     * @author hw
     * @date 2022/4/12 14:13
     * @param
     */
    public Map<String, Object> saveProRelation(HashMap<String, Object> parms) throws AppException {
        return proRelationBO.saveProRelation(parms);
    }
}
