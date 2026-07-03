package gov.mof.fasp2.pmkpi.setting.modelcase;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 11:38 2020/8/19  chongdayong
 */
public class ModelCaseIndexEditService extends PmkpiService {
    private ModelCaseBO modelCaseBO;

    public void setModelCaseBO(ModelCaseBO modelCaseBO) {
        this.modelCaseBO = modelCaseBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String tablecode = request.getParameter("tablecode");
        String pagetype = request.getParameter("pagetype");
        String guid = request.getParameter("guid");
//        String framesystem = request.getParameter("framesystem");
        config.put("tablecode", tablecode);
        config.put("pagetype", pagetype);
        config.put("guid", guid);
        if (pagetype != null && "mod".equals(pagetype)) {//修改查询数据
            config.put("indexdata", modelCaseBO.getDataByGuid(config));
        }
        config.put("mainguid", mainguid);
        return config;
    }

    /**
     * 保存指标数据.
     * @param params --
     * @return --
     */
    /*public Map<String, Object> save(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        try {
            modelCaseBO.save(params);
            backMap.put("success", true);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }*/
}
