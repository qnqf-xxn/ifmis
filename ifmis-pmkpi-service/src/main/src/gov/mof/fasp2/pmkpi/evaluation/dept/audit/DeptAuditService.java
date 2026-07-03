package gov.mof.fasp2.pmkpi.evaluation.dept.audit;

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

public class DeptAuditService extends PmkpiService {
    private DeptAuditBO deptAuditBO;

    public void setDeptAuditBO(DeptAuditBO deptAuditBO) {
        this.deptAuditBO = deptAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String proworkflow = request.getParameter("proworkflow");
        String deptworkflow = request.getParameter("deptworkflow");
        String hidename = request.getParameter("hidename");//隐藏菜单名称
        config.put("proworkflow", proworkflow);
        config.put("deptworkflow", deptworkflow);
        config.put("hidename", hidename);
        return config;
    }

    public List getTreeData (HashMap<String, Object> params) throws AppException {
        return deptAuditBO.getTreeData(params);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptAuditBO.wfAudit(params);
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
        return deptAuditBO.getDataByGuid(params);
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
