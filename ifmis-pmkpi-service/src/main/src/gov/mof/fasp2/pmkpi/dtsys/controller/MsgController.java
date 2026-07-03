package gov.mof.fasp2.pmkpi.dtsys.controller;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.log.service.LogFactory;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.dtsys.config.ConfirmConfig;
import gov.mof.fasp2.pmkpi.dtsys.result.MqResultReceiveMsg;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;
import java.util.UUID;


@RestController
@RequestMapping("/pmkpi")

public class MsgController {
    private static Logger log = LogFactory.getLogger(MsgController.class);

    @Autowired(required = false)
    private RabbitTemplate rabbitTemplate;

    private ConfirConfigBO confirConfigBO;

    public ConfirConfigBO getConfirConfigBO() {
        if(confirConfigBO == null){
            confirConfigBO = (ConfirConfigBO) PerfServiceFactory.getBean("pmkpi.dtsys.controller.ConfirConfigBOTX");
        }
        return confirConfigBO;
    }

    /**
     * 预算一上
     * ConfirmConfig.MOF_AND_DEPT_DATA_EXCHANGE  交换器
     *   路由key
     *  msg 发送的内容
     *  correlationData 唯一标识
     */
    @GetMapping("/push/DY_G0005")
    public void push() {
        CorrelationData correlationData = new CorrelationData(UUID.randomUUID().toString());
        MqResultReceiveMsg mqResultReceiveMsg = new MqResultReceiveMsg();
        String province = CommonUtil.getProvince();
        String year = CommonUtil.getYear();
        String agencyguid = CommonUtil.getCurrentUser().getAgency();
        mqResultReceiveMsg.setBS_LOGO(PmkpiDAO.APPID);
        mqResultReceiveMsg.setMOF_DIV_CODE(province);
        mqResultReceiveMsg.setFISCAL_YEAR(year);
        mqResultReceiveMsg.setAGENCY_CODE(agencyguid);
        mqResultReceiveMsg.setDTG_CODE("DY_G0005");
        Map<String, Object> data = getConfirConfigBO().getBgt1Datas(province, year, "024001");
        mqResultReceiveMsg.setDATA(data);
        mqResultReceiveMsg.setBS_LOGO(PmkpiDAO.APPID);
        rabbitTemplate.convertAndSend(ConfirmConfig.MOF_AND_DEPT_DATA_EXCHANGE, "mofAndDeptDataExchange.dtsys.push", mqResultReceiveMsg.toString(), correlationData);
        log.info("发送信息为DY_G0005:" + mqResultReceiveMsg.toString());
    }

    /**
     * 预算二上
     * ConfirmConfig.MOF_AND_DEPT_DATA_EXCHANGE  交换器
     *   路由key
     *  msg 发送的内容
     *  correlationData 唯一标识
     */
    @GetMapping("/push/DY_G0007")
    public void sendAudit() {
        CorrelationData correlationData = new CorrelationData(UUID.randomUUID().toString());
        MqResultReceiveMsg mqResultReceiveMsg = new MqResultReceiveMsg();
        String province = CommonUtil.getProvince();
        String year = CommonUtil.getYear();
        String agencyguid = CommonUtil.getCurrentUser().getAgency();
        mqResultReceiveMsg.setBS_LOGO(PmkpiDAO.APPID);
        mqResultReceiveMsg.setMOF_DIV_CODE(province);
        mqResultReceiveMsg.setFISCAL_YEAR(year);
        mqResultReceiveMsg.setAGENCY_CODE(agencyguid);
        mqResultReceiveMsg.setDTG_CODE("DY_G0007");
        Map<String, Object> data = getConfirConfigBO().getBgt2Datas(province, year, agencyguid);
        mqResultReceiveMsg.setDATA(data);
        mqResultReceiveMsg.setBS_LOGO(PmkpiDAO.APPID);
        rabbitTemplate.convertAndSend(ConfirmConfig.MOF_AND_DEPT_DATA_EXCHANGE, "mofAndDeptDataExchange.dtsys.push", mqResultReceiveMsg.toString(), correlationData);
        log.info("发送信息为DY_G0007:" + mqResultReceiveMsg.toString());
    }
}
