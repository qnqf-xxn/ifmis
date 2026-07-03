/**
 * @Title: PrjIndexBO.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-8-10  GM
 */


package gov.mof.fasp2.pmkpi.perfset.datarule;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



/**
 * @ClassName: PrjIndexBO
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@szlongtu.com">GM</a>于 2022-1-19 上午10:41:23
 */

public class PerfDataRuleBO extends PmkpiBO {
    /**
     * perfDataRuleDAO.
     */
    private PerfDataRuleDAO perfDataRuleDAO;
    /**
     * 注入dao.
     * @param perfDataRuleDAO --perfDataRuleDAO.
     * @throws
     */
    @Resource(name="pmkpi.perfset.PerfDataRuleDAO")
    public void setPerfDataRuleDAO(PerfDataRuleDAO perfDataRuleDAO) {
        this.perfDataRuleDAO = perfDataRuleDAO;
    }
    
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        // TODO Auto-generated method stub
        return null;
    }
    
    public List<Map<String, String>> findAllDatarule() {
        return perfDataRuleDAO.findAllDatarule();
    }
    
    public List<Map<String, String>> getMenuByRoleId(String roleid) {
        return perfDataRuleDAO.getMenuByRoleId(roleid);
    }
    
    public List<Map<String, String>> getMenuByRoleId(String roleid, String menuid) {
        return perfDataRuleDAO.getMenuByRoleId(roleid, menuid);
    }
    /**
     * <p>查询角色下所有已经配置数据权限的菜单</p >
     *
     * @author hw
     * @date 2022/6/7 11:19
     * @param
     */
    public List<Map<String, String>> getAllMenuByRoleId(String roleid) {
        return perfDataRuleDAO.getMenuByRoleId(roleid);
    }
    public boolean saveMenuAndDRData(String roleGuid, ArrayList dataRightList, String menuid) throws AppException {
        List ralationList = new ArrayList();
        Map dm = new HashMap();
        Map m = null;
        for (int j = 0; j < dataRightList.size(); j++) {
            dm = (Map) dataRightList.get(j);
            m = new HashMap();
            m.put("guid", StringUtil.createUUID());
            m.put("roleguid", roleGuid);
            m.put("userguid", CommonUtil.getCurrentUserID());
            m.put("menuid", menuid);
            m.put("dataruleguid", dm.get("guid"));
            m.put("menuguid", menuid);
            m.put("createtime", CommonUtil.getTimeStamp());
            m.put("updatetime", CommonUtil.getTimeStamp());
            m.put("status", 1);
            m.put("appid", "pmkpi");
            m.put("year", CommonUtil.getYear());
            m.put("province", CommonUtil.getProvince());
            ralationList.add(m);
        }
        perfDataRuleDAO.delDataRule(roleGuid, menuid);
        perfDataRuleDAO.saveAll(ralationList, "pmkpi_t_Roledatarule");
        return true;
    }
    //支持选择多菜单
    public boolean saveMenuAndDRDataByList(String roleGuid, ArrayList dataRightList, ArrayList menusList) throws AppException {
        List ralationList = new ArrayList();
        Map map = new HashMap();//用来获取多菜单
        Map dm = new HashMap();//用来获取多权限
        Map m = null;
        String menuid = "";
        for (int i=0;i<menusList.size();i++){
            map = (Map) menusList.get(i);
            menuid = (String)map.get("guid");
            for (int j = 0; j < dataRightList.size(); j++) {
                dm = (Map) dataRightList.get(j);
                m = new HashMap();
                m.put("guid", StringUtil.createUUID());
                m.put("roleguid", roleGuid);
                m.put("userguid", CommonUtil.getCurrentUserID());
                m.put("menuid", menuid);
                m.put("dataruleguid", dm.get("guid"));
                m.put("menuguid", menuid);
                m.put("createtime", CommonUtil.getTimeStamp());
                m.put("updatetime", CommonUtil.getTimeStamp());
                m.put("status", 1);
                m.put("appid", "pmkpi");
                m.put("year", CommonUtil.getYear());
                m.put("province", CommonUtil.getProvince());
                ralationList.add(m);
            }
        }
        logger.debug("获取的菜单大小"+menusList.size());
        perfDataRuleDAO.saveAll(menusList,perfDataRuleDAO.PMKPI_TABLE_TMP_AGENCY);
        perfDataRuleDAO.delDataRuleByTable(roleGuid,perfDataRuleDAO.PMKPI_TABLE_TMP_AGENCY);
        perfDataRuleDAO.saveAll(ralationList, "pmkpi_t_Roledatarule");
        return true;
    }


    public String getDataRuleByMenuguid(String menuguid, String tablealias) throws AppException {
        String reSql = "1=1";
        if (CommonUtil.getCurrentUser() == null) {
            return reSql;
        }
        List rolelist = perfDataRuleDAO.getUserRoleList(CommonUtil.getCurrentUserID());
        if (rolelist != null && !rolelist.isEmpty()) {
            reSql = perfDataRuleDAO.queryWhereSql(rolelist, menuguid, tablealias);
        }
        return reSql;
    }

    /**
     * 数据权限改造.
     * @param menuguid -- 菜单，别名
     * @param tablealias
     * @return
     * @throws AppException
     */
    public String getDataRuleByMenuguid1(String menuguid, String tablealias) throws AppException {
        String reSql = "1=1";
        if (CommonUtil.getCurrentUser() == null) {
            return reSql;
        }
        String rtablealias = "";
        if (!StringUtil.isEmpty(tablealias)){
            rtablealias = tablealias + ".";
        }
        //2025-06-16 增加逻辑 判断是否存在交接用户 返回交接用户id列表
        Map<String, Object> handoverCurrentUserRoles = perfDataRuleDAO.getHandoverCurrentUserRoles();
        List<String> userlist = (List<String>) handoverCurrentUserRoles.get("userlist");
        List<String> rolelist = (List<String>) handoverCurrentUserRoles.get("rolelist");
        String users = (String) handoverCurrentUserRoles.get("users");
        if (rolelist != null && !rolelist.isEmpty()) {
            StringBuffer temproles = new StringBuffer("'");
            for(String a :rolelist){
                temproles.append(a).append("','");
            };
            String roles = temproles.substring(0,temproles.length()-2);
            String userguid = CommonUtil.getCurrentUserID(); //用户guid
            String province = CommonUtil.getProvince(); //省份
            String usertype = CommonUtil.getCurrentUser().getUsertype() + "";
            String curragency = CommonUtil.getCurrentUser().getAgency();
            String curbusoffice = "";
            if (!StringUtil.isEmpty(usertype) && "1".equals(usertype)) {
                curbusoffice = CommonUtil.getCurrentUser().getDivision(); //处室
            } else {
                curbusoffice = curragency;
            }
            String datarulsql = "select distinct t1.wheresql,t.roleguid from pmkpi_t_roledatarule t, " +
                    " pmkpi_t_datarule t1 where t1.guid = t.dataruleguid and t.roleguid in (" + roles + ") and t.menuguid = ?" +
                    " and t.year= ? and t.province= ? order by t.roleguid ";
            List<Map> rulelist = perfDataRuleDAO.queryForList(datarulsql, new String[] {menuguid,CommonUtil.getYear(),province});
            if (rulelist == null || rulelist.size() == 0) {
                return reSql;
            }
            StringBuffer wheresqlrole = new StringBuffer();
            StringBuffer rulesql = new StringBuffer();
            String tempwheresql = null;
            String temproleugid = null;
            String oldroleguid = null;
            for (Map tempMap : rulelist) {
                tempwheresql = (String) tempMap.get("WHERESQL");
                temproleugid = (String) tempMap.get("ROLEGUID");
                if (StringUtil.isEmpty(oldroleguid)){
                    /*每个角色首次*/
                    wheresqlrole = new StringBuffer();
                    wheresqlrole.append("(").append(tempwheresql).append(")");
                } else if (oldroleguid.equals(temproleugid)){
                    /*角色未切换*/
                    wheresqlrole.append(" and (").append(tempwheresql).append(")");
                } else if (!oldroleguid.equals(temproleugid)){
                    /*角色切换*/
                    if (rulesql.length() == 0){
                        rulesql.append("(").append(wheresqlrole).append(")");
                    } else {
                        rulesql.append(" or (").append(wheresqlrole).append(")");
                    }
                    wheresqlrole = new StringBuffer();
                    wheresqlrole.append("(").append(tempwheresql).append(")");
                }
                oldroleguid = temproleugid;
            }
            if (!StringUtil.isEmpty(oldroleguid)){ /*最后一次循环的角色*/
                if (rulesql.length() == 0){
                    rulesql.append("(").append(wheresqlrole).append(")");
                } else {
                    rulesql.append(" or (").append(wheresqlrole).append(")");
                }
            }
            reSql = rulesql.toString().replace("ruletable.", rtablealias);
            if (!StringUtil.isEmpty(userguid) && reSql.indexOf("#curruser#") !=-1) { /**替换#curruser# **/
                reSql = reSql.replace("#curruser#", userguid);
            }
            if (userlist != null && !userlist.isEmpty() && reSql.indexOf("#currusers#") !=-1) { /**替换#currusers# in多个用户id**/
                reSql = reSql.replace("#currusers#", users);
            }
            if (!StringUtil.isEmpty(curbusoffice) && reSql.indexOf("#busoffice#") !=-1) { /**用户类型为财政,查询处室用户**/
                reSql = reSql.replace("#busoffice#", curbusoffice);
            }
            if (!StringUtil.isEmpty(province) && reSql.indexOf("#province#") !=-1) { /**替换区划**/
                reSql = reSql.replace("#province#", province);
            }
            if (reSql.indexOf("#curragency#") !=-1) { /**替换单位**/
                if (!StringUtil.isEmpty(curragency)) {
                    reSql = reSql.replace("#curragency#", curragency);
                } else if (!StringUtil.isEmpty(curbusoffice)) {
                    reSql = reSql.replace("#curragency#", curbusoffice);
                }
            }
            if (!StringUtil.isEmpty(reSql)){
               reSql ="(" + reSql + ")";
            }
        }
        return reSql;
    }

}
