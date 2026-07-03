package gov.mof.fasp2.pmkpi.assessQuery;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AssessQueryService extends PmkpiService {

    private AssessQueryBO assessQueryBO;

    public void setAssessQueryBO(AssessQueryBO assessQueryBO) {
        this.assessQueryBO = assessQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        List<Map<String, Object>> coldatas = assessQueryBO.getCols("/pmkpi/assess/query");
        Map<String, Object> tabledata = assessQueryBO.getTable("/pmkpi/assess/query");
        List<Map<String, Object>> qfdatas = assessQueryBO.getQueryFrom("/pmkpi/assess/query");
        //一级项目
        config.put("firstprocoldatas", coldatas);
        config.put("firstprotabledata", tabledata);
        config.put("firstproqfdatas", qfdatas);
        // 二级项目
        config.put("secondprocoldatas", coldatas);
        config.put("secondprotabledata", tabledata);
        config.put("secondproqfdatas", qfdatas);
        //转移支付
        config.put("transpaycoldatas", coldatas);
        config.put("transpaytabledata", tabledata);
        config.put("transpayqfdatas", qfdatas);
        String type = request.getParameter("type"); // 1-事前绩效评估查询；2-项目绩效目标查询
        config.put("type", type);
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> pmkpidept = dss.getRangesByWhereSql("PMKPIDEPARTMENT", "");
        List<DicRangeDTO> pmkpiwf = dss.getRangesByWhereSql("PMKPIWFSTATUS", "");
        config.put("pmkpidept", pmkpidept);
        config.put("pmkpiwf", pmkpiwf);
        return config;
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        return assessQueryBO.getTreeData1(params);
    }

    /**
     * 查询数据.
     *
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String, Object> parms) throws AppException {
        return assessQueryBO.getData(parms);
    }

    /**
     * 查询附件信息.
     *
     * @param parms --
     * @return --
     */
    public Map<String, Object> getFileMag(HashMap<String, Object> parms) throws AppException {
        return assessQueryBO.getFileMag(parms);
    }
}
