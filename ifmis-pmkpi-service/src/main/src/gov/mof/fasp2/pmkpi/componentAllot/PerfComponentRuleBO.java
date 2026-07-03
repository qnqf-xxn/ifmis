package gov.mof.fasp2.pmkpi.componentAllot;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.menu.MenuDTO;
import gov.mof.fasp2.buscore.ca.role.service.IRoleService;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfComponentRuleBO extends PmkpiBO {

    private PerfComponentRuleDAO perfComponentRuleDAO;

    @Resource(name="pmkpi.componentAllot.PerfComponentRuleDAO")
    public void setPerfComponentRuleDAO(PerfComponentRuleDAO perfComponentRuleDAO) {
        this.perfComponentRuleDAO = perfComponentRuleDAO;
    }

    public List getRoleTree(String roletype) throws AppException {
        List rtlist = new ArrayList();
        IRoleService roleService = (IRoleService) ServiceFactory.getBean("buscore.ca.role.service");
        StringBuffer whereSql = new StringBuffer(200);
        whereSql.append(" roletype='");
        whereSql.append(roletype);
        if("edb".equals(DbTypeUtil.getCurrentDBType()) && "polardb".equalsIgnoreCase(DbTypeUtil.getPhysicsDbType())){
            whereSql.append("' and province = global_multyear_cz.v_pmdivid ");
        } else {
            whereSql.append("' and province = global_multyear_cz.Secu_f_GLOBAL_PARM('DIVID') ");
        }
        whereSql.append(" and status <>3 ");
        List list = roleService.queryRolesBySql(whereSql.toString());
        String isSX = PerfUtil.getSystemSet("isSX"); //是否是山西环境
        if(isSX != null && !isSX.isEmpty() && "1".equals(isSX)){
            //山西全省通用角色
            StringBuffer sql = new StringBuffer();
            sql.append(" province is null and admdiv is null");
            sql.append(" and roletype='");
            sql.append(roletype);
            sql.append("' and status <>3 ");
            List publist = roleService.queryRolesBySql(sql.toString());
            list.addAll(publist);
        }
        Map m = null;
        for (int i = 0; i < list.size(); i++) {
            m = (Map) list.get(i);
            m.put("levelno", "1");
            m.put("isleaf", "1");
            m.put("parentid", "0");
            rtlist.add(m);
        }
        return rtlist;
    }

    public Map getTreeConfig(HashMap<String, Object> params) throws AppException {
        String roleguid = (String) params.get("roleid");
        String appid = (String) params.get("appid");
        Map leftconfig = new HashMap();
        List treeData =null;
        // 所选角色下的菜单
        IRoleService roleService = (IRoleService) ServiceFactory.getBean("buscore.ca.role.service");
        List<MenuDTO> list = roleService.getMenus(roleguid, appid);
        StringBuffer procodstr = new StringBuffer();
        Map imptemp = new HashMap();
        int len = list.size();
        for (int i = 0; i < len; i++) {
            imptemp = list.get(i);
            if (i != 0){
                procodstr.append(",");
            }
            procodstr.append("'").append(imptemp.get("guid")).append("'");
        }
        if (list.size()>0){
            String wheresql =" start with t.superguid in ("+procodstr.toString()+")  connect by prior t.guid = t.superguid";
            treeData = perfComponentRuleDAO.getTreeData(roleguid,wheresql);
        }
        leftconfig.put("datas", treeData);
        return leftconfig;
    }

    public Map getOperation(HashMap<String, Object>  params) throws AppException {
        String url = (String) params.get("key");
        String roleGuid = (String) params.get("roleGuid");
        String compns = (String) params.get("compns");
        String id = (String) params.get("id");
        String menuguid = (String) params.get("menuguid");
        String issave = (String) params.get("issave");
        Map result = new HashMap();
        if (compns != null && url != null) {
            String[] keys = url.split("\\.");
            String key = keys[0];
            String tablecode = "";
            String cols = "";
            if ("bustoolbutton".equals(compns)) {
                tablecode = "busfw_t_uifunction";
                cols = ",name as colname ";
            } else if ("busuidatatable".equals(compns)) {
                tablecode = "busfw_t_uicolumn";
                cols = ",name||'-'||columncode as colname ";
            } else if ("bustabpage".equals(compns)) {
                tablecode = "busfw_t_uitabpage";
                cols = ",name as colname ";
            } else if ("buseditform".equals(compns)) {
                tablecode = "busfw_t_uieditform";
                cols = ",name||'-'||columncode as colname ";
            }
            String wheresql = " t.url = '" + key + "' and t.componentid = '" + compns + "' and t.id ='"+ id +"'";
            Map<String, Object> pageConfig = perfComponentRuleDAO.getDataMap("bus_t_pageconsolecomconfig", wheresql);//查询组件表数据
            Map config = PerfUtil.parseString2Map((String) pageConfig.get("config"));
            String uikey = (String) config.get("key");
            if (!StringUtil.isEmpty(uikey)){
                key = uikey;
            }
            List<Map<String, Object>> uifunction = perfComponentRuleDAO.getUiDatas(key, tablecode, cols);
            //保存时，只查询ui配置表
            if (!"1".equals(issave)) {
                wheresql = "key = ? and componentid = ? and roleguid = ? and menuguid = ?";
                List<Map<String, Object>> datas = perfComponentRuleDAO.getDatas(perfComponentRuleDAO.PERF_TABLE_COMPONET_POWER, wheresql, null, new String[]{key, compns, roleGuid, menuguid});
                if (datas.size() > 0) {//进行中间表展示回显详情数据
                    Map map = new HashMap();
                    for (Map<String, Object> data : datas) {
                        String buttonguid = (String) data.get("buttonguid");
                        map.put(buttonguid, data);
                    }
                    String name = "";
                    for (Map<String, Object> objectMap : uifunction) {
                        if ("bustoolbutton".equals(compns)) {
                            name = (String) objectMap.get("name");
                        } else if ("bustabpage".equals(compns)) {//页签：填报明细根据componentid，列表根据code区分
                            name = (String) (StringUtil.isEmpty((String) objectMap.get("componentid")) ? objectMap.get("code") : objectMap.get("componentid"));
                        } else if ("buseditform".equals(compns) || "busuidatatable".equals(compns)) {
                            name = (String) objectMap.get("columncode");
                        }
                        if (map.containsKey(name)) {
                            Map mainmap = (Map<String, Object>) map.get(name);
                            objectMap.put("isvisiable", mainmap.get("isvisiable"));
                            objectMap.put("isedit", mainmap.get("isedit"));
                        }
                    }
                }
            }
            result.put("uifunction", uifunction);
        }
        return result;
    }

    /**
     * 查询角色已经分配的菜单.
     * @return
     * @throws
     */
    @SuppressWarnings("unchecked")
    public Map<String, String> getRightMenuByRoleId(HashMap<String, Object> params) throws AppException {
        Map result = new HashMap();
        String roleid = (String) params.get("roleid");
        Map leftconfig = this.getTreeConfig(params);
        result.put("leftconfig", leftconfig);
        result.put("uiMenus", this.getDataRult(roleid));
        return result;
    }

    /**
     * 查询已经有组件权限的菜单
     * @param roleid
     * @return
     */
    public List<Map<String, Object>> getDataRult(String roleid){
        return perfComponentRuleDAO.getUIMenuByRoleId(roleid);
    }

    public Map<String, Object> getOptionDatas(HashMap<String, Object> params) throws AppException {
        String roleguid = (String) params.get("roleguid");
        String url = (String) params.get("uikey");
        String menuguid = (String) params.get("menuguid");
        if (StringUtil.isEmpty(url)) {
            return null;
        }
        Map result = new HashMap();
        String key = url.split("\\.")[0];
        String wheresql = " t.url = ? and  t.componentid in ('bustoolbutton','bustabpage','busuidatatable','buseditform')";
        List<Map<String, Object>> pageConfig = perfComponentRuleDAO.getDatas("bus_t_pageconsolecomconfig", wheresql, null, new String[]{key});//查询组件表数据
        String keys = "'" + key +"',";
        for (Map<String, Object> map : pageConfig) {
            String componentid = (String) map.get("componentid");
            String id = (String) map.get("id");
            String name = componentid+"-"+id;
            map.put("name", name);
            Map config = PerfUtil.parseString2Map((String) map.get("config"));
            String uikey = (String) config.get("key");
            if (!StringUtil.isEmpty(uikey)){
                keys += "'" + uikey + "',";
            }
        }
        keys = keys.substring(0, keys.length() - 1);
        result.put("datas", pageConfig);
        String sql = "(select wm_concat(distinct componentid) componentids from " + perfComponentRuleDAO.PERF_TABLE_COMPONET_POWER + " where key in(" + keys + ") and roleguid=? and menuguid=?)";
        Map dataMap = perfComponentRuleDAO.getDataMap(sql, null, new String[]{roleguid, menuguid});
        if (!dataMap.isEmpty()) {
            String componentids = (String) dataMap.get("componentids");
            result.put("componentids", componentids);
        }
        return result;
    }

    public void save(HashMap<String, Object>  params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String roleGuid = (String) params.get("roleGuid");
        String menuguid = (String) params.get("menuguid");
        String componentid = (String) params.get("componentid");
        String menutype = (String) params.get("menutype");
        String key = (String) params.get("key");
        String id = (String) params.get("id");
        params.put("compns", componentid);
        params.put("issave", "1");
        Map<String, Object> uiMaps = this.getOperation(params);
        List<Map<String, Object>> uiDatas = (List<Map<String, Object>>) uiMaps.get("uifunction");
        List<Map<String, Object>> saveList = new ArrayList<>();
        Map<String, Object> uiMAp = new HashMap<>();
        if ("bustoolbutton".equals(componentid)) {
            uiDatas.forEach(map -> {
                uiMAp.put((String) map.get("name"), map);
            });
        } else if ("bustabpage".equals(componentid)) {
            uiDatas.forEach(map -> {
                String buttonguid = (String) (StringUtil.isEmpty((String) map.get("componentid")) ? map.get("code") : map.get("componentid"));
                uiMAp.put(buttonguid, map);
            });
        } else if ("buseditform".equals(componentid) || "busuidatatable".equals(componentid)) {
            uiDatas.forEach(map -> {
                uiMAp.put((String) map.get("columncode"), map);
            });
        }
        for (Map<String, Object> map : datas) {
            String buttonguid = "";
            String isvisiable = map.get("isvisiable") + "";
            String isedit = "";
            if ("bustoolbutton".equals(componentid)) {
                buttonguid = (String) map.get("name");
            } else if ("bustabpage".equals(componentid)) {
                buttonguid = (String) (StringUtil.isEmpty((String) map.get("componentid")) ? map.get("code") : map.get("componentid"));
            } else if ("buseditform".equals(componentid) || "busuidatatable".equals(componentid)) {
                buttonguid = (String) map.get("columncode");
                isedit = map.get("isedit") + "";
            }
            if (uiMAp.containsKey(buttonguid)) {
                Map<String, Object> uidata = (Map<String, Object>) uiMAp.get(buttonguid);
                String uiisvisiable = uidata.get("isvisiable") + "";
                String uiisedit = uidata.get("isedit") + "";
                boolean issave = false;
                if ("bustoolbutton".equals(componentid) || "bustabpage".equals(componentid)) {
                    if (!uiisvisiable.equals(isvisiable)) {
                        issave = true;
                    }
                }
                if ("buseditform".equals(componentid) || "busuidatatable".equals(componentid)) {
                    if (!uiisvisiable.equals(isvisiable) || !uiisedit.equals(isedit)) {
                        issave = true;
                    }
                }
                if (issave) {
                    map.put("guid", StringUtil.createUUID());
                    map.put("roleguid", roleGuid);
                    map.put("buttonguid", buttonguid);
                    map.put("componentid",componentid);
                    map.put("id", id);
                    map.put("menuguid", menuguid);
                    map.put("userguid", CommonUtil.getCurrentUserID());
                    map.put("createtime", CommonUtil.getTimeStamp());
                    map.put("updatetime", CommonUtil.getTimeStamp());
                    map.put("year", CommonUtil.getYear());
                    map.put("province", CommonUtil.getProvince());
                    saveList.add(map);
                }
            }
        }
        perfComponentRuleDAO.delDataOpe(roleGuid, menuguid, componentid);
        if (!saveList.isEmpty()) {
            perfComponentRuleDAO.saveAll(saveList, perfComponentRuleDAO.PERF_TABLE_COMPONET_POWER);
        }
        String cacheKey = perfComponentRuleDAO.PMKPI_CACHE_COMPONETPOWER + roleGuid + id + key;
        if (!"perfmenu".equals(menutype)) {
            cacheKey += "_" + menuguid;
        }
        //添加/更新缓存
        PerfUtil.reflashSynCacheJSONData(cacheKey, PerfUtil.parse2Json(saveList), false);
    }

    public void clearsave(HashMap<String, Object>  params) throws AppException {
        String roleGuid = (String) params.get("roleGuid");
        String menuguid = (String) params.get("menuguid");
        String componentid = (String) params.get("componentid");
        String menutype = (String) params.get("menutype");
        String key = (String) params.get("key");
        String id = (String) params.get("id");
        perfComponentRuleDAO.delDataOpe(roleGuid, menuguid, componentid);
        String cacheKey = perfComponentRuleDAO.PMKPI_CACHE_COMPONETPOWER + roleGuid + id + key;
        if (!"perfmenu".equals(menutype)) {
            cacheKey += "_" + menuguid;
        }
        //更新缓存
        PerfUtil.reflashSynCacheJSONData(cacheKey, PerfUtil.parse2Json(PerfUtil.NODATA), false);
    }

}
