package gov.mof.fasp2.pmkpi.setting.zjtempdata;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ZjTempDataService extends PmkpiService {
    private ZjTempDataBO zjTempDataBO;

    public void setZjTempDataBO(ZjTempDataBO zjTempDataBO) {
        this.zjTempDataBO = zjTempDataBO;
    }

    /**
     * 加载页面内容.
     * @param request --请求
     * @param response -- 响应
     * @param config -- 配置
     * @return
     * @throws Exception
     */
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("province", CommonUtil.getProvince());
        config.put("IS_HUBEI", PerfUtil.getIS_HUBEI());
        config.put("isZJ", PerfUtil.getSystemSet("isZJ"));
        config.put("IS_SX", PerfUtil.getIsSx());
        return config;
    }
    /**
     * 查询数据.
     * @param params
     * @return
     */
    public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
        return zjTempDataBO.getDatas(params);
    }
    /**
     * 以区划，年度，guid为主键的增删改
     * @param params
     * @return
     */
    public Map<String, Object> savemajorkey(Map<String, Object> params){
        Map<String, Object> remp = new HashMap<String, Object>();
        try{
            zjTempDataBO.savemajorkey(params);
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
     * 获取项目编码最大数.
     * @param params -- 前端参数.
     * @return
     */
    public String getMaxcode(HashMap<String, Object> params) throws AppException {
        return zjTempDataBO.getMaxcode(params);
    }

    /**
     * 湖北模式判断
     * @param params
     * @return
     * @throws AppException
     */
    public int isCanDelete(HashMap<String, Object> params) throws AppException {
        return zjTempDataBO.isCanDelete(params);
    }
}
