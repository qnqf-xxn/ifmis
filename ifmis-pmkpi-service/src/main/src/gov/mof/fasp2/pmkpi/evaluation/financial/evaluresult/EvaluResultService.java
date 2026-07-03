package gov.mof.fasp2.pmkpi.evaluation.financial.evaluresult;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * <p></p >
 *
 * @author hw
 * @date 2022/11/18 10:54
 */
public class EvaluResultService extends PmkpiService {
    private EvaluResultBO evaluResultBO;

    public void setEvaluResultBO(EvaluResultBO evaluResultBO) {
        this.evaluResultBO = evaluResultBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String proguid = request.getParameter("proguid");
        String procode = request.getParameter("procode");
        String viewtype = request.getParameter("viewtype");
        String busguid = request.getParameter("busguid");
//        String bustype = request.getParameter("bustype");
//        String saveAgency = request.getParameter("saveAgency");
//        config.put("bustype", bustype);
//        config.put("saveAgency", saveAgency); //单位
        config.put("mainguid", mainguid);
        config.put("proguid", proguid);
        config.put("procode", procode);
        config.put("viewtype", viewtype); //查询还是编辑
        config.put("busguid", busguid);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return evaluResultBO.getData(parms);
    }
    
    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        return evaluResultBO.save(parms);
    }

}
