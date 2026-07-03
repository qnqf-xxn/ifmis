package gov.mof.fasp2.pmkpi.timetask;

import gov.mof.fasp2.buscore.framework.log.service.LogFactory;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.probleamtask.ProblemTaskBO;

/**
 * 问题整改反馈短信
 */
public class ProblemTaskSmsSendTask {
    private static boolean istrue = false;
    private static Logger logger = LogFactory.getLog(ProblemTaskSmsSendTask.class);
    /**
     * 问题整改反馈短信
     * @param args
     * @throws Throwable
     */
    public static void smsSendTask(String[] args) throws Throwable{
        try {
            if (!istrue) {
                logger.info("++++++++++++定时任务问题整改反馈短信提醒开始");
                istrue = true;
                //问题整改反馈短信
                ProblemTaskBO problemTaskBO =(ProblemTaskBO)PerfServiceFactory.getBean("pmkpi.probleamtask.ProblemTaskBOTX");
                problemTaskBO.smsSendTask();
                istrue = false;
                logger.info("++++++++++++定时任务问题整改反馈短信提醒结束");
            } else {
                logger.info("++++++++++++定时任务问题整改反馈短信提醒上次执行未结束");
            }
        }catch (Throwable e) {
            istrue = false;
            throw e;
        }

    }

}
