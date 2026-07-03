package gov.mof.fasp2.pmkpi.rectification.dept;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RectificationDeptService extends PmkpiService {
    private RectificationDeptBO rectificationDeptBO;

    public void setRectificationDeptBO(RectificationDeptBO rectificationDeptBO) {
        this.rectificationDeptBO = rectificationDeptBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request,
                             HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String menuId = request.getParameter("menuId");
        String type = request.getParameter("type");
        String mainguid = request.getParameter("mainguid");
        config.put("deptqfdatas", rectificationDeptBO.getQueryFrom("/pmkpi/rectification/index/dept"));
        config.put("proqfdatas", rectificationDeptBO.getQueryFrom("/pmkpi/rectification/index"));
        config.put("mainguid",mainguid);
        config.put("type",type);
        config.put("menuid", menuId);
        return config;
    }

    /**
     * 切换左侧页签 -- 查询左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getLeftTreeData (HashMap<String, Object> params) throws AppException {
        return rectificationDeptBO.getLeftTreeData(params);
    }

    /**
     * 删除
     * @param config
     * @return
     * @throws AppException
     */
    public Map delByGuids(HashMap config) throws AppException {
        return rectificationDeptBO.delByGuids(config);
    }

    /**
     * 下达
     * @param params --
     * @return --
     */
    public Map<String, Object> send(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        rectificationDeptBO.send(params);
        rs.put("success",true);
        return rs;
    }

    /**
     * 下达
     * @param params --
     * @return --
     */
    public Map<String, Object> cancleSend(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        rectificationDeptBO.cancleSend(params);
        rs.put("success",true);
        return rs;
    }
}
