package gov.mof.fasp2.pmkpi.setting.indexlib.gdreport;

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

public class GDIndexEditService extends PmkpiService {

    private GDIndexBO gdIndexBO;

    public void setGDIndexBO(GDIndexBO gdIndexBO) {
        this.gdIndexBO = gdIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String treeid = request.getParameter("treeid");
        String pagetype = request.getParameter("pagetype"); //mod or add
        String viewtype = request.getParameter("viewtype"); //query
        String guid = request.getParameter("guid");
        String superid = request.getParameter("superid"); //父级
        String workflow = request.getParameter("workflow");
        config.put("workflow",workflow);
        config.put("treeid", treeid);
        config.put("pagetype", pagetype);
        config.put("superid", superid);
        config.put("guid", guid);
        config.put("treename", request.getParameter("treename"));
        config.put("viewtype", viewtype);
        if (pagetype != null && "mod".equals(pagetype)) {
            Map<String, Object> indexMap = gdIndexBO.getDataByGuid(config);
            config.put("indexdata", indexMap);
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> indexframe = dss.getRangesByWhereSql("PMKPIINDEXFRAME", "frametype='PM001'");
            config.put("indexframe", indexframe);
        }
        return config;
    }

    /**
     * 保存指标数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        try {
            gdIndexBO.save(params);
            backMap.put("success", true);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 编辑区查询
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        return gdIndexBO.editquery(params);
    }


}
