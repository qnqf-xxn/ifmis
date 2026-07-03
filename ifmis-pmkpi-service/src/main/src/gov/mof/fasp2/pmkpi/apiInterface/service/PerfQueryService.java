
package gov.mof.fasp2.pmkpi.apiInterface.service;

import gov.mof.fasp2.pmkpi.apiInterface.dto.FineEvalInfo;
import gov.mof.fasp2.pmkpi.apiInterface.dto.PerfMonitorInfo;
import gov.mof.fasp2.pmkpi.apiInterface.dto.PerfQueryResponse;
import gov.mof.fasp2.pmkpi.apiInterface.dto.PerfQueryRequest;

/**
 * @author: zxt
 * @create: 2026/6/1
 * @FileName: PerfQueryService
 * 查询服务接口
 */
public interface PerfQueryService {
    /**
     * 查询重点绩效监控项目
     * @param request 请求参数
     * @return 响应结果
     */
    PerfQueryResponse<PerfMonitorInfo> traceQueryData(PerfQueryRequest request);

    /**
     * 查询财政重点评价项目
     * @param request 请求参数
     * @return 响应结果
     */
    PerfQueryResponse<FineEvalInfo> proFineEvalData(PerfQueryRequest request);
}
