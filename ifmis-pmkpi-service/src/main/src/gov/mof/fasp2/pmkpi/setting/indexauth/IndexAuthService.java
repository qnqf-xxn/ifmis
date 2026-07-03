package gov.mof.fasp2.pmkpi.setting.indexauth;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 14:53 2020/8/17  chongdayong
 */
public class IndexAuthService extends PmkpiService {
    private IndexAuthBO indexAuthBO;

    public void setIndexAuthBO(IndexAuthBO indexAuthBO) {
        this.indexAuthBO = indexAuthBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("authtype", request.getParameter("authtype"));
        return config;
    }

    /**
     * 保存
     * @param params
     * @return
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            indexAuthBO.save(params);
            remp.put("success", true);
        } catch (PerfAppException e) {
            remp = e.getRemap();
            remp.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return remp;
    }


    /**
     * 查询
     * @param params
     * @return
     */
    public List<Map<String, Object>> getData(HashMap<String, Object> params) throws AppException {
        return indexAuthBO.getData(params);
    }

    /**
     * 开启关闭
     * @param params
     * @return
     * @throws Exception
     */
    public Map<String, Object> isopenandsown(HashMap<String, Object> params) throws Exception{
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            indexAuthBO.isopenandsown(params);
            remp.put("success", true);
        } catch (PerfAppException e) {
            remp = e.getRemap();
            remp.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return remp;
    }
}
