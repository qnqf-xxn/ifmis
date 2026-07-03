/**
 * @Title: PrjIndexService.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfset.datarule;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.menu.MenuDTO;
import gov.mof.fasp2.buscore.ca.role.service.IRoleService;
import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: PrjIndexService
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@bjinfor.cn">GM</a>于 2020-1-6 上午10:41:56
 */
@PageComponent(serviceid = "pmkpiPerfDataRuleService", 
        viewid = "pmkpiPerfDataRuleService",
        jsLib = "/pmkpi/setting/datarule/allotservice.js",
        jsObjectName = "Ext.lt.drtemplate.AllotIndex")
public class PerfDataRuleService extends PmkpiService {
    /**
     * perfDataRuleBO.
     */
    private PerfDataRuleBO perfDataRuleBO;
    /**
     * 注入bo.
     * @param perfDataRuleBO
     * @throws
     */
    @Resource(name="pmkpi.perfset.PerfDataRuleBOTX")
    public void setPerfDataRuleBO(PerfDataRuleBO perfDataRuleBO) {
        this.perfDataRuleBO = perfDataRuleBO;
    }

    /**
     * Description: 传递名称，实现页面动态标题
     * </p>
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String acctsystype = CommonUtil.getPayAcctsystypeID(); //账套
        config.put("app", "pmkpi"); //系统标识
        config.put("acctsystype", acctsystype);
        return config;
    }

    /**
     * 获取菜单树
     * @param roleguid 角色id，appid 产品标识，acctsystype 账套
     * @return
     * @throws AppException
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    private Map getTreeConfig(String roleguid, String appid, String acctsystype) throws AppException {
        Map leftconfig = new HashMap();
        // 所选角色下的菜单
        IRoleService roleService = (IRoleService) ServiceFactory.getBean("buscore.ca.role.service");
        List<MenuDTO> list = roleService.getMenus(roleguid, appid);
        String whereSql = " t.appid='pmkpi' and guid like'%hide' ";
        List hidelist = perfDataRuleBO.getDatas("fasp_t_pubmenu", whereSql, "order by code");
        whereSql = " t.guid in('838B1FDBFEE7E614316B0A2631CF8444','7E3A321D993C6C19C897A5B5BD066533','838B1FDBFEE7E614316B0A2631CF8555','7E3A321D993C6C19C897A5B5BD066544','5F6C70A022B8E351D7229BD704702922','PIeJsFiT','bim000001jx') ";
        List bimlist = perfDataRuleBO.getDatas("fasp_t_pubmenu", whereSql, "order by code");
        List l = new ArrayList();
        for (int j=0;j<hidelist.size();j++) {
            Map m = (Map) hidelist.get(j);
            String superid = (String) m.get("parentid");
            for (MenuDTO mm : list) {
                String guid = (String) mm.get("guid");
                if (superid.equals(guid)) {
                    l.add(m);
                    break;
                }
            }
        }
        list.addAll(l);
        list.addAll(bimlist);
        leftconfig.put("datas", list);
        return leftconfig;
    }

    /**
     * 获取角色树
     * @param roletype 角色类型
     * @return
     * @throws AppException
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List getRoleTree(String roletype) throws AppException {
        List rtlist = new ArrayList();
        IRoleService roleService = (IRoleService) ServiceFactory.getBean("buscore.ca.role.service");
        StringBuffer whereSql = new StringBuffer(200);
        whereSql.append(" roletype='");
        whereSql.append(roletype);
        if("edb".equals(DbTypeUtil.getCurrentDBType()) && "polardb".equalsIgnoreCase(DbTypeUtil.getPhysicsDbType())){
            whereSql.append("' and (province = global_multyear_cz.v_pmdivid or province is null) ");
        } else {
            whereSql.append("' and (province = global_multyear_cz.Secu_f_GLOBAL_PARM('DIVID') or province is null) ");
        }
        //whereSql.append("' and (province = global_multyear_cz.Secu_f_GLOBAL_PARM('DIVID') ");
        //whereSql.append(" or province = (select b.code from fasp_t_pubadmdiv b where b.guid=(select a.superguid from fasp_t_pubadmdiv a where a.code = global_multyear_cz.Secu_f_GLOBAL_PARM('DIVID')))) ");
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

    /**
     * 根据产品标识和账套查询数据权限信息和系统菜单
     * @param hm
     * @return
     * @throws AppException
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map findDataRightByAppid(HashMap hm) throws AppException {
        Map result = new HashMap();
        String appid = (String) hm.get("appid");
        String roleid = (String) hm.get("roleid");
        String acctsytype = (String) hm.get("acctsystype");
        // 1.查询本区划和公共的数据权限
        List<Map<String, String>> dataRights = perfDataRuleBO.findAllDatarule();
        result.put("datatables", dataRights);
        // 2.查询产品id和账套查询菜单信息
        Map leftconfig = getTreeConfig(roleid, appid, acctsytype);
        result.put("leftconfig", leftconfig);
        // 3.查询已经有数据权限的菜单
        List midTables = perfDataRuleBO.getAllMenuByRoleId(roleid);
//        logger.info("---midTables----: " + midTables);
        result.put("midTables", midTables);
        return result;
    }
    /**
     * 根据角色和菜单查询已经选中的数据权限.
     * @param roleid -- 角色
     * @param menuguid -- 菜单
     * @return
     * @throws AppException -- 自定义异常
     * @throws
     */
    @SuppressWarnings("rawtypes")
    public List getDatarightrp(String roleid, String menuguid) throws AppException {
        return perfDataRuleBO.getMenuByRoleId(roleid, menuguid);
    }

    /**
     * @Description:保存菜单和权限的对应关系
     * @param roleGuid
     * @param dataRightList --权限
     * @param menuid -- 菜单
     * @return boolean
     * @throws AppException
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public boolean saveMenuAndDRData(String roleGuid, ArrayList dataRightList, String menuid) 
            throws AppException {
        return perfDataRuleBO.saveMenuAndDRData(roleGuid, dataRightList, menuid);
    }
    //多菜单多权限保存。
    public boolean saveMenuAndDRData(String roleGuid, ArrayList dataRightList, ArrayList menuid)
            throws AppException {
        return perfDataRuleBO.saveMenuAndDRDataByList(roleGuid, dataRightList, menuid);
    }
    
    /**
     * 获取用户菜单权限.
     * @param menuguid -- 菜单.
     * @param tablealias -- 别名
     * @return
     * @throws AppException -- 自定义异常.
     * @throws
     */
    public String getDataRuleByMenuguid(String menuguid, String tablealias) throws AppException {
        return perfDataRuleBO.getDataRuleByMenuguid1(menuguid, tablealias);
    }
}
