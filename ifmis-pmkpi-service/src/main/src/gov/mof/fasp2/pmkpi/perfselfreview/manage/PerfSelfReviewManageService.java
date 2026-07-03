package gov.mof.fasp2.pmkpi.perfselfreview.manage;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfSelfReviewManageService extends PmkpiService {
    public PerfSelfReviewManageBO perfSelfReviewManageBO;

    public void setPerfSelfReviewManageBO(PerfSelfReviewManageBO perfSelfReviewManageBO) {
        this.perfSelfReviewManageBO = perfSelfReviewManageBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return super.loadComponent(request, response, config);
    }

    /**
     * 保存
     * @param parms --
     * @return
     */
    public Map<String, Object> saveTask(HashMap<String,Object> parms) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfSelfReviewManageBO.saveTask(parms);
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> delTask(HashMap<String,Object> parms) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfSelfReviewManageBO.delTask(parms);
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * <p>左侧树-整合菜单首次进入页面</p >
     *
     * @param
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return perfSelfReviewManageBO.getTreeData(params);
    }

}
