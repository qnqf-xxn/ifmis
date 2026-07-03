package gov.mof.fasp2.pmkpi.evaluation.dept.third;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * <p></p >
 *
 * @author hw
 * @date 2022/12/6 15:32
 */
public class ThirdPartyService extends PmkpiService {
    private ThirdPartyBO thirdPartyBO;

    public void setThirdPartyBO(ThirdPartyBO thirdPartyBO) {
        this.thirdPartyBO = thirdPartyBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String viewtype = request.getParameter("viewtype");
//        String busguid = request.getParameter("busguid");
        config.put("mainguid", mainguid);
        config.put("viewtype", viewtype); //查询还是编辑
//        config.put("busguid", busguid);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return thirdPartyBO.getData(parms);
    }
    
    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = thirdPartyBO.save(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
