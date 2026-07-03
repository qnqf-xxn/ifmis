package gov.mof.fasp2.pmkpi.dtsys.listener;

import com.alibaba.fastjson.JSON;
import com.rabbitmq.client.Channel;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.dtsys.config.ConfirmConfig;
import gov.mof.fasp2.pmkpi.dtsys.controller.ConfirConfigBO;
import gov.mof.fasp2.pmkpi.dtsys.result.MqResultReceiveMsg;
import gov.mof.fasp2.pmkpi.dtsys.result.MqResultSendMsg;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.UUID;

/**
 * @description:
 * @author: timor
 * @create: 2022-05-16 20:28
 */
@Component
public class RabbitMqListener {

    @Autowired(required = false)
    private RabbitTemplate rabbitTemplate;

    private static final Logger logger = LoggerFactory.getLogger(RabbitMqListener.class);

    /**
     * 确认消息
     *
     * @param message
     */
    @RabbitListener(queues = {ConfirmConfig.AH_PMKPI_QUEUE})
    public void receiveMsg(Message message, Channel channel) {
        CorrelationData correlationData = new CorrelationData(UUID.randomUUID().toString());
        MqResultReceiveMsg mqResultReceiveMsg = null;
        MqResultSendMsg mqResultSendMsg = new MqResultSendMsg();
        String dtg_code = "";
        try {
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
            mqResultReceiveMsg = JSON.parseObject(new String(message.getBody(), StandardCharsets.UTF_8), MqResultReceiveMsg.class);
            String routingKey = message.getMessageProperties().getReceivedRoutingKey();
            dtg_code = mqResultReceiveMsg.getDTG_CODE();
            String bs_logo = mqResultReceiveMsg.getBS_LOGO();
            //只处理绩效
            if (mqResultReceiveMsg != null && PmkpiDAO.APPID.equals(bs_logo) && !StringUtil.isEmpty(dtg_code)) {
                ConfirConfigBO confirConfigBO = (ConfirConfigBO) PerfServiceFactory.getBean("pmkpi.dtsys.controller.ConfirConfigBOTX");
                Map<String, Object> dataMap = (Map<String, Object>) mqResultReceiveMsg.getDATA();
                switch (dtg_code) {
                    case "DY_P0002": //一级项目申报,处理指标、目标数据
                        confirConfigBO.setDatas(dataMap, confirConfigBO.getProgramTable());
                    case "DY_P0003"://项目储备
                        confirConfigBO.setDatas(dataMap, confirConfigBO.getProgramTable());
                    case "DY_P0004"://项目调整
                        confirConfigBO.setDatas(dataMap, confirConfigBO.getProgramTable());
                    case "DY_P0005":;//预算一上申报,指标、目标+绩效目标评审意见表
                        confirConfigBO.setDatas(dataMap, confirConfigBO.getProgramTable());
                    case "DY_P0007"://预算二上申报
                        confirConfigBO.setDatas(dataMap, confirConfigBO.getProgramTable());
                }
                //返回结果
                mqResultSendMsg.setResultCode(mqResultSendMsg.OK);
                mqResultSendMsg.setResultMessage(mqResultSendMsg.OK_MESSAGE);
                logger.info("消费消息成功：" + message.toString());
            }
        } catch (AppException | IOException e) {
            mqResultSendMsg.setResultCode(mqResultSendMsg.ERROR);
            mqResultSendMsg.setResultMessage(mqResultSendMsg.ERROR_MESSAGE);
            logger.error("消费消息失败：" + message.toString());
            logger.error(e.getMessage(), e);
        }
//        rabbitTemplate.convertAndSend(ConfirmConfig.MOF_AND_DEPT_DATA_EXCHANGE, "mofAndDeptDataExchange.dtsys." + dtg_code, mqResultSendMsg, correlationData);
    }
}
