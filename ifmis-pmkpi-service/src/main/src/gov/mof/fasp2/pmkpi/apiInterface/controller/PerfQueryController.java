package gov.mof.fasp2.pmkpi.apiInterface.controller;

import gov.mof.fasp2.pmkpi.apiInterface.dto.FineEvalInfo;
import gov.mof.fasp2.pmkpi.apiInterface.dto.PerfMonitorInfo;
import gov.mof.fasp2.pmkpi.apiInterface.dto.PerfQueryRequest;
import gov.mof.fasp2.pmkpi.apiInterface.dto.PerfQueryResponse;
import gov.mof.fasp2.pmkpi.apiInterface.service.PerfQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author: zxt
 * @create: 2026/6/1
 * @FileName: PerfQueryController
 * 查询接口
 */
@RestController
@RequestMapping("/pmkpi/perfquery")
public class PerfQueryController {

    @Autowired
    private PerfQueryService perfQueryService;

    /**
     * 2.1 查询重点绩效监控项目
     *
     * @param request 《province、year、updatetime》查询请求参数
     * @return 查询结果
     */
    @PostMapping("/getprotracedatas")
    public PerfQueryResponse<PerfMonitorInfo> getProTraceDatas(@RequestBody PerfQueryRequest request) {
        return perfQueryService.traceQueryData(request);
    }

    /**
     * 3.1 查询财政重点评价项目
     *
     * @param request 《province、year、updatetime》查询请求参数
     * @return 查询结果
     */
    @PostMapping("/getprofinevaldatas")
    public PerfQueryResponse<FineEvalInfo> getProFineEvalDatas(@RequestBody PerfQueryRequest request) {
        return perfQueryService.proFineEvalData(request);
    }
}
