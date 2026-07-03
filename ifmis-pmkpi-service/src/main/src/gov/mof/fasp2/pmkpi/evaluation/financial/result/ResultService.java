package gov.mof.fasp2.pmkpi.evaluation.financial.result;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm.ProConfirmBO;
import gov.mof.fasp2.pmkpi.perfprotrace.thirdaudit.ProTraceThirdAuditBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.rectification.bo.RectificationBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ResultService extends PmkpiService {
    private ResultBO resultBO;

    public void setResultBO(ResultBO resultBO) {
        this.resultBO = resultBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String finhide = request.getParameter("hidename");//隐藏菜单名称
        String proworkflow = request.getParameter("proworkflow");
        String deptworkflow = request.getParameter("deptworkflow");
        //是否财政终稿报告上传菜单：1-是；0-否；
        String isreport = StringUtils.isEmpty(request.getParameter("isreport")) ? "0" : request.getParameter("isreport");
        String finhidebutton = PerfUtil.getSystemSet("finhidebutton"); //财政评价成果审核/终稿报告上传菜单按钮隐藏
        String result = null,report = null;
        if (!StringUtil.isEmpty(finhidebutton)) {
            Map<String, Object> mm = PerfUtil.parseString2Map(finhidebutton);
            result = (String) mm.get("result");
            report = (String) mm.get("report");
        }
        config.put("proworkflow", proworkflow);
        config.put("deptworkflow", deptworkflow);
        config.put("isreport", isreport);
        config.put("resulthide", result);
        config.put("reporthide", report);
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return resultBO.getTreeData(params);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = resultBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 接收通知
     * @param params --
     * @return --
     */
    public Map<String, Object> acceptNotice(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = resultBO.acceptNotice(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 判断发起整改的数据表中是否存在
     * @param params
     * @return
     */
    public Integer getDataByGuid(HashMap<String, Object> params){
        return resultBO.getDataByGuid(params);
    }
    /**
     * 发起整改 -- 保存并下发
     * @param params --
     * @return --
     */
    public Map<String, Object> sendandudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        RectificationBO rectificationBO = (RectificationBO) ServiceFactory.getBean("pmkpi.rectification.RectificationBOTX");
        try {
            rs = rectificationBO.wfAudit(params);
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
     * 2.2.查询重点绩效监控项目成果
     * 3.2.查询财政重点评价项目成果
     * @param params
     * @throws Exception
     */
    public Map<String, Object> getResult (HashMap<String, Object> params) throws Exception {
        ProTraceThirdAuditBO proTraceThirdAuditBO = (ProTraceThirdAuditBO) gov.mof.fasp2.busfw.util.ServiceFactory.getBean("pmkpi.perfprotrace.thirdaudit.ProTraceThirdAuditBOTX");
        return proTraceThirdAuditBO.getProTraceEvalResult(params);
    }
}
