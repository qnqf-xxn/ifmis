package gov.mof.fasp2.pmkpi.setting.indexlib.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 14:53 2020/8/17  chongdayong
 */
public class IndexAuditService extends PmkpiService {

    private IndexAuditBO indexAuditBO;

    @Resource(name = "pmkpi.setting.indexlib.audit.IndexAuditBOTx")
    public void setIndexAuditBO(IndexAuditBO indexAuditBO) {
        this.indexAuditBO = indexAuditBO;
    }

    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String menuid = request.getParameter("menuId");
//        String workflow = request.getParameter("workflow");
        String isZJ = PerfUtil.getSystemSet("isZJ");
        config.put("isZJ", isZJ);
        config.put("menuid",menuid);
//        config.put("workflow",workflow);
        return config;
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = indexAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<DicRangeDTO> getTreeData (HashMap<String, Object> params) throws AppException {
        return indexAuditBO.getTreeData(params);
    }
}
