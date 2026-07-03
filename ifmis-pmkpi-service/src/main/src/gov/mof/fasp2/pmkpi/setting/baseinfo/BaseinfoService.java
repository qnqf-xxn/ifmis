package gov.mof.fasp2.pmkpi.setting.baseinfo;

import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class BaseinfoService extends PmkpiService {

    private BaseinfoBO baseinfoBO;

    public void setBaseinfoBO(BaseinfoBO baseinfoBO) {
        this.baseinfoBO = baseinfoBO;
    }


    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String isSX = PerfUtil.getSystemSet("isSX");
        config.put("isSx",isSX);
        return config;
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> delDatas(HashMap<String,Object> parms){
        return baseinfoBO.delDatas(parms);
    }
}
