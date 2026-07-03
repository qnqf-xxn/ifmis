package gov.mof.fasp2.pmkpi.setting.indexlib.finagive;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author GM
 * @data 2022/4/12
 * @apiNote
 **/
public class IndFinaGiveEdit extends PmkpiService {
    /**
     * 注入bo.
     */
    private IndFinaGiveBO indFinaGiveBO;

    public void setIndFinaGiveBO(IndFinaGiveBO indFinaGiveBO) {
        this.indFinaGiveBO = indFinaGiveBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        indFinaGiveBO.getInitData(config);
        return config;
    }

    /**
     * 查询部门授权的分类有哪些。
     * @param params -- 参数.
     * @return list.
     */
    public List findDeptEles(HashMap<String,Object> params) {
        return indFinaGiveBO.findDeptEles(params);
    }

    /**
     * 保存授权分类内容.
     * @param params -- 参数
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map<String, Object> saveFinaGive(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            indFinaGiveBO.saveFinaGive(params);
            rs.put("flag",true);
        } catch (AppException e) {
            rs.put("flag",false);
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
