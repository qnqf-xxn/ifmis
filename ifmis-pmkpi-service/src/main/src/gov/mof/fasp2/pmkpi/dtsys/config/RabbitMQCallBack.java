package gov.mof.fasp2.pmkpi.dtsys.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.PostConstruct;

/**
 * @description:
 * @author: timor
 * @create: 2022-05-16 20:24
 */
public class RabbitMQCallBack implements RabbitTemplate.ConfirmCallback, RabbitTemplate.ReturnCallback {

    private static Logger log = LoggerFactory.getLogger(RabbitMQCallBack.class);
    @Autowired(required = false)
    private RabbitTemplate rabbitTemplate;

    /**
     * 该注解会在其他注解执行完毕之后，进行一个属性的注入，必须将该类注入到rabbitTemplate的内部类中
     * 内部类就是这个ConfirmCallback
     */
    @PostConstruct
    public void init() {
        rabbitTemplate.setConfirmCallback(this);
        /**同时需要注入队列回退接口*/
        rabbitTemplate.setReturnCallback(this);
    }

    /**
     * @param correlationData 包含了消息的ID和其他数据信息 这个需要在发送方创建，否则没有
     * @param ack             返回的一个交换机确认状态 true 为确认 false 为未确认
     * @param cause           未确认的一个原因，如果ack为true的话，此值为null
     */
    @Override
    public void confirm(CorrelationData correlationData, boolean ack, String cause) {
        String id = correlationData != null ? correlationData.getId() : "";
        if (ack) {
            log.info("回调结果成功-消息发送成功，id 是{} ", id);
        } else {
            log.info("回调结果失败，原因 是{} id 为{}", cause, id);
        }
    }

    /**
     * 可以在消息传递过程中，如果交换机遇到不可路由的情况，会将消息返回给生产者
     *
     * @param message    消息
     * @param replyCode  回复状态码
     * @param replyText  退回原因
     * @param exchange   交换机
     * @param routingKey 路由Key
     */
    @Override
    public void returnedMessage(Message message, int replyCode, String replyText, String exchange, String routingKey) {
        log.error("退回消息{}", new String(message.getBody()));
        log.error("被交换机{}退回", exchange);
        log.error("路由Key是{}", routingKey);
        log.error("退回原因是{}", replyText);
    }
}
