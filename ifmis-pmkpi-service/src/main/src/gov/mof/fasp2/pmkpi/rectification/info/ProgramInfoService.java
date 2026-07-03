package gov.mof.fasp2.pmkpi.rectification.info;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProgramInfoService extends PmkpiService {

    private ProgramInfoBO programInfoBO;

    public void setProgramInfoBO(ProgramInfoBO programInfoBO) {
        this.programInfoBO = programInfoBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return super.loadComponent(request, response, config);
    }

    /**
     * 查询项目信息
     * @param params
     * @return
     */
    public Map<String,Object> queryProdata (HashMap<String, Object> params){
        return programInfoBO.queryProdata(params);
    }
}
