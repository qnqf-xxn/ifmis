package gov.mof.fasp2.pmkpi.adjust.editquery;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class EditQueryService extends PmkpiService {
    private EditQueryBO editQueryBO;

    public void setEditQueryBO(EditQueryBO editQueryBO) {
        this.editQueryBO = editQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String mainguid = request.getParameter("mainguid"); //主键
        String proguid = request.getParameter("proguid"); //调整项目guid
        String saveAgency = request.getParameter("saveAgency"); //调整项目guid
        String viewtype = request.getParameter("viewtype"); //页面状态，修改/查看
        config.put("viewtype",viewtype);
        config.put("mainguid",mainguid);
        config.put("proguid",proguid);
        config.put("saveAgency",saveAgency);
        return config;
    }

    /**
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = editQueryBO.save(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
