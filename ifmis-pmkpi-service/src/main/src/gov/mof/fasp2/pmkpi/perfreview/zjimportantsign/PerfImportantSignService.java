package gov.mof.fasp2.pmkpi.perfreview.zjimportantsign;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfImportantSignService extends PmkpiService {
    private PerfImportantSignBO perfImportantSignBO;

    public void setPerfImportantSignBO(PerfImportantSignBO perfImportantSignBO) {
        this.perfImportantSignBO = perfImportantSignBO;
    }

    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("procoldatas", perfImportantSignBO.getCols("/pmkpi/review/importantsign/program"));
        config.put("protabledata", perfImportantSignBO.getTable("/pmkpi/review/importantsign/program"));
        config.put("proqfdatas", perfImportantSignBO.getQueryFrom("/pmkpi/review/importantsign/program"));
        config.put("deptcoldatas", perfImportantSignBO.getCols("/pmkpi/review/importantsign/dept"));
        config.put("depttabledata", perfImportantSignBO.getTable("/pmkpi/review/importantsign/dept"));
        config.put("deptqfdatas", perfImportantSignBO.getQueryFrom("/pmkpi/review/importantsign/dept"));
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return perfImportantSignBO.getTreeData(params);
    }


    /**
     * 查询数据
     * @param parms
     * @return
     * @throws AppException
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return perfImportantSignBO.getTableDatas(parms);
    }

    /**
     * 标记与取消标记
     * @param parms
     * @return
     */
    public Map<String, Object> revisionsign(HashMap<String,Object> parms){
        return perfImportantSignBO.revisionsign(parms);
    }

}
