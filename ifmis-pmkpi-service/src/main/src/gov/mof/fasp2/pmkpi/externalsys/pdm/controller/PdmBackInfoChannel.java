package gov.mof.fasp2.pmkpi.externalsys.pdm.controller;

import org.springframework.cloud.stream.annotation.Input;
import org.springframework.messaging.SubscribableChannel;

/**
 * 项目库退回，绩效处理业务数据
 */
public interface PdmBackInfoChannel {
    String BACKINFO_INPUT = "PdmSyncBackinfoInput";

    /**
     * 项目库退回，绩效处理业务数据
     * @return
     */
    @Input(PdmBackInfoChannel.BACKINFO_INPUT)
    SubscribableChannel input();

}
