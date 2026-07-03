package gov.mof.fasp2.pmkpi.tabfream;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 9:47 2020/8/24  chongdayong
 */
public class TabfreamService extends PmkpiService {
    protected static Logger logger = Logger.getLogger(TabfreamService.class);

    private TabfreamBO tabfreamBO;

    public void setTabfreamBO(TabfreamBO tabfreamBO) {
        this.tabfreamBO = tabfreamBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        config.put("treesource", PerfUtil.getSystemSet("dept_letftree"));
        config.put("workflow",workflow);
        config.put("isPilot",tabfreamBO.isPilot() + "");
        return config;
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
        return tabfreamBO.del(parms);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = tabfreamBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
    
    /**
     * 查询部门已申报数据.
     * @param parms --
     * @return --
     */
    public Map<String,Object> getDeclareData(HashMap<String,Object> parms) {
        return tabfreamBO.getDeclareData(parms);
    }

}
