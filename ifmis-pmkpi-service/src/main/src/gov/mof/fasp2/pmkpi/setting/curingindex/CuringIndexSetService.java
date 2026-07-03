package gov.mof.fasp2.pmkpi.setting.curingindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;


public class CuringIndexSetService extends PmkpiService {

    private CuringIndexSetBO curingIndexSetBO;

    public void setCuringIndexSetBO(CuringIndexSetBO curingIndexSetBO) {
        this.curingIndexSetBO = curingIndexSetBO;
    }


    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String tokenid = request.getParameter("tokenid");// 登录凭证
        String tabcode = request.getParameter("tabcode");
        config.put("tokenid", tokenid);
        config.put("tabcode", tabcode);
        return config;
    }

    /**
     * 以区划，年度，guid为主键的增删改
     * @param params
     * @return
     */
    public Map<String, Object> savemajorkey(Map<String, Object> params){
        Map<String, Object> remp = new HashMap<String, Object>();
        try{
            curingIndexSetBO.savemajorkey(params);
            remp.put("success", true);
        } catch (PerfAppException e){
            remp = e.getRemap();
            remp.put("code", e.getCode());
        } catch(AppException e){
            logger.error(e.getMessage(), e);
        }
        return remp;
    }

    /**
     * 查询数据.
     * @param params
     * @return
     */
    public Map<String, Object> getDatas(HashMap<String, Object> params){
        return curingIndexSetBO.getDatas(params);
    }

}
