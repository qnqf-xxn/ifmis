package gov.mof.fasp2.pmkpi.timetask;

import gov.mof.fasp2.buscore.framework.log.service.LogFactory;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.pmkpi.perfself.pushdatacommun.PushDataCommunBO;
import gov.mof.fasp2.pmkpi.perfself.pushdatacommun.PushDataCommunDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DataCommunicationTask {

    private static boolean istrue = false;
    private static Logger logger = LogFactory.getLog(DataCommunicationTask.class);

    public static void dataCommunication(String[] args) throws Throwable {
        try {
            if (!istrue) {
                logger.info("++++++++++++定时任务推送数据到数据交互开始");
                istrue = true;
                PushDataCommunBO pushDataCommunBO = (PushDataCommunBO) PerfServiceFactory.getBean("pmkpi.perfself.PushDataCommunBOTX");
                // 1. 获取 Token（POST 表单
                // 2. 查询待推送数据
                String wheresql = " t.datacommun = ?";
                List<Map<String, Object>> datas = pushDataCommunBO.getDatas(PushDataCommunDAO.PERF_VIEW_DATACOMMUN, wheresql, null, new String[]{"2"});
                if (!datas.isEmpty()) {
                    pushDataCommunBO.createSXDataCommunicationFile(datas);
                } else {
                    logger.info("++++++++++++没有需要推送的数据");
                }
                istrue = false;
                logger.info("++++++++++++定时任务推送数据到数据交互结束");
            } else {
                logger.info("++++++++++++定时任务推送数据到数据交互上次执行未结束");
            }
        } catch (Throwable e) {
            istrue = false;
            throw e;
        }
    }
}