package gov.mof.fasp2.pmkpi.perfpromod.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProModAuditBO extends PmkpiBO {

    private ProModAuditDAO proModAuditDAO;

    public void setProModAuditDAO(ProModAuditDAO proModAuditDAO) {
        this.proModAuditDAO = proModAuditDAO;
    }

    /**
     *  列表的查询方法.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     * @param sqlmap
     * @return
     * @throws AppException
     * @see PmkpiBO#getVodSql(Map)
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf");
        String saveAgency = (String)sqlmap.get("saveAgency");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String workflow = (String) sqlmap.get("workflow");
        String tablesql = (String) sqlmap.get("tablesql");//查询条件
        String tabcode = (String) sqlmap.get("tabcode");
        String modtype = (String) sqlmap.get("modtype");
        String datarule = this.getDataRuleByMenuguid(menuid, "t", "1=1"); //数据权限
        StringBuffer returnsql = new StringBuffer("select t.* ");
        returnsql.append(" from ").append(tablecode).append(" t ");
        returnsql.append(" where ").append(datarule);
        returnsql.append(PerfUtil.yearProvinceSql("t"));
        if (wheresql != null && !wheresql.isEmpty()) {
            returnsql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            returnsql.append(" and ").append(wfsql);
        }
        if (modtype != null && !modtype.isEmpty()) {
            returnsql.append(" and t.modtype = '").append(modtype).append("' ");
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, proModAuditDAO.PMKPI_TABLE_T_AGENCY));
        return returnsql.toString();
    }

    
    /**
    *
    * @param sqlmap
    * @return
    * @throws AppException
    */
   public StringBuffer getAuditQuerySql(Map sqlmap) throws AppException {
       String wheresql = (String) sqlmap.get("querySql");
       String menuid = (String)sqlmap.get("menuid");
       String isleaf = (String)sqlmap.get("isleaf");
       String agency = (String)sqlmap.get("agency");
       String tablecode = (String)sqlmap.get("tablecode");
       String tabfilter = (String) sqlmap.get("tabfilter");
       String workflow = (String) sqlmap.get("workflow");
       String tablesql = (String) sqlmap.get("tablesql");//查询条件
       String orderby = (String) sqlmap.get("orderby");
       String tabcode = (String) sqlmap.get("tabcode");
       String datarule = " 1=1 ";
       datarule = this.getDataRuleByMenuguid("t", menuid, "PMKPIAGENCYALLPAY");
       if (isleaf != null && agency != null && !"1".equals(isleaf) && !"treeroot".equals(agency)) {
           // 数据权限
           if (!"treeroot".equals(agency)) {
               datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
           }
           IDataSetService dss = PerfServiceFactory.getIDataSetService();
           List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("AGENCY",datarule);
           proModAuditDAO.saveAll(eledatas, proModAuditDAO.PMKPI_TABLE_TMP_AGENCY);
       } else if (agency != null && "treeroot".equals(agency)) {
           String sysvalue = proModAuditDAO.getSystemDepttree();
           List<Map<String, Object>> treeData =  this.getLeftTree(menuid,sysvalue);
           proModAuditDAO.saveAll(treeData, proModAuditDAO.PMKPI_TABLE_TMP_AGENCY);
       }
       Integer year = SecureUtil.getUserSelectYear();
       String province = SecureUtil.getUserSelectProvince();
       StringBuffer sql = new StringBuffer("(select * from ");
       sql.append(tablecode).append(" t ");
       sql.append(" where t.province='").append(province).append("'");
       sql.append(" and t.year=").append(year);
       if (wheresql != null && !wheresql.isEmpty()) {
           sql.append(" and ").append(wheresql);
       }
       if (tabfilter != null && !tabfilter.isEmpty()) {
           sql.append(" and ").append(tabfilter);
       }
       if (tablesql != null && !tablesql.isEmpty()) {
           sql.append(" and ").append(tablesql);
       }
       String wfsql = getWfSql(tabcode, workflow);
       if (wfsql != null && !wfsql.isEmpty()) {
           sql.append(" and ").append(wfsql);
       }
       if (agency != null && isleaf != null && !"treeroot".equals(agency) && "1".equals(isleaf)) {
           sql.append(" and t.agencyguid='").append(agency).append("')");
       } else if (isleaf != null && "0".equals(isleaf)) {
           sql.append(" and exists(select * from ").append(proModAuditDAO.PMKPI_TABLE_TMP_AGENCY)
                   .append(" a where a.guid =t.agencyguid))");
       }
       if (orderby != null && !orderby.isEmpty()){
           sql.append(" ").append(orderby);
       }
       return sql;
   }


    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId, String prolev, String modtype) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        if (prolev == null || prolev.isEmpty()) {
            throw new AppException("请在菜单配置是几级项目申报！");
        }
        String sysvalue = PerfUtil.getSystemSet("tlprogram_lefttree_" + prolev);
        if (StringUtil.isEmpty(sysvalue)){
            sysvalue  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        }
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        String elementcode = sysvalue;
        String sql = " 1=1 ";
        sql = this.getDataRuleByMenuguid(menuId, "t", "1=1");
        sql = sql.replace("agencyguid","guid");
        String yearflagsql = "";
        if (modtype != null && !modtype.isEmpty()) {
            yearflagsql = " and a.modtype = '"+modtype+"'";
        }
        sql = " exists (select 1 from (select * from V_PERF_T_PROVISIONDECLARE a where 1=1 "
                +yearflagsql + " ) n where t.guid = n.agencyguid )";
        List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode, sql);
        List<Map<String, Object>> treesourcedata = new ArrayList<Map<String, Object>>();
        Object isleaf = 0;
        for (Map<String, Object> map : eledatas) {
            isleaf = map.get("isleaf");
            if (((Number) isleaf).intValue() == 1) {
                treesourcedata.add(map);
            }
        }
        if (elementcode != null && "PMKPIAGENCYALLPAY".equals(elementcode)) {
            proModAuditDAO.saveAll(eledatas, proModAuditDAO.PMKPI_TABLE_TMP_AGENCY);
        } else {
            proModAuditDAO.saveAll(treesourcedata, proModAuditDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        leftconfig.put("datas", proModAuditDAO.getLeftTree());
        return leftconfig;
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        String wfstatus = (String) datas.get(0).get("wfstatus");
        if (wfstatus != null && "011".equals(wfstatus)) {
            String guid = (String) datas.get(0).get("guid");
            String proguid = (String) datas.get(0).get("proguid");
            String modtype = (String) datas.get(0).get("modtype");
            String wheresql = "";
            if (modtype != null && "total".equals(modtype)) {
                wheresql = " t.yearflag = 1 ";
            }else {
                wheresql = " t.yearflag = 0 ";
            }
            wheresql += " and t.mainguid = '"+proguid+"'";
            //修改项目指标状态
            proModAuditDAO.updateIsDeleteDatas("v_pm_perf_indicator", wheresql);
            //修改项目目标状态
            proModAuditDAO.updateIsDeleteDatas("v_pm_perf_goal_info", wheresql);
            wheresql = " t.mainguid = '"+guid+"' ";
            //指标保存
            List<Map<String, Object>> indexList = proModAuditDAO.getDatas("V_PERF_PROVISION_INDICATOR" ,wheresql, null);
            for (Map map: indexList) {
                String newguid = this.getCreateguid();
                map.put("guid", newguid);
                map.put("kpi_id", newguid);
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("update_time", PerfUtil.getServerTimeStamp());
                map.put("mainguid", proguid);
                map.put("is_deleted", "2");
            }
            proModAuditDAO.saveAll(indexList, "v_pm_perf_indicator");
            //目标保存
            Map<String, Object> goalMap = proModAuditDAO.getDataMap("V_PERF_PROVISION_GOAL_INFO", wheresql);
            String newguid = this.getCreateguid();
            goalMap.put("guid", newguid);
            goalMap.put("kpi_per_id", newguid);
            goalMap.put("updatetime", PerfUtil.getServerTimeStamp());
            goalMap.put("update_time", PerfUtil.getServerTimeStamp());
            goalMap.put("mainguid", proguid);
            goalMap.put("is_deleted", "2");
            proModAuditDAO.save(goalMap, "v_pm_perf_goal_info");
        }
        return this.auditdefine(datas, busguid, actioncode, null);
    }

}
