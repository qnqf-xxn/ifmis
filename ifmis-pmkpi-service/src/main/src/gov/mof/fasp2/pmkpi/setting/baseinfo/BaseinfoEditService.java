package gov.mof.fasp2.pmkpi.setting.baseinfo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class BaseinfoEditService extends PmkpiService {

    private BaseinfoBO baseinfoBO;

    public void setBaseinfoBO(BaseinfoBO baseinfoBO) {
        this.baseinfoBO = baseinfoBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String viewtype = request.getParameter("viewtype");
        String tablecode = request.getParameter("tablecode");
        String guid = request.getParameter("guid");
        String mainguid = request.getParameter("mainguid");
        String isSx = request.getParameter("isSx");
        if(viewtype != null && !"add".equals(viewtype)) {
            config.put("datas",baseinfoBO.getDatasByGuid(tablecode, guid));
        }
        config.put("viewtype", viewtype);
        config.put("tablecode", tablecode);
        config.put("guid", guid);
        config.put("mainguid", mainguid);
        String uikey = (String) config.get("pageurl"); //获取配置了多少页签
        if(!StringUtil.isEmpty(isSx) &&"isSx".equals(isSx)){
            config.put("isSx","isSx");
        }
        config.put("tabData", baseinfoBO.getTabData(uikey));
        return config;
    }
    /**
     * 编辑区保存数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> saveDatas(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        try {
            baseinfoBO.saveDatas(params);
            backMap.put("success", true);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 编辑区查询
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        return baseinfoBO.editquery(params);
    }

    /**
     * 编辑区保存数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> infosave(HashMap<String, Object> params) {
        params.put("guid",params.get("mainguid").toString());
        Map<String, Object> backMap = this.saveDatas(params);
        return backMap;
    }

    /**
     * 列表查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return baseinfoBO.getData(parms);
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> tablesave(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            baseinfoBO.tablesave(params);
            rs.put("success",true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
