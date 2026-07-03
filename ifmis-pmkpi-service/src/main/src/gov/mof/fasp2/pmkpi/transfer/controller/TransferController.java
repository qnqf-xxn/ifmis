package gov.mof.fasp2.pmkpi.transfer.controller;


import gov.mof.fasp2.buscommon.micro.MicroParamDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.transfer.report.TransferBO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * <p>广西结转类项目填报绩效接口</p >
 *
 * @author zy
 * @date 2022/11/21 16:39
 */

@Controller
@RequestMapping("/pmkpi/transfer")
public class TransferController {

    private final static Logger logger = Logger.getLogger(TransferController.class);


    /**
     * <p>1.预算结转-结转上一年度绩效接口</p >
     *
     * @param province:区划(String);
     * @param year:年度(String);
     * @param proList:项目集合(List):  busid：为预算编制一条指标账数据的生产走流程的主键guid;
     *                             pro_code：涉及的项目编码;
     * @author hw
     * @date 2022/11/22 15:40
     */
    @ResponseBody
    @RequestMapping(value = "/saveperf/{province}/{year}", method = RequestMethod.POST)
    public Map<String, Object> savePerf(@PathVariable("province") String province, @PathVariable("year") String year,
                                        @RequestBody List<Map<String, Object>> proList) {
        logger.info("---结转上一年度绩效-start---");
        logger.info("---province：" + province);
        logger.info("---year：" + year);
        logger.info("---proList：" + proList.toString());
        Map<String, Object> resp = new HashMap<String, Object>();
        Boolean flag = true;
        String message = "success";
        try {
            if (proList == null || proList.isEmpty()) {
                flag = false;
                message = "请填写项目信息！";
            } else {
                TransferBO transferBO = (TransferBO) PerfServiceFactory.getBean("pmkpi.transfer.TransferBOTX");
                String oldYear = String.valueOf(Integer.valueOf(year) - 1); // 获取去年年度
                transferBO.saveTransfer(proList, oldYear, province);
            }
        } catch (AppException e) {
            flag = false;
            message = "---异常：" + e.getMessage();
        }
        logger.info("---结转上一年度绩效-end---");
        resp.put("result", flag);
        resp.put("message", message);
        return resp;
    }

    /**
     * <p>2.预算结转-送审时调用的绩效数据校验接口</p >
     *
     * @param province:区划(String);
     * @param year:年度(String);
     * @param proCodes:项目code集合(List): pro_code：涉及的项目编码;
     * @param
     * @author hw
     * @date 2022/11/23 10:22
     */
    @ResponseBody
    @RequestMapping(value = "/checkperf/{province}/{year}", method = RequestMethod.POST)
    public MicroParamDTO checkPerf(@PathVariable("province") String province,
                                   @PathVariable("year") String year,
                                   @RequestBody List<String> proCodes) {
        logger.info("---预算结转-送审数据校验接口-start---");
        logger.info("---province：" + province);
        logger.info("---year：" + year);
        logger.info("---proList：" + proCodes.toString());
        PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
        Map<String, Object> resultMap = new HashMap<>();
        try {
            List<Map<String, Object>> codeList = new ArrayList<>();
            if (proCodes != null && proCodes.size() > 0) {
                logger.info("---项目idcodes：" + proCodes);
                for (String proCode : proCodes) {
                    Map<String, Object> guidMap = new HashMap<>();
                    guidMap.put("guid", proCode);
                    guidMap.put("code", proCode);
                    codeList.add(guidMap);
                }
                logger.info("---codeList：" + codeList);
//                errorlist = transferBO.checkPerf(codeList, "pkg_perf_checkTransfer.checkTransIndex");
                Map<String, Object> auditMap = prjIndexBO.auditdefine(codeList, "EED47FE19AC20202E0533315A8C02FDB", "perf", null);
                Boolean success = (Boolean) auditMap.get("success");
                if (success) {
                    resultMap.put("success", true);
                    logger.info("---校验成功：" + success);
                }
            } else {
                logger.info("---项目idcodes为空，项目不存在结转数据，校验失败!");
            }
        } catch (PerfAppException e) {
            resultMap = prjIndexBO.getExceptionMes(e); // 审核定义失败
        } catch (AppException e) {
            resultMap.put("error", e.getMessage());
        }
        MicroParamDTO dto = new MicroParamDTO();
        dto.setMap(resultMap);
        logger.info("---返回信息：" + resultMap);
        logger.info("---预算结转-送审数据校验接口-end---");
        return dto;
    }

    /**
     * <p>3.预算结转-流程终审调用接口</p >
     *
     * @param province:区划(String);
     * @param year:年度(String);
     * @param proList:项目集合(List):  busid：为预算编制一条指标账数据的生产走流程的主键guid;
     *                             pro_code：涉及的项目编码;
     * @param
     * @author hw
     * @date 2022/11/23 10:24
     */
    @ResponseBody
    @RequestMapping(value = "/auditperf/{province}/{year}", method = RequestMethod.POST)
    public Map<String, Object> auditPerf(@PathVariable("province") String province, @PathVariable("year") String year,
                                         @RequestBody List<Map<String, Object>> proList) {
        logger.info("---预算结转-流程终审调用接口-start---");
        logger.info("---province：" + province);
        logger.info("---year：" + year);
        logger.info("---proList：" + proList.toString());
        Map<String, Object> resp = new HashMap<String, Object>();
        Boolean flag = true;
        String message = "success";
        try {
            if (proList == null || proList.isEmpty()) {
                flag = false;
                message = "请填写项目信息！";
            } else {
                TransferBO transferBO = (TransferBO) PerfServiceFactory.getBean("pmkpi.transfer.TransferBOTX");
                transferBO.auditPerf(proList);
            }
        } catch (Throwable e) { //AppException
            flag = false;
            message = "---异常：" + e.getMessage();
        }
        logger.info("---预算结转-流程终审调用接口-end---");
        resp.put("result", flag);
        resp.put("message", message);
        return resp;
    }

    /**
     * <p>4.预算结转-流程取消终审调用接口</p >
     *
     * @param province:区划(String);
     * @param year:年度(String);
     * @param proList:项目集合(List):  busid：为预算编制一条指标账数据的生产走流程的主键guid;
     *                             pro_code：涉及的项目编码;
     * @param
     * @author hw
     * @date 2022/11/23 10:24
     */
    @ResponseBody
    @RequestMapping(value = "/calcelaudit/{province}/{year}", method = RequestMethod.POST)
    public Map<String, Object> calcelAudit(@PathVariable("province") String province, @PathVariable("year") String year,
                                           @RequestBody List<Map<String, Object>> proList) {
        logger.info("---预算结转-流程取消终审调用接口-start---");
        logger.info("---province：" + province);
        logger.info("---year：" + year);
        logger.info("---proList：" + proList.toString());
        Map<String, Object> resp = new HashMap<String, Object>();
        Boolean flag = true;
        String message = "success";
        try {
            if (proList == null || proList.isEmpty()) {
                flag = false;
                message = "请填写项目信息！";
            } else {
                TransferBO transferBO = (TransferBO) PerfServiceFactory.getBean("pmkpi.transfer.TransferBOTX");
                transferBO.calcelAudit(proList);
            }
        } catch (AppException e) {
            flag = false;
            message = "---异常：" + e.getMessage();
        }
        logger.info("---预算结转-流程取消终审调用接口-end---");
        resp.put("result", flag);
        resp.put("message", message);
        return resp;
    }


}
