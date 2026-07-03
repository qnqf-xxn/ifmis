package gov.mof.fasp2.pmkpi.perfreview.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfReviewService extends PmkpiService {

    private PerfReviewBO perfReviewBO;

    public void setPerfReviewBO(PerfReviewBO perfReviewBO) {
        this.perfReviewBO = perfReviewBO;
    }

    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String proworkflow = request.getParameter("proworkflow");//项目评审的工作流
        String deptworkflow = request.getParameter("deptworkflow");//部门评审的工作流
        String zyzfproworkflow = request.getParameter("zyzfproworkflow");//转移支付项目库评审的工作流
        String lefttypes = request.getParameter("lefttypes");
        if(!StringUtils.isEmpty(lefttypes) && lefttypes.contains("zyzfprogram")){
           String[] str = lefttypes.split(",");
           String lefttree = str[0];
            config.put("lefttabtype", lefttree);
        }

        config.put("proworkflow", proworkflow);
        config.put("deptworkflow", deptworkflow);
        config.put("zyzfproworkflow", zyzfproworkflow);
        config.put("proqfdatas", perfReviewBO.getQueryFrom("/pmkpi/review/report/program"));
        config.put("deptqfdatas", perfReviewBO.getQueryFrom("/pmkpi/review/report/dept"));
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return perfReviewBO.getTreeData(params);
    }

    public Map<String,Object> savereviewdatas (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfReviewBO.savereviewdatas(params);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;

    }

    /**
     * 确认评审
     * @param params
     * @return
     */
    public Map<String,Object> confirm (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfReviewBO.confirm(params);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 取消确认评审
     * @param params
     * @return
     */
    public Map<String,Object> unconfirm (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            perfReviewBO.unconfirm(params);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
