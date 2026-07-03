package gov.mof.fasp2.pmkpi.rectification.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.rectification.bo.RectificationQueryBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RectificationQueryService extends PmkpiService {
    private RectificationQueryBO rectificationQueryBO;

    public void setRectificationQueryBO(RectificationQueryBO rectificationQueryBO) {
        this.rectificationQueryBO = rectificationQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request,
                             HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String menuId = request.getParameter("menuId");
        String type = request.getParameter("type");
        String mainguid = request.getParameter("mainguid");
        config.put("deptqfdatas", rectificationQueryBO.getQueryFrom("/pmkpi/rectification/index/dept"));
        config.put("proqfdatas", rectificationQueryBO.getQueryFrom("/pmkpi/rectification/index"));
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
        return rectificationQueryBO.getLeftTreeData(params);
    }

    /**
     * 删除
     * @param config
     * @return
     * @throws AppException
     */
    public Map delByGuids(HashMap config) throws AppException {
        return rectificationQueryBO.delByGuids(config);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = rectificationQueryBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getCode() + e.getMessage().replace(e.getCode(), ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String,Object>> getDataByGuid(HashMap<String,Object> params) throws AppException {
        return rectificationQueryBO.getDataByGuid(params);
    }
}
