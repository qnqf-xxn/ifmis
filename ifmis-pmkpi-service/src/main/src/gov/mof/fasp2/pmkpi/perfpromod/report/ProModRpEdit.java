package gov.mof.fasp2.pmkpi.perfpromod.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProModRpEdit extends PmkpiService {
    /**
     * 注入bo.
     */
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
        String saveAgency = request.getParameter("saveAgency"); //单位处室
        String mainguid = request.getParameter("mainguid"); //主键
        String proguid = request.getParameter("proguid"); //调整项目guid
        String pagetype = request.getParameter("pagetype");//页面类型 调整/监审
        config.put("workflow",workflow);
        config.put("prolev",prolev);
        config.put("saveAgency",saveAgency);
        config.put("mainguid",mainguid);
        config.put("proguid",proguid);
        String viewtype = request.getParameter("viewtype"); //项目一二三级项目
        config.put("viewtype",viewtype);
        String uikey = (String) config.get("pageurl"); //获取配置了多少页签.
        config.put("tabData", proModRpBO.getTabData(uikey));
        config.put("pagetype", pagetype);
        return config;
    }
    
    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return proModRpBO.getData(parms);
    }
    
    /**
     * 编辑区查询
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        return proModRpBO.editquery(params);
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
            rs = proModRpBO.infosave(config);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> tablesave(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = proModRpBO.tablesave(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
