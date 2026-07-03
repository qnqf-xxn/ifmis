package gov.mof.fasp2.pmkpi.rectification.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.rectification.bo.RectificationFileBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RectificationFileService extends PmkpiService {

    private RectificationFileBO rectificationFileBO;

    public void setRectificationFileBO(RectificationFileBO rectificationFileBO) {
        this.rectificationFileBO = rectificationFileBO;
    }

    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String isfinadd = request.getParameter("isfinadd");  //是否财政评价新增项目
        config.put("isfinadd",isfinadd);
        String taskstage = request.getParameter("taskstage");
        String taskguid = request.getParameter("taskguid");
        String queryYear = request.getParameter("queryYear");
        String queryProvince = request.getParameter("queryProvince");
        config.put("taskguid",taskguid);   //监控任务guid
        config.put("taskstage",taskstage);  //监控任务阶段
        config.put("queryYear", queryYear);
        config.put("queryProvince", queryProvince);
        config.put("checkguid", request.getParameter("guid"));
        return config;
    }

    public Map<String,Object> queryEdit (HashMap<String, Object> params){
        return rectificationFileBO.queryEdit(params);
    }

    public Map<String,Object> queryFiletype (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        List<Map<String, Object>> data = rectificationFileBO.queryFiletype(params);
        rs.put("data", data);
        rs.put("success", true);
        return rs;

    }

    /**
     * 保存
     * @param params
     * @return
     */
    public Map<String,Object> save (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = rectificationFileBO.save(params);
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
