package gov.mof.fasp2.pmkpi.workevaluate.performance;

import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.annotation.Resource;

@PageComponent(serviceid = "pmkpi.performance.performanceService", viewid = "pmkpi.performance.performanceService", jsLib = "/pmkpi/workevaluate/performance/workevaluateperformance.js", jsObjectName = "Ext.lt.pmkpi.performance.index")
public class PerformanceService extends PmkpiService {

    @Resource(name = "pmkpi.workevaluate.performance.PerformanceBOTX")
    private PerformanceBO performanceBO;

    public void setPerformanceBO(PerformanceBO performanceBO) {
        this.performanceBO = performanceBO;
    }

}
