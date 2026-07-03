package gov.mof.fasp2.pmkpi.setting.indexlib.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class IndexCheckService extends PmkpiService {

    private IndexCheckBO indexCheckBO;

    @Resource(name = "pmkpi.setting.indexlib.report.IndexCheckBOTX")
    public void setIndexCheckBO(IndexCheckBO indexCheckBO) {
        this.indexCheckBO = indexCheckBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String leftmenuid = request.getParameter("leftmenuid");
        String workflow = request.getParameter("workflow");
        String isZJ = PerfUtil.getSystemSet("isZJ");
        config.put("isZJ", isZJ);
        config.put("menuid", leftmenuid);
        config.put("workflow", workflow);
        List<DicRangeDTO> datatype = PerfUtil.getSourceData("PERFDATATYPE", " guid in('2','3')");
        config.put("datatype", datatype);
        return config;
    }

    /**
     * 保存调整数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> saveDatas(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = indexCheckBO.saveDatas(parms);
            rs.put("success", true);
        } catch (AppException e) {
            rs.put("success", false);
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
