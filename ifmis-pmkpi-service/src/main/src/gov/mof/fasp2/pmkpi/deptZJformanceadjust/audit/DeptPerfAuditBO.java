package gov.mof.fasp2.pmkpi.deptZJformanceadjust.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;

public class DeptPerfAuditBO extends PmkpiBO {

    private DeptPerfAuditDAO deptPerfAuditDAO;

    public void setDeptPerfAuditDAO(DeptPerfAuditDAO deptPerfAuditDAO) {
        this.deptPerfAuditDAO = deptPerfAuditDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        return super.getVodSql(sqlmap);
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        String pagetype = (String) params.get("pagetype");
        StringBuffer s = new StringBuffer();
        String wheresql = "";
        if (pagetype != null && pagetype.equals("audit")){
            s = this.getAuditQuerySql(params);
        }
        List<Map<String, Object>> data = deptPerfAuditDAO.getDatas(s.toString(), wheresql, null);
        backMap.put("data", data);
        return backMap;
    }

    
    /**
    *
    * @param sqlmap
    * @return
    * @throws AppException
    */
   public StringBuffer getAuditQuerySql(Map sqlmap) throws AppException {
//       List queryConfig = (List) sqlmap.get("queryConfig");
//       Map<String ,String> queryParam = (Map<String, String>) queryConfig.get(0);
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
       if("edb".equals(DbTypeUtil.getCurrentDBType())){
           createTmpTable(deptPerfAuditDAO.PMKPI_TABLE_TMP_AGENCY);
       }
       if (!"1".equals(isleaf) && !"treeroot".equals(agency)) {
           // 数据权限
           String datarule = this.getDicDSDataListByWheresql("t", menuid, "PMKPIAGENCYALLPAY");
           //String sql = "";
           if (!"treeroot".equals(agency)) {
               datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
           }
           IDataSetService dss = PerfServiceFactory.getIDataSetService();
           List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("AGENCY",datarule);
           deptPerfAuditDAO.saveAll(eledatas, deptPerfAuditDAO.PMKPI_TABLE_TMP_AGENCY);
       } else if ("treeroot".equals(agency)) {
           String sysvalue = deptPerfAuditDAO.getSystemDepttree();
           if (sysvalue == null || StringUtils.isEmpty(sysvalue)){
           	//默认查询单位
           	sysvalue="PMKPIAGENCYALLPAY";
           }
           List<Map<String, Object>> treeData =  this.getLeftTreeData(menuid,sysvalue);
           deptPerfAuditDAO.saveAll(treeData, deptPerfAuditDAO.PMKPI_TABLE_TMP_AGENCY);
       }
       Integer year = SecureUtil.getUserSelectYear();
       String province = SecureUtil.getUserSelectProvince();
       String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
       StringBuffer sql = new StringBuffer("(select * from ");
       //sql.append(tablecode).append(" t ");
       sql.append("V_PERF_T_ADJUST").append(" t");
       sql.append(" where t.bustype='dept' ");
       /*sql.append(" where t.province='").append(province).append("'");
       sql.append(" and t.year=").append(year);*/
       if (wheresql != null && !StringUtils.isEmpty(wheresql)){
           sql.append(" and ").append(wheresql);
       }
       if (tabfilter != null && !StringUtils.isEmpty(tabfilter)){
           sql.append(" and ").append(tabfilter);
       }
       if (tablesql != null && !StringUtils.isEmpty(tablesql)){
           sql.append(" and ").append(tablesql);
       }
       sql.append(datarule);
       String wfsql = getWfSql(tabcode, workflow);
       if (wfsql != null && !StringUtils.isEmpty(wfsql)) {
           sql.append(" and (").append(wfsql).append(")");
       }
       if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
           sql.append(" and t.agencyguid='").append(agency).append("')");
       } else if ("0".equals(isleaf)) {
           sql.append(" and exists(select * from ").append(deptPerfAuditDAO.PMKPI_TABLE_TMP_AGENCY)
                   .append(" a where a.guid =t.agencyguid))");
       }
       if (orderby != null && !StringUtils.isEmpty(orderby)){
           sql.append(" ").append(orderby);
       }
       return sql;
   }

    /**
     * 获取左侧树显示数据.
     *
     * @param menuId
     *            -- 菜单.
     * @throws AppException
     *             -- 自定义异常
     * @rturn --
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getLeftTreeData(String menuId,String sysvalue)
            throws AppException {
        String sql = this.getDicDSDataListByWheresql("t", menuId, sysvalue);
        //根据权限查询
        List<Map<String, Object>> list = deptPerfAuditDAO.getTreeList(sql,sysvalue);
        List<Map<String, Object>> treesourcedata = new ArrayList<Map<String, Object>>();
        Object isleaf = 0;
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(deptPerfAuditDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        for (Map<String, Object> map : list) {
            isleaf = map.get("isleaf");
            if (1 == ((Number) isleaf).intValue()) {
                treesourcedata.add(map);
            }
        }
        if("PMKPIDEPT".equals(sysvalue)){
            deptPerfAuditDAO.saveAll(list, deptPerfAuditDAO.PMKPI_TABLE_TMP_AGENCY);
        } else {
            deptPerfAuditDAO.saveAll(treesourcedata, deptPerfAuditDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        return deptPerfAuditDAO.getLeftTree();
    }

    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String tablecode = "v_perf_t_adjust";
        String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype='dept' ";
        leftconfig.put("datas", deptPerfAuditDAO.getLeftTree(tablecode, datarule));
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
        String mainguid = (String) datas.get(0).get("guid");
        String proguid = (String) datas.get(0).get("proguid"); //项目guid
        String wheresql = "";
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        if ("audit".equals(actioncode)) {
            String wfstatus = (String) datas.get(0).get("wfstatus");
            if (wfstatus != null && "011".equals(wfstatus)) {
                String date = PerfUtil.getServerTimeStamp();
                wheresql = " mainguid='" + mainguid + "'";
                List<Map<String, Object>> goaldata = deptPerfAuditDAO.getDatas("V_PERF_T_ADJUSTGOAL", wheresql, "order by ordernum");
                List<Map<String, Object>> indexdata = deptPerfAuditDAO.getDatas("V_PERF_T_DEPTINDEXADJUST", wheresql, "order by ordernum");
                List<Map<String, Object>> budgetdata = deptPerfAuditDAO.getDatas("V_PERF_BGT_LINKBGTINFOADJUST", wheresql, "order by ordernum");
                List<Map<String, Object>> indexprodata = deptPerfAuditDAO.getDatas("V_PERF_BGT_INDEXPROADJUST", wheresql, "order by ordernum");
                Map<String, Object> indexMap = new HashMap<String, Object>();
                if(goaldata.size() > 0){
                    String adjustndgoal = (String) goaldata.get(0).get("adjustndgoal");
                    deptPerfAuditDAO.update("update V_BGT_PERF_GOAL_INFO set kpi_target = '"+adjustndgoal+"',updatetime = '"+date+"',is_last_inst=1 where mainguid = '"+proguid+"'");
                }
                if(indexdata.size() > 0){
                    for (Map<String, Object> map : indexdata) {
                        String uuid = StringUtil.createUUID();
                        indexMap.put((String) map.get("guid"),uuid);
                        map.put("guid", uuid);
                        map.put("createtime", date);
                        map.put("updatetime", date);
                        map.put("create_time", date);
                        map.put("update_time", date);
                        map.put("mainguid", proguid);
                        map.put("is_last_inst", 1);
                        map.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
                        map.put("lv1_perf_ind_code",map.get("lv1_perf_ind_code"));
                        map.put("lv2_perf_ind_code",map.get("lv2_perf_ind_code"));
                        map.put("lv3_perf_ind_code",map.get("lv3_perf_ind_code")); 
                        this.getBasMap(map, "add");
                    }
                    deptPerfAuditDAO.updateIsDeleteDatas("V_BGT_PERF_INDICATOR", " mainguid = '"+proguid+"'");
                    deptPerfAuditDAO.saveAll(indexdata, "V_BGT_PERF_INDICATOR");
                }
                if(budgetdata.size() > 0){
                    for (Map<String, Object> map : budgetdata) {
                        Set<String> keySet = indexMap.keySet();//替换新的指标ID对应关系
                        for (String key : keySet) {
                            if(map.get("indexguid").equals(key)){
                                map.put("indexguid",indexMap.get(key));
                            }
                        }
                        map.put("guid", StringUtil.createUUID());
                        map.put("createtime", date);
                        map.put("updatetime", date);
                        map.put("mainguid", proguid);
                    }
                    deptPerfAuditDAO.updateIsDeleteDatas("V_PERF_BGT_LINKBGTINFO", " mainguid = '"+proguid+"'");
                    deptPerfAuditDAO.saveAll(budgetdata, "V_PERF_BGT_LINKBGTINFO");
                }
                if(indexprodata.size() > 0){
                    for (Map<String, Object> map : indexprodata) {
                        Set<String> keySet = indexMap.keySet();//替换新的指标ID对应关系
                        for (String key : keySet) {
                            if(map.get("indexguid").equals(key)){
                                map.put("indexguid",indexMap.get(key));
                            }
                        }
                        map.put("guid", StringUtil.createUUID());
                        map.put("createtime", date);
                        map.put("updatetime", date);
                        map.put("mainguid", proguid);
                    }
                    deptPerfAuditDAO.updateIsDeleteDatas("V_PERF_BGT_INDEXPRO", " mainguid = '"+proguid+"'");
                    deptPerfAuditDAO.saveAll(indexprodata, "V_PERF_BGT_INDEXPRO");
                }
            }
        }else{
            if ("cancelaudit".equals(actioncode)) {//取消审核，申报数据是否终审改为不必填
                List<String> guids = new ArrayList<>();
                for (Map<String, Object> data : datas){
                    String wfstatus = (String) data.get("wfstatus");
                    if("011".equals(wfstatus)){
                        guids.add((String) data.get("proguid"));
                    }
                }
                if (guids.size() > 0) {
                    String upsql = " is_last_inst = 2 ";
                    wheresql = " is_last_inst = 1 ";
                    if (guids.size() > 0) {//更新规范表数据为终审
                        deptPerfAuditDAO.updateAllByColumn("mainguid", guids, "V_BGT_PERF_GOAL_INFO", upsql, wheresql);
                        deptPerfAuditDAO.updateAllByColumn("mainguid", guids, "V_BGT_PERF_INDICATOR", upsql, wheresql);
                    }
                }
            }
        }
        return this.auditdefine(datas, busguid, actioncode, null);
    }

}
