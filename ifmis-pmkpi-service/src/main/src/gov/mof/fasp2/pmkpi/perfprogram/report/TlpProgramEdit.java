package gov.mof.fasp2.pmkpi.perfprogram.report;

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
    private TlpProgramBO tlpProgramBO;
    /**
     * bo.
     * @param tlpProgramBO
     * @throws
     */
    public void setTlpProgramBO(TlpProgramBO tlpProgramBO) {
        this.tlpProgramBO = tlpProgramBO;
    }
    
    @SuppressWarnings("unchecked")
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String prolev = request.getParameter("prolev"); //项目一二三级项目
        String saveAgency = request.getParameter("saveAgency"); //单位处室
        String mainguid = request.getParameter("mainguid"); //主键
        String procode = request.getParameter("procode"); //项目编码
        config.put("workflow",workflow);
        config.put("prolev",prolev);
        config.put("saveAgency",saveAgency);
        config.put("mainguid",mainguid);
        String viewtype = request.getParameter("viewtype"); //项目一二三级项目
        config.put("viewtype",viewtype);
        config.put("procode",procode);
        String uikey = (String) config.get("pageurl"); //获取配置了多少页签.
        config.put("tabData", tlpProgramBO.getTabData(uikey));
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms){
        Map<String, Object> backMap = new HashMap<>();
        try {
            backMap = tlpProgramBO.getData(parms);
            backMap.put("flg", "1");
            backMap.put("msg", "查询成功");
        } catch (AppException e) {
            backMap.put("flg", "0");
            backMap.put("msg", e.getMessageNoCode().replaceAll("-null", "查询失败"));
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 编辑区查询
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<>();
        try {
            backMap = tlpProgramBO.editquery(params);
            backMap.put("flg", "1");
            backMap.put("msg", "查询成功");
        } catch (AppException e) {
            backMap.put("flg", "0");
            backMap.put("msg", e.getMessageNoCode().replaceAll("-null", "查询失败"));
            logger.error(e.getMessage(), e);
        }
        return backMap;
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

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> tablesave(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = tlpProgramBO.tablesave(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
