package gov.mof.fasp2.pmkpi.setting.arrangement;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;


public class ArrangementService extends PmkpiService {

    private ArrangementBO arrangementBO;

    public void setArrangementBO(ArrangementBO arrangementBO) {
        this.arrangementBO = arrangementBO;
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
        return arrangementBO.getData(parms);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = arrangementBO.save(parms);
            rs.put("success", true);
            rs.put("code","保存成功！");
        } catch (PerfAppException e) {
            rs.put("success", "false");
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    public Map<String, Object> init(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = arrangementBO.init(parms);
            rs.put("code","初始化成功！");
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * .复制上年数据
     * @param parms --
     * @return --
     */
    public Map<String, Object> copyIndex(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        try {
            arrangementBO.copyIndex(parms);
            backMap.put("success", true);
            backMap.put("code","复制成功！");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * .获取最大的CODE
     * @param parms --
     * @return --
     */
    public String getMaxcode(HashMap<String,Object> parms) throws AppException {
        return arrangementBO.getMaxcode(parms);
    }
}
