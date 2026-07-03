package gov.mof.fasp2.pmkpi.deptperformance.controller;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.pmkpi.deptperformance.bo.DeptPerformanceBO;
import gov.mof.fasp2.pmkpi.perfprogram.controller.PerfProgramService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

;

@RestController
@RequestMapping("/pmkpi/deptformance")
public class PerfDeptformanceService {

    private final static Logger logger = Logger.getLogger(PerfProgramService.class);

    /**
     * 预算终审接口
     * @param list 终审单位数据
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "bgtaudit", method = RequestMethod.POST)
    public Map perfReview(@RequestBody List<String> list, @RequestParam("iscancel") String iscancel){
        logger.debug("--------bgtaudit 预算绩效终审 start-------------");
        Map<String, String> map = new HashMap<String, String>();
        try {
            if (list != null && list.size()>0) {
                logger.info("----------------------iscancel:"+iscancel+"-----------------------");
                DeptPerformanceBO deptPerformanceBO = (DeptPerformanceBO) PerfServiceFactory.getBean("pmkpi.deptperformance.DeptPerformanceBOTX");
                deptPerformanceBO.bgtAudit(list,iscancel);
            }
            map.put("returnkey", "true");
            logger.debug("--------bgtaudit 预算绩效终审 end-------------");
        } catch (AppException e) {
            map.put("returnkey", "false");
            map.put("returnval",e.getCode());
            logger.error("--------bgtaudit 预算绩效终审接口调用失败 end-------------");
            logger.error(e.getMessage(), e);
        }
        return map;
    }

    /**
     * 预算批复，转移支付批复，备份项目批复数据.
     * @param list 批复项目数据
     * @param  iscancel 1取消，2批复
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "replyProgram", method = RequestMethod.POST)
    public Map replyProgram(@RequestBody List<String> list, @RequestParam("iscancel") String iscancel) {
        Map<String, String> map = new HashMap<String, String>();
        try {
                DeptPerformanceBO deptPerformanceBO = (DeptPerformanceBO) PerfServiceFactory.getBean("pmkpi.deptperformance.DeptPerformanceBOTX");
                if (list != null && list.size()>0) {
                    logger.info("--------replyProgram 预算批复保存 start-------------");
                    logger.info("--------replyProgram 预算批复保存 procodes：" + list.toString());
                    logger.info("----------------------iscancel:"+iscancel+"-----------------------");
                    deptPerformanceBO.savePf(list, iscancel);
                    logger.info("--------replyProgram 预算批复保存 end-------------");
                }
            map.put("returnkey", "true");
        } catch (AppException e) {
            map.put("returnkey", "false");
            map.put("returnval", e.getCode());
            logger.error("--------replyProgram 预算绩效终审接口调用失败 end-------------");
            logger.error(e.getMessage(), e);
        }
        return map;
    }

}
