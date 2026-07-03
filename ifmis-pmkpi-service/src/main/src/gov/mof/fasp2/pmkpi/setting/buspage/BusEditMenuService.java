package gov.mof.fasp2.pmkpi.setting.buspage;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class BusEditMenuService extends PmkpiService {
    private BusAppendBO busAppendBO;

    public void setBusAppendBO(BusAppendBO busAppendBO) {
        this.busAppendBO = busAppendBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String superguid = request.getParameter("superguid");
        String levelno = request.getParameter("levelno");
        String pagetype = request.getParameter("pagetype");
        String guid = request.getParameter("guid");
        if (pagetype != null && "mod".equals(pagetype)) {
            config.put("menudata",  busAppendBO.getDataMap("PERF_T_PAGEMENU", "guid='"+guid+"'"));
            config.put("superguid", superguid);
        } else {
            config.put("superguid", guid);
        }
        config.put("levelno", levelno);
        config.put("pagetype", pagetype);
        return config;
    }

    /**
     * 保存指标数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> saveMenu(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        try {
            busAppendBO.saveMenu(params);
            backMap.put("success", true);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
}
