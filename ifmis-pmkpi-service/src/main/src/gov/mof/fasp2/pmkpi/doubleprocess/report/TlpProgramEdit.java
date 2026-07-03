package gov.mof.fasp2.pmkpi.doubleprocess.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class TlpProgramEdit extends PmkpiService {
    /**
     * 注入bo.
     */
    private TlpDoublepressBO tlpProgramBO;
    /**
     * bo.
     * @param tlpProgramBO
     * @throws
     */
    public void setTlpProgramBO(TlpDoublepressBO tlpProgramBO) {
        this.tlpProgramBO = tlpProgramBO;
    }
    
    @SuppressWarnings("unchecked")
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String pagetype = request.getParameter("pagetype");
        String proguid = request.getParameter("proguid");
        String prolev = request.getParameter("prolev"); //项目一二三级项目
        String saveAgency = request.getParameter("saveAgency"); //单位处室
        String mainguid = request.getParameter("mainguid"); //主键
        config.put("workflow",workflow);
        config.put("prolev",prolev);
        config.put("saveAgency",saveAgency);
        if ("audit".equals(pagetype)){
            config.put("mainguid",proguid);
        } else {
            config.put("mainguid",mainguid);
        }
        String viewtype = request.getParameter("viewtype"); //项目一二三级项目
        config.put("viewtype",viewtype);
        String uikey = (String) config.get("pageurl"); //获取配置了多少页签.
        config.put("tabData", tlpProgramBO.getTabData(uikey));
        return config;
    }
    /**
     * 项目基本信息查询.
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        return tlpProgramBO.editquery(params);
    }
    
    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map infosave(HashMap config) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = tlpProgramBO.infosave(config);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
