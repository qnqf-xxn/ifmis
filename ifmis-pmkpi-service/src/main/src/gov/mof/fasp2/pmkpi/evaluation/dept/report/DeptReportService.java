package gov.mof.fasp2.pmkpi.evaluation.dept.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptReportService extends PmkpiService {
    private DeptReportBO deptReportBO;

    public void setDeptReportBO(DeptReportBO deptReportBO) {
        this.deptReportBO = deptReportBO;
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

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return deptReportBO.getTreeData(params);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptReportBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
        return deptReportBO.del(parms);
    }
}
