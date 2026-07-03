package gov.mof.fasp2.pmkpi.externalsys.bim.controller;

import org.springframework.cloud.stream.annotation.Input;
import org.springframework.cloud.stream.annotation.Output;
import org.springframework.messaging.SubscribableChannel;

/**
 * 基础库更新要素名称，绩效处理业务数据
 */
public interface BimModNameChannel {
    String AGENCY_INPUT = "BimSyncAgencyNameInput";

    String AGENCY_OUTPUT = "BimSyncAgencyNameOutput";

    /**
     * 接收消息，基础库更新要素名称.
     * @return
     */
    @Input(BimModNameChannel.AGENCY_INPUT)
    SubscribableChannel input();

    /**
     * 反馈消息，绩效业务数据处理结果
     * @return
     */
    @Output(BimModNameChannel.AGENCY_OUTPUT)
    SubscribableChannel output();
}
