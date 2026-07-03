package gov.mof.fasp2.pmkpi.timetask;

import gov.mof.fasp2.buscore.framework.log.service.LogFactory;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.pmkpi.perfcommon.aisupportaudit.AISupportAuditBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

/**
 * AI辅助审核
 */
public class AISupportAuditTask {
    private static boolean istrue = false;
    private static Logger logger = LogFactory.getLog(AISupportAuditTask.class);
    /**
     * AI辅助审核
     * @param args
     * @throws Throwable
     */
    public static void supportAuditDatas(String[] args) throws Throwable{
        try {
            if (!istrue) {
                String province = args[4];
                String year = args[5];
                logger.info("++++++++++++定时任务AI辅助审核开始,区划"+province+"年度"+year);
                istrue = true;
                //AI辅助审核后台预处理
                AISupportAuditBO aISupportAuditBO =(AISupportAuditBO)PerfServiceFactory.getBean("pmkpi.aisupportaudit.AISupportAuditBOTX");
                aISupportAuditBO.doAISupportAuditTaskBatch(province,year,null);
                istrue = false;
                logger.info("++++++++++++定时任务AI辅助审核结束,区划"+province+"年度"+year);
            } else {
                logger.info("++++++++++++定时任务AI辅助审核上次执行未结束");
            }
        }catch (Throwable e) {
            istrue = false;
            throw e;
        }

    }

}
