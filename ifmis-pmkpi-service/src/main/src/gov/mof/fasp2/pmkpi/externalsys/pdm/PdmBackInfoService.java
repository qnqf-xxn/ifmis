package gov.mof.fasp2.pmkpi.externalsys.pdm;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.Map;

/**
 * 项目库退回，绩效处理业务数据
 */
public class PdmBackInfoService extends PmkpiService {
    private PdmBackInfoBO pdmBackInfoBO;

    public void setPdmBackInfoBO(PdmBackInfoBO pdmBackInfoBO) {
        this.pdmBackInfoBO = pdmBackInfoBO;
    }

    public void backinfo(Map data) throws AppException {
        logger.info("绩效接收MQ消息，项目库退回信息，绩效处理开始，msg:" + data);
        pdmBackInfoBO.save(data);
        logger.info("绩效接收MQ消息，项目库退回信息，绩效处理结束");
    }

}
