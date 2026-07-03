package gov.mof.fasp2.pmkpi.common.pendingtask;

import com.alibaba.fastjson.JSON;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.menu.MenuDTO;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.ca.user.service.IUserService;
import gov.mof.fasp2.buscore.ca.util.CaGlobalVariable;
import gov.mof.fasp2.buscore.framework.daosupport.cache.Fasp2DaoCacheUtil;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busportal.pendingtask.PendingTaskProtalDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.commons.lang.StringUtils;

import java.util.*;

public class PmkpiPendingBO  extends PmkpiBO {

    private PmkpiPendingDAO pmkpiPendingDAO;

    public void setPmkpiPendingDAO(PmkpiPendingDAO pmkpiPendingDAO) {
        this.pmkpiPendingDAO = pmkpiPendingDAO;
    }

    public List<PendingTaskProtalDTO> getPendingTask() throws Exception {
        UserDTO user = CommonUtil.getCurrentUser();
        List<PendingTaskProtalDTO> allList = new LinkedList<PendingTaskProtalDTO>();
        //获取用户下的菜单
        IUserService userService = (IUserService) ServiceFactory.getBean("buscore.ca.user.service");
        List<MenuDTO> menuList = userService.getFunctions(user != null ? user.getGuid() : null, "pmkpi");
        String province = SecureUtil.getUserSelectProvince(); //当前登录区划
        String isSx = PerfUtil.getSystemSet("isSX");
        if (1 != 1) {//待办暂时不走基础库
            //单独获取基础信息管理中的指标菜单
            String menusql = "select distinct tpm.* from fasp_t_causerrole tur, fasp_t_carolemenu trm"
                    + ", fasp_t_pubmenu tpm where tur.roleguid = trm.roleguid and tpm.guid = trm.menuguid "
                    + " and tur.userguid = ? and tpm.appid=? and tpm.url like '%/pmkpi%' order by tpm.menuorder asc";
            List indexList = pmkpiPendingDAO.query(menusql, new Object[] {user != null ? user.getGuid() : null, "bim" },
                    pmkpiPendingDAO.getRowMapper(MenuDTO.class, Fasp2DaoCacheUtil.getTableColumn(CaGlobalVariable.MENU_TABCODE)));
            if (indexList !=null && indexList.size()>0){
                menuList.addAll(indexList);
            }
        }
        if ((!StringUtil.isEmpty(isSx)) && ("1".equals(isSx))) {  //山西模式，分区划查询角色下的菜单
            String sxindexsql = new StringBuilder().append("  select distinct t.* from fasp_t_pubmenu t where guid in (select menuguid from fasp_t_carolemenu where  roleguid in (select roleguid from fasp_t_causerrole where userguid = ?) and province = ? ) and appid = 'pmkpi' order by menuorder asc").toString();
            menuList = pmkpiPendingDAO.query(sxindexsql, new Object[] {user != null ? user.getGuid() : null, province },
                    pmkpiPendingDAO.getRowMapper(MenuDTO.class, Fasp2DaoCacheUtil.getTableColumn(CaGlobalVariable.MENU_TABCODE)));
        }
        List<String> urlList = new ArrayList<>();
        Map<String, Object> menuMap = new HashMap<>();
        for(MenuDTO submenu : menuList) {
            if (submenu.getUrl()!= null && !StringUtil.isEmpty(submenu.getUrl()) && !"#".equals(submenu.getUrl())){
                String menuUrl = submenu.getUrl();
                String key = "";
                int index = menuUrl.indexOf(".page");
                if (index != -1) {
                    key = menuUrl.substring(0, index);
                    urlList.add(key);
                    menuMap.put(key, submenu);
                }
            }
        }
        //处理待办配置信息
        TreeSet<String> treeSet = new TreeSet<>();
        List<Map<String, Object>> pendList = new ArrayList<>();//待办集合
        String cacheKey = pmkpiPendingDAO.PMKPI_CACHE_PENDINGTASK;
        for (String key : urlList) {
            String str = cacheKey + key;
            String cacheData = PerfUtil.getCacheJSONData(str);
            //缓存中是否存在待办信息
            if (!StringUtil.isEmpty(cacheData)) {
                pendList.addAll(PerfUtil.parseString2List(cacheData));
            } else {
                treeSet.add(key);
            }
        }
        //缓存中不存在，数据库查询，并且存放到缓存中
        if (treeSet.size() > 0) {
            String keys = StringUtils.join(treeSet, "','");
            //查询出所有待办事项
            List<Map<String, Object>> pendDatas = pmkpiPendingDAO.getPendingtask(keys);
            List<Map<String, Object>> cacheList = null;
            for (String key : treeSet) {
                cacheList = new ArrayList<>();
                String str = cacheKey + key;
                for (Map<String, Object> pendMap : pendDatas) {
                    if (key.equals(pendMap.get("key"))) {
                        cacheList.add(pendMap);
                    }
                }
                String data = PerfUtil.parse2Json(cacheList);
                PerfUtil.reflashCacheJSONData(str, data, false);
            }
            pendList.addAll(pendDatas);
        }
        if (pendList.size()>0){
            String usertype = CommonUtil.getCurrentUser().getUsertype() + "";
            String setval = CommonUtil.getCurrentUser().getAgency();
            if ("1".equals(usertype)) {
                setval = "1=1"; //处室
            } else if ("2".equals(usertype)){
                setval = CommonUtil.getCurrentUser().getUpagencyid();
            }
            // 2025/09/26 优化代码，修改掉循环内查询
            // 定义处理对象容器
            class PendingItem {
                Map<String, Object> originalMap;
                MenuDTO menu;
                Map<String, Object> paramsMap;
                String beanid;
                String mothod;
                Object methodResult; // 保存runFunction返回的对象
                int index;
                String name;
                String tabcode;
                String lefttabnum;
            }
            // 1：收集数据和执行方法调用
            List<PendingItem> pendingItems = new ArrayList<>();
            List<Object[]> dataMapParamsList = new ArrayList<>(); // [item, getcolValue]
            List<Object[]> dataCountParamsList = new ArrayList<>(); // [item]
            int index = 0;
            for (Map<String, Object> map : pendList) {
                MenuDTO menu = (MenuDTO) menuMap.get(map.get("key"));
                if (menu == null) continue;
                String param = (String) map.get("param");
                if (param == null || StringUtil.isEmpty(param) || "{}".equals(param)) continue;
                String beanid = (String) map.get("beanid");
                String mothod = (String) map.get("mothod");
                if (StringUtil.isEmpty(beanid) || StringUtil.isEmpty(mothod)) continue;
                // 解析参数并执行方法
                Map paramsMap = JSON.parseObject(param, Map.class);
                Object o = PerfServiceFactory.getBean(beanid);
                Object[] params = new Object[]{paramsMap};
                Object methodResult = this.runFunction(o, mothod, params); // 如果不是getVodSql则直接查库返回数据，正常应该没有
                // 创建处理项
                PendingItem item = new PendingItem();
                item.originalMap = map;
                item.menu = menu;
                item.paramsMap = paramsMap;
                item.beanid = beanid;
                item.mothod = mothod;
                item.methodResult = methodResult;
                item.index = index;
                item.name = (String) map.get("name");
                item.tabcode = (String) map.get("tabcode");
                item.lefttabnum = (String) map.get("lefttabnum");
                pendingItems.add(item);
                // 分类收集数据库查询需求
                if ("getVodSql".equals(mothod)) {
                    if (!StringUtil.isEmpty((String) paramsMap.get("queryview"))) {
                        dataMapParamsList.add(new Object[]{item, paramsMap.get("getcolValue")});
                    } else {
                        dataCountParamsList.add(new Object[]{item});
                    }
                }
                index++;
            }
            // 2：批量执行数据库操作
            // 执行设置参数
            if (!dataMapParamsList.isEmpty()) {
                pmkpiPendingDAO.execute("select perf_fundpay_view.set_agencyguid('" + setval + "') from dual");
            }
            // 批量执行getDataCount查询
            List<String> countsqlList = new ArrayList<>();
            List<String> countmarkindexList = new ArrayList<>();
            for (Object[] params : dataCountParamsList) {
                PendingItem item = (PendingItem) params[0];
                if (StringUtil.isEmpty((String) item.paramsMap.get("queryview"))) {
                    String markindex = String.valueOf(item.index);
                    String sql = item.methodResult + "";
                    countsqlList.add(sql);
                    countmarkindexList.add(markindex);
                }
            }
            Map<PendingItem, Integer> dataCountResults = new HashMap<>();
            if (!countsqlList.isEmpty()) {
                Map<String, Integer> batchDataCountResults = pmkpiPendingDAO.batchGetDataCount(countsqlList, countmarkindexList);
                for (Object[] params : dataCountParamsList) {
                    PendingItem item = (PendingItem) params[0];
                    String markindex = String.valueOf(item.index);
                    dataCountResults.put(item, batchDataCountResults.get(markindex));
                }
            }
            // 3：处理结果并构建DTO
            for (PendingItem item : pendingItems) {
                StringBuilder linkUrl = new StringBuilder();
                int dataNum = 0;
                String name = item.name;
                if ("getVodSql".equals(item.mothod)) {
                    if (!StringUtil.isEmpty((String) item.paramsMap.get("queryview"))) {
                        // 批量执行getDataMap查询 每个getvoldsql返回得sql查询列都不同无法批量查询 但只有配置存在queryview才会进入，一般情况走的是getDataCount
                        String sql = "(" + item.methodResult + ")";
                        Map<String, Object> resultMap = pmkpiPendingDAO.getDataMap(sql, null);
                        String getcolValue = (String) item.paramsMap.get("getcolValue");
                        String value = (String) resultMap.get(getcolValue);
                        if (name.contains("#" + getcolValue + "#") && !StringUtil.isEmpty(value)) {
                            name = name.replace("#" + getcolValue + "#", value);
                            dataNum = 1;
                        } else {
                            name = name.replace("#" + getcolValue + "#", "");
                            dataNum = 0;
                        }
                    } else {
                        dataNum = dataCountResults.get(item);
                    }
                } else {
                    // 处理非getVodSql分支：直接使用methodResult
                    List<Map<String, Object>> datas = new ArrayList<>();
                    Object obj = item.methodResult;
                    if (obj instanceof List) {
                        datas = (List<Map<String, Object>>) obj;
                    } else if (obj instanceof Map) {
                        Map<String, Object> dataMap = (Map<String, Object>) obj;
                        datas = (List<Map<String, Object>>) dataMap.get("data");
                    }
                    dataNum = datas.size();
                }
                // 拼接URL
                String url = (String) item.menu.get("url");
                linkUrl.append(url);
                if (url.indexOf("?") == -1) {
                    linkUrl.append("?");
                } else {
                    linkUrl.append("&");
                }
                linkUrl.append("mainmenu=").append(item.menu.getParentid())
                        .append("&submenu=").append(item.menu.getGuid())
                        .append("&appid=pmkpi&param1=").append(item.menu.getParam1())
                        .append("&param2=").append(item.menu.getParam2())
                        .append("&param3=").append(item.menu.getParam3())
                        .append("&param4=").append(item.menu.getParam4())
                        .append("&param5=").append(item.menu.getParam5())
                        .append("&menuId=").append(item.menu.getGuid());
                if(!StringUtil.isEmpty(item.tabcode)){
                    linkUrl.append("&waittabcode=").append(item.tabcode);
                }
                if(!StringUtil.isEmpty(item.lefttabnum)){
                    linkUrl.append("&lefttabnum=").append(item.lefttabnum);
                }
                // 构建DTO
                PendingTaskProtalDTO p = new PendingTaskProtalDTO();
                PendingTaskProtalDTO a = new PendingTaskProtalDTO();
                List childPendingTask = new ArrayList();
                p.setAppid("pmkpi");
                p.setLinkUrl(linkUrl.toString());
                p.setName(name);
                p.setCount(String.valueOf(dataNum));
                p.put("menuId", item.menu.getString("id"));
                childPendingTask.add(p);
                a.setChildPendingTask(childPendingTask);
                a.setMenuGuid(item.menu.getGuid());
                a.setOrderno(item.menu.getMenuorder());
                a.setName(name);
                if (dataNum > 0) {
                    allList.add(a);
                }
            }
        }
        return allList;
    }

}
