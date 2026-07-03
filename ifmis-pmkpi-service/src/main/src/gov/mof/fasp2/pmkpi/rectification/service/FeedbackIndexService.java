package gov.mof.fasp2.pmkpi.rectification.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.rectification.bo.FeedbackIndexBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FeedbackIndexService  extends PmkpiService {
    private FeedbackIndexBO feedbackIndexBO;

    public void setFeedbackIndexBO(FeedbackIndexBO feedbackIndexBO) {
        this.feedbackIndexBO = feedbackIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request,
                             HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String guid = request.getParameter("mainguid");
        String menuId = request.getParameter("menuId");
        String type = request.getParameter("type");
        config.put("deptqfdatas", feedbackIndexBO.getQueryFrom("/pmkpi/rectification/index/dept"));
        config.put("proqfdatas", feedbackIndexBO.getQueryFrom("/pmkpi/rectification/index"));
        config.put("type", type);
        config.put("menuid", menuId);
        config.put("mainguid", guid);
        if(guid!=null && !guid.equals("")){
            config.put("feedbackInfo", getText(config));
        }
        return config;
    }

    public Map getText(Map config) throws AppException, ParseException {
        return feedbackIndexBO.getText(config);
    }

    /**
     * 切换左侧页签 -- 查询左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getLeftTreeData (HashMap<String, Object> params) throws AppException {
        return feedbackIndexBO.getLeftTreeData(params);
    }

    /**
     * 送审
     * @param config
     * @return
     * @throws AppException
     */
    public Map send(HashMap config) throws AppException {
        return feedbackIndexBO.send(config);
    }

    /**
     * 取消审核
     * @param config
     * @return
     * @throws AppException
     */
    public Map cancel(HashMap config) throws AppException {
        return feedbackIndexBO.cancel(config);
    }

    /**
     * 查询
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String,Object>> getDataByGuid(HashMap<String,Object> params) throws AppException {
        return feedbackIndexBO.getDataByGuid(params);
    }

    /**
     * 保存并送审  送审
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = feedbackIndexBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
