package gov.mof.fasp2.pmkpi.deptTJformance.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptTJPerfService extends PmkpiService {
    /**
     * deptPerfBO.
     */
    private DeptTJPerfBO deptTJPerfBO ;

    /**
     * 注入bo.
     * @param deptTJPerfBO
     */
    public void setDeptTJPerfBO(DeptTJPerfBO deptTJPerfBO) {
        this.deptTJPerfBO = deptTJPerfBO;
    }
    

    @SuppressWarnings("unchecked")
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        config.put("workflow",workflow);
        String mainguid = request.getParameter("mainguid");
        config.put("mainguid",mainguid);
        String goalguid = request.getParameter("goalguid");
        config.put("goalguid",goalguid);
        return config;
    }
    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
	    return deptTJPerfBO.del(parms);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptTJPerfBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查找部门或者单位的绩效是否填报.
     * @param agencyguid -- 单位.
     * @return
     */
    public boolean findDeptPerformance(String agencyguid){
        return deptTJPerfBO.findDeptPerformance(agencyguid);
    }
}
