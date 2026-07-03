package gov.mof.fasp2.pmkpi.perfself.tab;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * 评价基本信息
 */
public class SelfInfoService extends PmkpiService {
    private SelfInfoBO selfInfoBO;

    public void setSelfInfoBO(SelfInfoBO selfInfoBO) {
        this.selfInfoBO = selfInfoBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String projguid = request.getParameter("projguid");
        String bustype = request.getParameter("bustype");
        String viewtype = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency");
        String busguid = request.getParameter("busguid");
        String procode = request.getParameter("procode");
        config.put("mainguid", mainguid);
        config.put("projguid", projguid);
        config.put("bustype", bustype);
        config.put("viewtype", viewtype); //查询还是编辑
        config.put("saveAgency", saveAgency); //单位
        config.put("busguid", busguid);
        config.put("procode", procode);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return selfInfoBO.getData(parms);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        return selfInfoBO.save(parms);
    }

}
