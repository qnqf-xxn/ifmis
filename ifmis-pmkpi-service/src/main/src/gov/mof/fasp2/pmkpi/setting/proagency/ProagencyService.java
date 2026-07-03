package gov.mof.fasp2.pmkpi.setting.proagency;


import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProagencyService extends PmkpiService {
    private ProagencyBO proagencyBO;
    public void setProagencyBO(ProagencyBO proagencyBO) {
        this.proagencyBO = proagencyBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return super.loadComponent(request, response, config);
    }

    /**
     * 删除数据
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
        return proagencyBO.delDatas(parms);
    }

    /**
      * 查询导入数据
     */
    public Map<String, Object> getImportData(){
        return proagencyBO.getImportData();
    }

    /**
     * 校验项目当前年度是否存在数据，确认是否更新
     * @param params --
     * @return --
     */
    public Map<String, Object> checkDataUpdate(HashMap<String, Object> params) throws AppException {
        return proagencyBO.checkDataUpdate(params);
    }

    /**
     * 导入数据保存
     * @param params --
     * @return --
     */
    public Map<String, Object> saveDatas(HashMap<String, Object> params) throws AppException {
        return proagencyBO.saveDatas(params);
    }

}
