package gov.mof.fasp2.pmkpi.perfQuery;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.deptperformance.bo.DeptPerformanceQueryBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>绩效目标查询（菜单整合）</p >
 *
 * @author hw
 * @date 2021/5/19 17:34
 */
public class PerfQueryService extends PmkpiService {
    private PerfQueryBO perfQueryBO;

    public void setPerfQueryBO(PerfQueryBO perfQueryBO) {
        this.perfQueryBO = perfQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        // 二级项目
        config.put("projectcoldatas", perfQueryBO.getCols("/pmkpi/program/query/list"));
        config.put("projecttabledata", perfQueryBO.getTable("/pmkpi/program/query/list"));
        config.put("projectqfdatas", perfQueryBO.getQueryFrom("/pmkpi/program/query/list"));

        //部门整体
        config.put("deptcoldatas", perfQueryBO.getCols("/pmkpi/deptperformance/query/index"));
        config.put("depttabledata", perfQueryBO.getTable("/pmkpi/deptperformance/query/index"));
        config.put("deptqfdatas", perfQueryBO.getQueryFrom("/pmkpi/deptperformance/query/index"));

        //一级项目
        config.put("firstprocoldatas", perfQueryBO.getCols("/pmkpi/firstprogram/query/list"));
        config.put("firstprotabledata", perfQueryBO.getTable("/pmkpi/firstprogram/query/list"));
        config.put("firstproqfdatas", perfQueryBO.getQueryFrom("/pmkpi/firstprogram/query/list"));

        //转移支付
        config.put("transpaycoldatas", perfQueryBO.getCols("/pmkpi/transpay/query/list"));
        config.put("transpaytabledata", perfQueryBO.getTable("/pmkpi/transpay/query/list"));
        config.put("transpayqfdatas", perfQueryBO.getQueryFrom("/pmkpi/transpay/query/list"));

        return config;
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        return perfQueryBO.getTreeData(params);
    }

}
