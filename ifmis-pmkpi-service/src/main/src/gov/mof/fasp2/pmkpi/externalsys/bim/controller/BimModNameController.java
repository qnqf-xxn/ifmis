package gov.mof.fasp2.pmkpi.externalsys.bim.controller;

import gov.mof.fasp2.buscore.framework.util.JsonUtils;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.externalsys.bim.BimModNameService;
import org.springframework.cloud.stream.annotation.EnableBinding;
import org.springframework.cloud.stream.annotation.StreamListener;
import org.springframework.messaging.handler.annotation.Headers;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

/**
 * 基础库更新要素名称，绩效处理业务数据
 */
@RestController
@RequestMapping("/")
@EnableBinding(value = {BimModNameChannel.class})
public class BimModNameController {
    @Resource(name = "pmkpi.service.BimModNameService")
    private BimModNameService service;

    private BimModNameService getService() {
        if (service == null) {
            service = (BimModNameService) ServiceFactory.getBean("pmkpi.service.BimModNameService");
        }
        return service;
    }

    /**
     * 基础库更新要素名称，发送消息给绩效
     * @param message
     * @param headers
     * @throws Exception
     */
    @StreamListener(BimModNameChannel.AGENCY_INPUT)
    public void modAgencyName(@Payload String message, @Headers Map headers) throws Exception {
        Map data = JsonUtils.jsonToMap(message);
        getService().modAgencyName(data);
    }
}