package gov.mof.fasp2.pmkpi.externalsys.pdm.controller;

import gov.mof.fasp2.buscore.framework.util.JsonUtils;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.externalsys.pdm.PdmBackInfoService;
import org.springframework.cloud.stream.annotation.EnableBinding;
import org.springframework.cloud.stream.annotation.StreamListener;
import org.springframework.messaging.handler.annotation.Headers;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

/**
 * 项目库退回，绩效处理业务数据
 */
@RestController
@RequestMapping("/")
@EnableBinding(value = {PdmBackInfoChannel.class})
public class PdmBackInfoController {
    @Resource(name = "pmkpi.service.PdmBackInfoService")
    private PdmBackInfoService service;

    private PdmBackInfoService getService() {
        if (service == null) {
            service = (PdmBackInfoService) ServiceFactory.getBean("pmkpi.service.PdmBackInfoService");
        }
        return service;
    }

    /**
     * 基础库更新要素名称，发送消息给绩效
     * @param message
     * @param headers
     * @throws Exception
     */
    @StreamListener(PdmBackInfoChannel.BACKINFO_INPUT)
    public void backinfo(@Payload String message, @Headers Map headers) throws Exception {
        Map data = JsonUtils.jsonToMap(message);
        getService().backinfo(data);
    }
}