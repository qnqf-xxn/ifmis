package gov.mof.fasp2.pmkpi.perfpromod.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProModRpService extends PmkpiService {

    private ProModRpBO proModRpBO;

    public void setProModRpBO(ProModRpBO proModRpBO) {
        this.proModRpBO = proModRpBO;
    }
    
    @SuppressWarnings("unchecked")
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String prolev = request.getParameter("prolev"); //项目一二三级项目
        config.put("workflow",workflow);
        config.put("prolev",prolev);
        String elementcode = PerfUtil.getSystemSet("tlprogram_lefttree_" + prolev); //来源elementcode
        String columncode = PerfUtil.getSystemSet("tlprogram_lefttree_col_" + prolev);  //表字段
        String pagetype = request.getParameter("pagetype");
        config.put("elementcode", elementcode);
        config.put("columncode", columncode);
        config.put("pagetype", pagetype);
        return config;
    }
    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> delDatas(HashMap<String,Object> parms){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            proModRpBO.delDatas(parms);
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
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = proModRpBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
