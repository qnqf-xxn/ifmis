package gov.mof.fasp2.pmkpi.perfself.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfself.bo.PerfSelfAuditBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.rectification.bo.RectificationBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfSelfAuditService extends PmkpiService {
    private PerfSelfAuditBO perfSelfAuditBO;

    public void setPerfSelfAuditBO(PerfSelfAuditBO perfSelfAuditBO) {
        this.perfSelfAuditBO = perfSelfAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("deptqfdatas", perfSelfAuditBO.getQueryFrom("/pmkpi/perfself/apply/dept"));
        config.put("proqfdatas", perfSelfAuditBO.getQueryFrom("/pmkpi/perfself/apply/index"));
        config.put("isNINGXIA", PerfUtil.getIsNINGXIA());
        return config;
    }

    public Map<String, Object> query(HashMap<String, Object> params) throws AppException {
        Map<String, Object> resmap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String audittype = (String) params.get("audittype");
        String agency = (String) params.get("agency");
        String nodeguid = (String) params.get("nodeguid");
        resmap.putAll(perfSelfAuditBO.getTableData(mainguid, audittype, agency, nodeguid));
        resmap.put("status", "1");
        return resmap;
    }

    public Map<String, Object> save(HashMap<String, Object> param) throws AppException {
        Map<String, Object> data = new HashMap();
        data = perfSelfAuditBO.save(param);
        data.put("status", "1");
        return data;

    }
    
    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfSelfAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (Exception e) {
            rs.put("msg", e.getMessage().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
    
    /**
     * <p>左侧树-整合菜单首次进入页面</p >
     *
     * @author hw
     * @date 2021/7/17 16:06
     * @param
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return perfSelfAuditBO.getTreeData(params);
    }

    //判断发起整改的数据表中是否存在
    public Integer getDataByGuid(HashMap<String, Object> params){
        return perfSelfAuditBO.getDataByGuid(params);
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
