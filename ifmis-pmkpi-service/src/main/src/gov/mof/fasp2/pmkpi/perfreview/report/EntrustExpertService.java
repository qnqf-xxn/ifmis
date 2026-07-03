package gov.mof.fasp2.pmkpi.perfreview.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EntrustExpertService extends PmkpiService {

    private PerfReviewBO perfReviewBO;

    public void setPerfReviewBO(PerfReviewBO perfReviewBO) {
        this.perfReviewBO = perfReviewBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String menuId = request.getParameter("menuId");
        String guid = request.getParameter("guid");
        String proguid = request.getParameter("proguid");
        String workflow = request.getParameter("workflow");
        String pagetype = request.getParameter("pagetype");
        String maintablecode = request.getParameter("maintablecode");
        String remark = request.getParameter("remark");
        config.put("selcols", perfReviewBO.getCols("/pmkpi/review/entrust/selexpert"));
        config.put("menuId", menuId);
        config.put("guid", guid);
        config.put("proguid", proguid);
        config.put("workflow", workflow);
        config.put("pagetype", pagetype);
        config.put("maintablecode", maintablecode);
        config.put("remark", remark);
        config.put("viewtype", request.getParameter("viewtype"));
        return config;
    }

    /**
     * 查询已选专家；
     * @param params
     * @return
     */
    public Map<String,Object> queryselexpert (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
            List<Map<String,Object>> list =  perfReviewBO.queryselexpert(params);
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
            perfReviewBO.saveEntrust(params);
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
            perfReviewBO.delEntrust(params);
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
            rs = perfReviewBO.auditEntrust(params);
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
            rs = perfReviewBO.saveauditEntrust(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
