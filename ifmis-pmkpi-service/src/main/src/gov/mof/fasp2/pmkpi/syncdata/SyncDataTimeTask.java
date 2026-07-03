package gov.mof.fasp2.pmkpi.syncdata;

import gov.mof.fasp2.buscore.framework.log.service.LogFactory;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;

/**
 * 同步预算资金数据
 */
public class SyncDataTimeTask {

    private static boolean istrue = false;

    private static Logger logger = LogFactory.getLog(SyncDataTimeTask.class);

    /**
     * 拉取预算资金同步修改绩效数据
     * @param args
     * @throws Throwable
     */
    public static void syncBdmDatas(String[] args) throws Throwable{
        try {
            if (!istrue) {
                SyncDataBO syncDataBO = (SyncDataBO) ServiceFactory.getBean("pmkpi.syncdata.SyncDataBOTX");
                logger.info("++++++++++++定时任务拉取预算资金修改绩效数据开始");
                istrue = true;
                //同步处理
                syncDataBO.syncBdmDatas(1);
                istrue = false;
                logger.info("++++++++++++定时任务拉取预算资金修改绩效数据结束");
            } else {
                logger.info("++++++++++++定时任务拉取预算资金修改绩效数据未结束");
            }
        }catch (Throwable e) {
            istrue = false;
            throw e;
        }

    }

}
