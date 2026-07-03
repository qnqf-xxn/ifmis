package gov.mof.fasp2.pmkpi.perfQuery.transPay;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class TransPayQueryService extends PmkpiService {

    private TransPayQueryBO transPayQueryBO;

    public void setTransPayQueryBO(TransPayQueryBO transPayQueryBO) {
        this.transPayQueryBO = transPayQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String type = request.getParameter("type"); // 1-事前绩效评估查询；2-项目绩效目标查询
        config.put("type", type);
        return config;
    }

    /**
     * 查询数据.
     *
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String, Object> parms) throws AppException {
        return transPayQueryBO.getData(parms);
    }
}
