package gov.mof.fasp2.pmkpi.setting.auditprocess.auditnode;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 12:01 2020/8/14  chongdayong
 */
public class AuditNodeService extends PmkpiService {
    private AuditNodeB0 auditNodeB0;

    public void setAuditNodeB0(AuditNodeB0 auditNodeB0) {
        this.auditNodeB0 = auditNodeB0;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            auditNodeB0.tablesave(params);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return auditNodeB0.getData(parms);
    }
}
