package gov.mof.fasp2.pmkpi.setting.proagency;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProagencyEditService extends PmkpiService {

    private ProagencyBO proagencyBO;

    public void setProagencyBO(ProagencyBO proagencyBO) {
        this.proagencyBO = proagencyBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String rowtype = request.getParameter("rowtype");
        String tablecode = request.getParameter("tablecode");
        String guid = request.getParameter("guid");
        config.put("rowtype", rowtype);
        config.put("tablecode", tablecode);
        config.put("guid", guid);
        return config;
    }

    /**
     * 列表查询数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
        return proagencyBO.getDatas(params);
    }

    /**
     * 列表保存数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> saveDatas(HashMap<String, Object> params) throws AppException {
        return proagencyBO.saveDatas(params);
    }

    /**
     * 校验项目编码是否存在
     * @param params --
     * @return --
     */
    public Map<String, Object> checkData(HashMap<String, Object> params) throws AppException {
        return proagencyBO.checkData(params);
    }

    /**
     * 校验项目当前年度是否存在数据，确认是否更新
     * @param params --
     * @return --
     */
    public Map<String, Object> checkDataUpdate(HashMap<String, Object> params) throws AppException {
        return proagencyBO.checkDataUpdate(params);
    }
}
