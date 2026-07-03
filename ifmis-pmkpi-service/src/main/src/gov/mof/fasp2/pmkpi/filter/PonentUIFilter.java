package gov.mof.fasp2.pmkpi.filter;

import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busfw.ui.AbstractUIComponentService;
import gov.mof.fasp2.busfw.ui.IUIComponentConfigFilter;
import gov.mof.fasp2.busfw.ui.dto.*;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.componentAllot.PerfComponentRuleDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class PonentUIFilter  implements IUIComponentConfigFilter {


    @Override
    public Map doFilter(HttpServletRequest request, HttpServletResponse response, Map config, AbstractUIComponentService component) throws AppException {
        String menutype = (String) config.get("menutype");
        String id = (String) config.get("id");
        String menuId = request.getParameter("menuId");
        UserDTO user = SecureUtil.getCurrentUser();
        List<String> roles = (List) user.get("roles");
        List<Map<String, Object>> mainList = new ArrayList<>();
        List<String> roleguidList = new ArrayList<>();//不存在缓存中的角色配置
        List uidto = (List) config.get("data");
        if (uidto.size() > 0) {
            UIconfigDTO uiInfo = (UIconfigDTO) uidto.get(0);
            String key = (String) uiInfo.get("key");
            for (String roleguid : roles) { //缓存
                String cacheKey = PmkpiDAO.PMKPI_CACHE_COMPONETPOWER + roleguid + id + key;
                if (!"perfmenu".equals(menutype)) {
                    cacheKey += "_" + menuId;
                }
                String cacheData = PerfUtil.getCacheJSONData(cacheKey);
                if (cacheData != null) { //缓存中不存在
                    List<Map<String, Object>> datas = PerfUtil.parseString2List(cacheData);
                    mainList.addAll(datas);
                } else { // 除了删除了组件配置，其他的查库
                    roleguidList.add(roleguid);
                }
            }
            //不存在缓存中、查库
            if (!roleguidList.isEmpty()) {
                String[] strs;
                PmkpiDAO pmkpiDAO = PerfServiceFactory.getPmkpiDAO();
                StringBuffer wheresql = new StringBuffer();
                wheresql.append(pmkpiDAO.createInSql("t.roleguid", roleguidList));
                wheresql.append(" and t.key=? and t.id=?");
                if (!"perfmenu".equals(menutype)) {//有值则不查菜单id
                    wheresql.append(" and t.menuguid= ?");
                    strs = new String[]{key, id, menuId};
                } else {
                    strs = new String[]{key, id};
                }
                List<Map<String, Object>> list = pmkpiDAO.getDatas(PerfComponentRuleDAO.PERF_TABLE_COMPONET_POWER, wheresql.toString(), null, strs);
                //是否存在组件权限配置
                if (!list.isEmpty()) {
                    Map<String, List<Map<String, Object>>> roleguidMap = list.stream().collect(Collectors.groupingBy(m -> (String) m.get("roleguid")));
                    for (String roleguid : roleguidMap.keySet()) {
                        String cacheKey = PmkpiDAO.PMKPI_CACHE_COMPONETPOWER + roleguid + id + key;
                        if (!"perfmenu".equals(menutype)) {
                            cacheKey += "_" + menuId;
                        }
                        //添加缓存
                        PerfUtil.reflashCacheJSONData(cacheKey, PerfUtil.parse2Json(roleguidMap.get(roleguid)), false);
                    }
                    mainList.addAll(list);
                    //存在组件权限配置的角色去掉
                    roleguidList.removeAll(roleguidMap.keySet());
                }
                //不存在组件权限的角色，缓存置为空集合，避免反复查表
                if (!roleguidList.isEmpty()) {
                    for (String roleguid : roleguidList) {
                        String cacheKey = PmkpiDAO.PMKPI_CACHE_COMPONETPOWER + roleguid + id + key;
                        if (!"perfmenu".equals(menutype)) {
                            cacheKey += "_" + menuId;
                        }
                        //添加缓存
                        PerfUtil.reflashCacheJSONData(cacheKey, PerfUtil.parse2Json(new ArrayList<>()), false);
                    }
                }
            }
            if (mainList.size() > 0) {
                if (uiInfo instanceof ToolButtonDTO) {
                    this.doBotPageFilter(request, uidto, config, mainList);
                }
                if (uiInfo instanceof DatatableDTO) {
                    DatatableDTO uiconfig = (DatatableDTO) uiInfo;
                    this.doDatatableFilter(request, uidto, config, mainList, uiconfig);
                }
                if (uiInfo instanceof TabpageDTO) {
                    this.doTabFilter(request, uidto, config, mainList);
                }
                if (uiInfo instanceof EditFormDTO) {
                    this.doEditformFilter(request, uidto, config, mainList);
                }
            }
        }
        return config;
    }

    /**
     *
     * @Description:  按钮权限
     * @param request
     * @param config
     * @param mainList
     * @throws AppException
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    private void doBotPageFilter(HttpServletRequest request, List uidto, Map config, List<Map<String, Object>> mainList) {
        if (mainList.size() > 0) {
            Map<String, Object> ponentMap  = new HashMap<>();
            for (Map<String, Object> map : mainList) {
                String name = (String) map.get("buttonguid");
                ponentMap.put(name,map);
            }
            for (Object o : uidto) {
                ToolButtonDTO uiconfig = (ToolButtonDTO) o;
                String uiconfigName = uiconfig.getName();
                if (ponentMap.containsKey(uiconfigName)) {
                    Map<String, Object> perfMap = (Map<String, Object>) ponentMap.get(uiconfigName);
                    String isvisiable = perfMap.get("isvisiable") + "";
                    Integer isvible = Integer.parseInt(isvisiable);
                    uiconfig.setIsvisiable(isvible);
                }
            }
        }
    }

    /**
     *
     * @Description:  表格权限
     * @param request
     * @param uiconfig
     * @throws AppException
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    private void doDatatableFilter(HttpServletRequest request, List uidto, Map config, List<Map<String, Object>> mainList, DatatableDTO uiconfig) {
        if (mainList.size() > 0) {
            Map<String, Object> ponentMap  = new HashMap<>();
            for (Map<String, Object> map : mainList) {
                String name = (String) map.get("buttonguid");
                ponentMap.put(name,map);
            }
            List<DataColumnsDTO> coList = uiconfig.getCols();
            for (Object o : coList) {
                DataColumnsDTO col = (DataColumnsDTO) o;
                String colCode = col.getColcode().toUpperCase();
                if (ponentMap.containsKey(colCode)) {
                    Map<String, Object> perfMap = (Map<String, Object>) ponentMap.get(colCode);
                    String isvisiable = perfMap.get("isvisiable") + "";
                    String isedit = perfMap.get("isedit") + "";
                    Integer dit = Integer.parseInt(isedit);
                    Integer isvible = Integer.parseInt(isvisiable);
                    col.put("isvisiable", isvible);
                    if (isvible == 1) {
                        col.put("display", true);
                    } else {
                        col.put("display", false);
                    }
                    if (dit == 1) {
                        col.put("edit", true);
                    } else {
                        col.put("edit", false);
                    }

                }
            }
        }
    }

    /**
     *
     * @Description:  页签权限
     * @param request
     * @param config
     * @param mainList
     * @throws AppException
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    private void doTabFilter(HttpServletRequest request, List uidto, Map config, List<Map<String, Object>> mainList) {
        if (mainList.size() > 0) {
            Map<String, Object> ponentMap  = new HashMap<>();
            for (Map<String, Object> map : mainList) {
                String code = (String) map.get("buttonguid");
                ponentMap.put(code,map);
            }
            for (Object o : uidto) {
                TabpageDTO uiconfig = (TabpageDTO) o;
                String uiconfigCode = StringUtil.isEmpty(uiconfig.getComponentId()) ? uiconfig.getCode() : uiconfig.getComponentId();
                if (ponentMap.containsKey(uiconfigCode)) {
                    Map<String, Object> perfMap = (Map<String, Object>) ponentMap.get(uiconfigCode);
                    String isvisiable = perfMap.get("isvisiable") + "";
                    Integer isvible = Integer.parseInt(isvisiable);
                    uiconfig.put("isvisiable",isvible);
                    uiconfig.setIsvisiable(isvible);
                }
            }
        }
    }

    /**
     *
     * @Description:  编辑区
     * @param request
     * @param config
     * @param mainList
     * @throws AppException
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    private void doEditformFilter(HttpServletRequest request, List uidto, Map config, List<Map<String, Object>> mainList) {
        if (mainList.size() > 0) {
            Map<String, Object> ponentMap  = new HashMap<>();
            for (Map<String, Object> map : mainList) {
                String name = (String) map.get("buttonguid");
                ponentMap.put(name,map);
            }
            for (Object o : uidto) {
                EditFormDTO uiconfig = (EditFormDTO) o;
                String uiconfigCode = uiconfig.getColcode().toUpperCase();
                if (ponentMap.containsKey(uiconfigCode)) {
                    Map<String, Object> perfMap = (Map<String, Object>) ponentMap.get(uiconfigCode);
                    String isvisiable = perfMap.get("isvisiable") + "";
                    String isedit = perfMap.get("isedit") + "";
                    Integer isvible = Integer.parseInt(isvisiable);
                    Integer dit = Integer.parseInt(isedit);
                    uiconfig.setIsvisiable(isvible);
                    uiconfig.setIsedit(dit);
                }
            }
        }
    }
}
