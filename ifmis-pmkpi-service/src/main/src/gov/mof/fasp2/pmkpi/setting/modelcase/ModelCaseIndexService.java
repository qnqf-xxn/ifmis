package gov.mof.fasp2.pmkpi.setting.modelcase;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 11:15 2020/8/19  chongdayong
 */
public class ModelCaseIndexService extends PmkpiService {
    private ModelCaseBO modelCaseBO;

    public void setModelCaseBO(ModelCaseBO modelCaseBO) {
        this.modelCaseBO = modelCaseBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid"); //主键
        String framesystem = request.getParameter("framesystem");
        String uikey = (String) config.get("pageurl"); //获取配置了多少页签.
        config.put("mainguid", mainguid);
        config.put("framesystem", framesystem);
        config.put("tabData", modelCaseBO.getTabData(uikey));
        return config;
    }

    /**
     * 查询
     * @param params
     * @return
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        return modelCaseBO.getData(params);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    /*public Map<String, Object> del(HashMap<String,Object> parms){
        return modelCaseBO.del(parms);
    }*/

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map infosave(HashMap config) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = modelCaseBO.infosave(config);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 编辑区查询
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        return modelCaseBO.editquery(params);
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> tablesave(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            modelCaseBO.tablesave(params);
            rs.put("success",true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
    /**
     * 列表查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return modelCaseBO.getData(parms);
    }
}
