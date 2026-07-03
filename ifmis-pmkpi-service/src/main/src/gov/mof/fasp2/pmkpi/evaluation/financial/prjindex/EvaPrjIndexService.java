package gov.mof.fasp2.pmkpi.evaluation.financial.prjindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;


public class EvaPrjIndexService extends PmkpiService {

    private EvaPrjIndexBO evaPrjIndexBO;

    public void setEvaPrjIndexBO(EvaPrjIndexBO evaPrjIndexBO) {
        this.evaPrjIndexBO = evaPrjIndexBO;
    }

    //评价模板表
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String tokenid = request.getParameter("tokenid");// 登录凭证
        String tabcode = request.getParameter("tabcode");
        config.put("tokenid", tokenid);
        config.put("tabcode", tabcode);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getData(HashMap<String,Object> parms) throws AppException {
        return evaPrjIndexBO.getData(parms);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = evaPrjIndexBO.save(parms);
            rs.put("success", true);
            rs.put("code","保存成功！");
        } catch (PerfAppException e) {
            rs.put("success", "false");
            rs.put("code",e.getCode());
        } catch (AppException e) {
            e.printStackTrace();
        }
        return rs;
    }
    public String getMaxcode(HashMap<String,Object> parms) throws AppException {
        return evaPrjIndexBO.getMaxcode(parms);
    }

}
