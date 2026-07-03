package gov.mof.fasp2.pmkpi.perfSupervision;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfSupervisionService extends PmkpiService {
    private PerfSupervisionBO perfSupervisionBO;

    public void setPerfSupervisionBO(PerfSupervisionBO perfSupervisionBO) {
        this.perfSupervisionBO = perfSupervisionBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String propayworkflow = request.getParameter("propayworkflow"); // 转移支付
        String prodetailworkflow = request.getParameter("prodetailworkflow"); // 二级项目
        String promainworkflow = request.getParameter("promainworkflow");// 一级项目
        String prolev = request.getParameter("prolev");
        config.put("propayworkflow", propayworkflow);
        config.put("prodetailworkflow", prodetailworkflow);
        config.put("promainworkflow", promainworkflow);
        config.put("prolev", prolev);

        config.put("propaycoldatas", perfSupervisionBO.getCols("/pmkpi/propay/supervision/index"));
        config.put("propaytabledata", perfSupervisionBO.getTable("/pmkpi/propay/supervision/index"));
        config.put("propayqfdatas", perfSupervisionBO.getQueryFrom("/pmkpi/propay/supervision/index"));

        config.put("prodetailcoldatas", perfSupervisionBO.getCols("/pmkpi/prodetail/supervision/index"));
        config.put("prodetailtabledata", perfSupervisionBO.getTable("/pmkpi/prodetail/supervision/index"));
        config.put("prodetailqfdatas", perfSupervisionBO.getQueryFrom("/pmkpi/prodetail/supervision/index"));

        config.put("promaincoldatas", perfSupervisionBO.getCols("/pmkpi/promain/supervision/index"));
        config.put("promaintabledata", perfSupervisionBO.getTable("/pmkpi/promain/supervision/index"));
        config.put("promainqfdatas", perfSupervisionBO.getQueryFrom("/pmkpi/promain/supervision/index"));
        return config;
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfSupervisionBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return perfSupervisionBO.getTreeData(params);
    }

    public Map save(HashMap config) throws AppException{
        return perfSupervisionBO.save(config);
    }

    public Map saveIndex(HashMap config) throws AppException{
        return perfSupervisionBO.saveIndex(config);
        
    }


}
