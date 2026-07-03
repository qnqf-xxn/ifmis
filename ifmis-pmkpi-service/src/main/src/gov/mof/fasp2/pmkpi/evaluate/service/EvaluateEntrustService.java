package gov.mof.fasp2.pmkpi.evaluate.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.evaluate.bo.EvaluateEntrustBo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EvaluateEntrustService extends PmkpiService {

    private EvaluateEntrustBo evaluateEntrustBo;

    public void setEvaluateEntrustBo(EvaluateEntrustBo evaluateEntrustBo) {
        this.evaluateEntrustBo = evaluateEntrustBo;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String pagetype = request.getParameter("pagetype");
        String guid = request.getParameter("guid");
        config.put("workflow", request.getParameter("workflow"));
        config.put("maintablecode", request.getParameter("maintablecode"));
        config.put("guid", guid);
        config.put("pagetype", pagetype);
        config.put("remark", request.getParameter("remark"));
        return config;
    }
    /**
     * 查询已选中介；
     * @param params
     * @return
     */
    public Map<String,Object> queryselintermediary (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        List<Map<String,Object>> list =  evaluateEntrustBo.queryselintermediary(params);
        rs.put("success", true);
        rs.put("data", list);
        return rs;
    }

    /**
     * 保存
     * @param params
     * @return
     */
    public Map<String,Object> save (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            evaluateEntrustBo.saveEntrust(params);
            rs.put("success", true);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 删除
     * @param params
     * @return
     */
    public Map<String,Object> del (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            evaluateEntrustBo.delEntrust(params);
            rs.put("success", true);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 审核
     * @param params
     * @return
     */
    public Map<String,Object> audit (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = evaluateEntrustBo.auditEntrust(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 委托专家保存并审核；
     * @param params
     * @return
     */
    public Map<String,Object> saveaudit (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = evaluateEntrustBo.saveauditEntrust(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
