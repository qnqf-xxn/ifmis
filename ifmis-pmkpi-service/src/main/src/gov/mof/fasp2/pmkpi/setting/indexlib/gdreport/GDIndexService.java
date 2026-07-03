package gov.mof.fasp2.pmkpi.setting.indexlib.gdreport;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class GDIndexService extends PmkpiService {

    private GDIndexBO gdIndexBO;

    public void setGDIndexBO(GDIndexBO gdIndexBO) {
        this.gdIndexBO = gdIndexBO;
    }


    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("coldatas", gdIndexBO.getCols("/pmkpi/setting/gd/gdindex"));
        config.put("tabledatas", gdIndexBO.getTable("/pmkpi/setting/gd/gdindex"));
        config.put("qfdatas", gdIndexBO.getQueryFrom("/pmkpi/setting/gd/gdindex"));
        return config;
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> delDatas(HashMap<String,Object> parms){
        return gdIndexBO.delDatas(parms);
    }
}
