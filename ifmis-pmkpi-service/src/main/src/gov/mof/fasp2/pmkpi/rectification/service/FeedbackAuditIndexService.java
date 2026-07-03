package gov.mof.fasp2.pmkpi.rectification.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.rectification.bo.FeedbackAuditIndexBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FeedbackAuditIndexService  extends PmkpiService {
    private FeedbackAuditIndexBO feedbackAuditIndexBO;

    public void setFeedbackAuditIndexBO(FeedbackAuditIndexBO feedbackAuditIndexBO) {
        this.feedbackAuditIndexBO = feedbackAuditIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request,
                             HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String menuId = request.getParameter("menuId");
        String type = request.getParameter("type");
        String mainguid = request.getParameter("mainguid");
        String isedit = request.getParameter("isedit");
        String viewtype = request.getParameter("viewtype");
        String showfin = request.getParameter("showfin");//项目库查看整改信息，是否查看财政评价类型的数据，参数在页签url上配置
        if ("1".equals(showfin)) {
            logger.info("项目库查询，走财政评价查询");
            mainguid = request.getParameter("finmainguid");
        }
        config.put("deptqfdatas", feedbackAuditIndexBO.getQueryFrom("/pmkpi/rectification/index/dept"));
        config.put("proqfdatas", feedbackAuditIndexBO.getQueryFrom("/pmkpi/rectification/index"));
        config.put("type",type);
        config.put("menuid", menuId);
        config.put("mainguid", mainguid);
        config.put("isedit", isedit);
        if(config.get("viewtype") == null){
            config.put("viewtype", viewtype);
        }
        return config;
    }

    /**
     * 切换左侧页签 -- 查询左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getLeftTreeData (HashMap<String, Object> params) throws AppException {
        return feedbackAuditIndexBO.getLeftTreeData(params);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = feedbackAuditIndexBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getCode() + e.getMessage().replace(e.getCode(), ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询结果应用意见.
     * @param params --
     * @return --
     */
    public Map<String, Object> getResultOpinionDatas(HashMap<String, Object> params) {
        return feedbackAuditIndexBO.getResultOpinionDatas(params);
    }

    /**
     * 结果应用意见保存
     * @param config
     * @return
     * @throws AppException
     * @throws ParseException
     */
    public Map resultOpinionsave(HashMap config) throws AppException, ParseException {
        return feedbackAuditIndexBO.infosave(config);
    }

}
