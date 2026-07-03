package gov.mof.fasp2.pmkpi.perfself.tab;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;


public class SelfFundManagService extends PmkpiService {
    private SelfFundManagBO selfFundManagBO;

    public void setSelfFundManagBO(SelfFundManagBO selfFundManagBO) {
        this.selfFundManagBO = selfFundManagBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String procode = request.getParameter("procode");
        String viewtype = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency");
        String busguid = request.getParameter("busguid");
        String bustype = request.getParameter("bustype");
        config.put("mainguid", mainguid);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency);
        config.put("busguid", busguid);
        config.put("bustype", bustype);
        config.put("procode", procode);
        return config;
    }

    /**
     * 保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = selfFundManagBO.saveData(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询资金情况
     * @param parms -- 参数.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return selfFundManagBO.getDatas(parms);
    }

}
