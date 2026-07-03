package gov.mof.fasp2.pmkpi.setting.auditdefine.busauditdefine;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 9:23 2020/9/19  chongdayong
 */
public class BusAuditDefineService extends PmkpiService {
    private BusAuditDefineBO busAuditDefineBO;

    public void setBusAuditDefineBO(BusAuditDefineBO busAuditDefineBO) {
        this.busAuditDefineBO = busAuditDefineBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("menudata", this.getMenuTree());
        config.put("wfstatusdata", this.getWfStatusTree(new HashMap<String, Object>()));
        return config;
    }

    public List<Map<String, Object>> getMenuTree(){
        return busAuditDefineBO.getMenuTree();
    }

    public List<Map<String, Object>> getWfStatusTree(HashMap<String, Object> params){
        return busAuditDefineBO.getWfStatusTree(params);
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return busAuditDefineBO.getData(parms);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            busAuditDefineBO.save(parms);
            rs.put("success", true);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 删除扩展菜单
     * @param parms --
     * @return
     */
    public Map<String, Object> delMenu(HashMap<String,Object> parms){
        return busAuditDefineBO.delMenu(parms);
    }
}
