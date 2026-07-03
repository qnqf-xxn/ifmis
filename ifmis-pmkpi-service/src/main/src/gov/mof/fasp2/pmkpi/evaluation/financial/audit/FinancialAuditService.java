package gov.mof.fasp2.pmkpi.evaluation.financial.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.rectification.bo.RectificationBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FinancialAuditService extends PmkpiService {
    private FinancialAuditBO financialAuditBO;

    public void setFinancialAuditBO(FinancialAuditBO financialAuditBO) {
        this.financialAuditBO = financialAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String proworkflow = request.getParameter("proworkflow");
        String deptworkflow = request.getParameter("deptworkflow");
        config.put("proworkflow", proworkflow);
        config.put("deptworkflow", deptworkflow);
        config.put("finaudithide", FinancialAuditDAO.PERF_STRING_PROCONFIRM);
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return financialAuditBO.getTreeData(params);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = financialAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 下达评价通知
     * @param params --
     * @return --
     */
    public Map<String, Object> giveNotice(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = financialAuditBO.giveNotice(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    //判断发起整改的数据表中是否存在
    public Integer getDataByGuid(HashMap<String, Object> params){
        return financialAuditBO.getDataByGuid(params);
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
}
