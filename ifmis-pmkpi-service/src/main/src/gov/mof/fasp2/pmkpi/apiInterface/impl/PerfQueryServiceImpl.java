
package gov.mof.fasp2.pmkpi.apiInterface.impl;

import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.apiInterface.dto.FineEvalInfo;
import gov.mof.fasp2.pmkpi.apiInterface.dto.PerfMonitorInfo;
import gov.mof.fasp2.pmkpi.apiInterface.dto.PerfQueryRequest;
import gov.mof.fasp2.pmkpi.apiInterface.dto.PerfQueryResponse;
import gov.mof.fasp2.pmkpi.apiInterface.service.PerfQueryService;
import gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm.ProConfirmBO;
import gov.mof.fasp2.pmkpi.perfprotrace.report.ProTraceTaskBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import org.springframework.stereotype.Service;

import java.util.List;
/**
 * @author: zxt
 * @create: 2026/6/1
 * @FileName: PerfQueryServiceImpl
 * 查询服务实现类
 */
@Service
public class PerfQueryServiceImpl implements PerfQueryService {

    @Override
    public PerfQueryResponse<PerfMonitorInfo> traceQueryData(PerfQueryRequest request) {
        ProTraceTaskBO proTraceTaskBO  = (ProTraceTaskBO) PerfServiceFactory.getBean("pmkpi.perfprotrace.report.ProTraceTaskBOTX");
        try {
            // 1. 参数校验
            if (request.getProvince() == null || request.getProvince().isEmpty()) {
                return PerfQueryResponse.error("400","参数缺失：财政区划为必填项");
            }
            if (request.getYear() == null || request.getYear().isEmpty()) {
                return PerfQueryResponse.error("400","参数缺失：预算年度为必填项");
            }
            // 2. 查询逻辑
            List<PerfMonitorInfo> resultList = proTraceTaskBO.getProTraceResult(request);
            return PerfQueryResponse.success(resultList);
        } catch (Exception e) {
            return PerfQueryResponse.error("500","系统内部错误: " + e.getMessage());
        }
    }

    @Override
    public PerfQueryResponse<FineEvalInfo> proFineEvalData(PerfQueryRequest request) {
        ProConfirmBO proConfirmBO = (ProConfirmBO) ServiceFactory.getBean("pmkpi.financial.proconfirm.ProConfirmBOTX");
        try {
            // 1. 参数校验
            if (request.getProvince() == null || request.getProvince().isEmpty()) {
                return PerfQueryResponse.error("400","参数缺失：财政区划为必填项");
            }
            if (request.getYear() == null || request.getYear().isEmpty()) {
                return PerfQueryResponse.error("400","参数缺失：预算年度为必填项");
            }
            // 2. 查询逻辑
            //String snakeCaseJson = PerfQueryResponse.toSnakeCaseJson(proConfirmBO.getFineEvalResult(request));
            List<FineEvalInfo> resultList = proConfirmBO.getFineEvalResult(request);
            return PerfQueryResponse.success(resultList);
        } catch (Exception e) {
            return PerfQueryResponse.error("500","系统内部错误: " + e.getMessage());
        }
    }

}
