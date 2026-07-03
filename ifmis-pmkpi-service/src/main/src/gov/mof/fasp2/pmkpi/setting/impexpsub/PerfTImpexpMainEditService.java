package gov.mof.fasp2.pmkpi.setting.impexpsub;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class PerfTImpexpMainEditService extends PmkpiService {

    private PerfTImpexpsubBO perfTImpexpsubBO;

    public void setPerfTImpexpsubBO(PerfTImpexpsubBO perfTImpexpsubBO) {
        this.perfTImpexpsubBO = perfTImpexpsubBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String viewtype = request.getParameter("viewtype");
        String tablecode = request.getParameter("tablecode");
        String guid = request.getParameter("guid");
        if("mod".equals(viewtype)) {
            config.put("datas",perfTImpexpsubBO.getDataMap(tablecode, "guid=?", new String[]{guid}));
        }
        config.put("viewtype", viewtype);
        config.put("tablecode", tablecode);
        config.put("guid", guid);
        return config;
    }
    /**
     * 编辑区保存数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> saveDatas(HashMap<String, Object> params) throws AppException {
        return perfTImpexpsubBO.saveDatas(params);
    }
}
