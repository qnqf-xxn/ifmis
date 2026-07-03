package gov.mof.fasp2.pmkpi.perfset.datarule;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busfw.util.ServiceFactory;

public class PmkpiRightService implements IPmkpiRightService {
    /**
     * 数据权限.
     */
    private PerfDataRuleService dataRuleService;

    public PerfDataRuleService getPerfDataRuleService() {
        if(dataRuleService == null){
            dataRuleService = (PerfDataRuleService) ServiceFactory.getBean("pmkpi.perfset.PerfDataRuleService");
        }
        return dataRuleService;
    }

    /**
     * 
     * 创建一个新的实例 PmkpiRightService.
     */
    public PmkpiRightService() {
        
    }
    @Override
    public String getPageDataRights(String menuid, String tablealias) throws AppException {
        return getPerfDataRuleService().getDataRuleByMenuguid(menuid, tablealias);
    }

}
