package gov.mof.fasp2.pmkpi.setting.auditprocess.naturesaudit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 21:29 2020/8/13  chongdayong
 */
public class NaturesAuditService extends PmkpiService {
    private NaturesAuditBO naturesAuditBO;

    public void setNaturesAuditBO(NaturesAuditBO naturesAuditBO) {
        this.naturesAuditBO = naturesAuditBO;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            naturesAuditBO.tablesave(params);
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
        return naturesAuditBO.getData(parms);
    }

    /**
     * 生成guid
     * @return
     */
    public String getCreateguid() throws AppException {
        return naturesAuditBO.getCreateguid();
    }
}
