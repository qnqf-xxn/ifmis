package gov.mof.fasp2.pmkpi.setting.dataset;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class PerfDataSetService extends PmkpiService {
    private PerfDataSetBO perfDataSetBO;
    /**
     * 日志.
     */
    protected static Logger logger = Logger.getLogger(PerfDataSetService.class);

    public void setPerfDataSetBO(PerfDataSetBO perfDataSetBO) {
        this.perfDataSetBO = perfDataSetBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String guid = request.getParameter("guid");
        if (!StringUtil.isEmpty(guid)) {
            String tablecode = request.getParameter("tablecode");
            if (!StringUtil.isEmpty(tablecode)) {
                StringBuffer wheresql = new StringBuffer(" guid ='").append(guid).append("'");
                String view = tablecode.substring(0, 3);
                if (!"V_".equals(view) && !"v_".equals(view)) {
                    Integer year = SecureUtil.getUserSelectYear();
                    String province = SecureUtil.getUserSelectProvince();
                    config.put("year", year);
                    config.put("province", province);
                    wheresql.append(" and ").append("year='").append(year).append("'");
                    wheresql.append(" and ").append("province='").append(province).append("'");
                }
                config.put("infoedit", perfDataSetBO.getDataMap(tablecode, wheresql.toString()));
                config.put("guid", guid);
                config.put("tablecode", tablecode);
            }
        }
        return config;
    }

    /**
     * 保存
     *
     * @param params
     */
    public Map<String, Object> save(Map<String, Object> params) {
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            perfDataSetBO.save(params);
            remp.put("success", true);
        } catch (PerfAppException e) {
            remp = e.getRemap();
            remp.put("code", e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return remp;
    }

    /**
     * 以区划，年度，guid为主键的增删改
     *
     * @param params
     * @return
     */
    public Map<String, Object> savemajorkey(Map<String, Object> params) {
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            perfDataSetBO.savemajorkey(params);
            remp.put("success", true);
        } catch (PerfAppException e) {
            remp = e.getRemap();
            remp.put("code", e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
            remp.put("success", false);
            remp.put("msg", e.getMessage());
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            logger.error("-----------------------"+e.getMessage());
            String message = e.getMessage();
            if(message.contains("ORA-00001")){
                remp.put("msg", "主键冲突");
            }else{
                remp.put("msg", e.getMessage());
            }
            remp.put("success", false);
        }
        return remp;
    }

    /**
     * 初始化分区
     *
     * @param params
     * @return
     * @throws Exception
     */
    public Map<String, Object> initset(HashMap<String, Object> params) {
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            Boolean result = perfDataSetBO.initset(params);
            remp.put("success", result);
            remp.put("msg", "初始化");
        } catch (AppException e) {
            remp.put("success", false);
            remp.put("msg", e.getMessage());
        }

        return remp;
    }

    /**
     * 左侧树初始化分区
     *
     * @param params
     * @return
     * @throws Exception
     */
    public Map<String, Object> initleftset(HashMap<String, Object> params) {
        Map<String, Object> remp = new HashMap<String, Object>();
        Boolean result = null;
        try {
            result = perfDataSetBO.initleftset(params);
        } catch (Exception e) {
            result = false;
        }

        remp.put("success", result);
        remp.put("msg", "初始化");
        return remp;
    }

    /**
     * 编辑区保存.
     * @param params 参数.
     * @return
     * @throws Exception
     */
    public Map<String, Object> editSave(HashMap<String, Object> params) throws Exception{
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            perfDataSetBO.editSave(params);
            remp.put("success", true);
        } catch (PerfAppException e) {
            remp = e.getRemap();
            remp.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return remp;
    }
}
