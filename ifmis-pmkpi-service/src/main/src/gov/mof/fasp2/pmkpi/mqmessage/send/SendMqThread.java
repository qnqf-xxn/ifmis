package gov.mof.fasp2.pmkpi.mqmessage.send;

import gov.mof.fasp2.buscore.framework.log.service.Log;
import gov.mof.fasp2.buscore.framework.log.service.LogFactory;
import gov.mof.fasp2.buscore.framework.util.JsonUtils;
import gov.mof.fasp2.datacommon.MQmessage.send.MQLogUtil;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.MessageHeaders;
import org.springframework.messaging.support.MessageBuilder;

import java.util.HashMap;
import java.util.Map;

/**
 * mq消息走单独线程
 */
public class SendMqThread implements Runnable {
    private MessageChannel messageChannel;
    private Map msgcontent;
    private String topic;
    private static Log logger = LogFactory.getLog(SendMqThread.class);

    public SendMqThread(MessageChannel messageChannel, Map msgcontent, String topic) {
        this.messageChannel = messageChannel;
        this.msgcontent = msgcontent;
        this.topic = topic;
    }

    @Override
    public void run() {
        try {
            Map<String, Object> headers = new HashMap<>();
            msgcontent.put("topic", topic);
            headers.put("topic", topic);
            MessageHeaders messageHeaders = new MessageHeaders(headers);
            String msg = JsonUtils.ObjectToJson(msgcontent);
            logger.info("绩效推送MQ消息，topic：" + topic + ", message:" + msg);
            Message message = MessageBuilder.createMessage(msg, messageHeaders);
            messageChannel.send(message);
            // MQ消息日志记录
            MQLogUtil mqLogUtil = MQLogUtil.getInstance(msgcontent);
            mqLogUtil.start();
        } catch (Exception e) {
            logger.error("绩效发送MQ推送消息错误. 不影响业务流程，错误如下：");
            e.printStackTrace();
        }
    }

}