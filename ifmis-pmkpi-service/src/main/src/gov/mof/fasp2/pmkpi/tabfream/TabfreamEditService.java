package gov.mof.fasp2.pmkpi.tabfream;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 9:57 2020/8/24  chongdayong
 */
public class TabfreamEditService extends PmkpiService {
    private TabfreamBO tabfreamBO;

    public void setTabfreamBO(TabfreamBO tabfreamBO) {
        this.tabfreamBO = tabfreamBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        Enumeration paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = (String) paramNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            if (paramValues.length >= 1) {
                String paramValue = paramValues[0];
                if (paramValue.length() != 0) {
                    config.put(paramName, paramValue);
                }
            }
        }
        String procode = (String) config.get("procode");
        if (StringUtil.isEmpty(procode)) {
            procode = request.getParameter("pro_code");
            config.put("procode", procode);
        }
        config.put("issaveall", PerfUtil.getSystemSet("isaveall"));
        config.put("isGX", PerfUtil.getIsGuangXi() + "");
        config.put("isNX", PerfUtil.getIsNINGXIA());//宁夏参数
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
            backMap = tabfreamBO.getData(parms);
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
            backMap = tabfreamBO.editquery(params);
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
     * 保存全部组件数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> saveall(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = tabfreamBO.saveall(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
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
            rs = tabfreamBO.infosave(config);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
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
            rs = tabfreamBO.tablesave(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 预算审核调用绩效页面，保存审核标识
     * @param params
     * @return
     */
    public Map<String, Object> saveauditDatas(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = tabfreamBO.saveauditDatas(params);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs.put("success", false);
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }


    /**
     * 获取公式配置信息
     * @param params
     * @return
     */
    public Map<String, Object> getEditFormal(HashMap<String, Object> params){
        return tabfreamBO.getEditFormal(params);
    }

    /**
     * 获取公式数据
     * @param sql
     * @return
     */
    public BigDecimal getFormalValue(String sql){
        return tabfreamBO.getFormalValue(sql);
    }

    /**
     * 获取上年绩效目标/指标复制.
     * @param parms -- 参数
     * @return --
     */
    public Map<String, Object> copyPerf(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        try {
            backMap = tabfreamBO.copyPerf(parms);
            backMap.put("success", true);
        } catch (AppException e) {
            backMap.put("success", false);
            backMap.put("error", e.getMessage());
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 预警规则.
     * @param params
     * @return
     */
    public String getWarn(HashMap<String, Object> params) {
        return tabfreamBO.getWarn(params);
    }
}
