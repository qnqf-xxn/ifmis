package gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProConfirmService extends PmkpiService {
    private ProConfirmBO proConfirmBO;

    public void setProConfirmBO(ProConfirmBO proConfirmBO) {
        this.proConfirmBO = proConfirmBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String proworkflow = request.getParameter("proworkflow");
        String deptworkflow = request.getParameter("deptworkflow");
        config.put("proworkflow", proworkflow);
        config.put("deptworkflow", deptworkflow);
        config.put("reportproconfirm", ProConfirmDAO.PERF_STRING_PROCONFIRM);
        String finproconfirm = PerfUtil.getSystemSet("finproconfirm");
        Map<String, Object> mm = PerfUtil.parseString2Map(finproconfirm);
        config.put("programhidebth", mm.get("program"));
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return proConfirmBO.getTreeData(params);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = proConfirmBO.wfAudit(params);
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
        return proConfirmBO.del(parms);
    }
}
