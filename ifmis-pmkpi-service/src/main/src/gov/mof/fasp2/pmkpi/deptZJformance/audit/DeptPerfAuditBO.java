package gov.mof.fasp2.pmkpi.deptZJformance.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.deptperformance.bo.DeptPerformanceBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
       StringBuffer sql = new StringBuffer("(select * from ");
       sql.append(tablecode).append(" t ");
       sql.append(" where t.province='").append(province).append("'");
       sql.append(" and t.year=").append(year);
       if (wheresql != null && !StringUtils.isEmpty(wheresql)){
           sql.append(" and ").append(wheresql);
       }
       if (tabfilter != null && !StringUtils.isEmpty(tabfilter)){
           sql.append(" and ").append(tabfilter);
       }
       if (tablesql != null && !StringUtils.isEmpty(tablesql)){
           sql.append(" and ").append(tablesql);
       }
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
        String sysvalue = deptPerfAuditDAO.getSystemDepttree();
        if (sysvalue == null || StringUtils.isEmpty(sysvalue)){
            //默认查询单位
            sysvalue="PMKPIAGENCYALLPAY";
        }
        leftconfig.put("datas", this.getLeftTreeData(menuId,sysvalue));
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
        boolean iscancelEnd = false;//流程前判断是否为取消终审
        for (Map<String, Object> data : datas){
            String wfstatus = (String) data.get("wfstatus");
            if("cancelaudit".equals(actioncode) && !StringUtil.isEmpty(wfstatus) && "011".equals(wfstatus)){
                iscancelEnd = true;
            }
        }
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        String istogether = PerfUtil.getSystemSet("DEPTGOALSINGLE"); //部门整体绩效申报是否与预算编制流程一起
        if (StringUtil.isEmpty(istogether) || "0".equals(istogether)){ //不在一起走流程，部门绩效单独处理
            List<Map<String, Object>> agencyList = new ArrayList<>();
            Map<String, Object> agencymap = null;
            boolean isEnd = false;//流程后判断是否为终审
            for (Map<String, Object> data : datas){
                String wfstatus = (String) data.get("wfstatus");
                if(("audit".equals(actioncode) || "auditbatch".equals(actioncode)) && !StringUtil.isEmpty(wfstatus) && "011".equals(wfstatus)){
                    isEnd = true;
                }
                agencymap = new HashMap<>();
                agencymap.put("guid", data.get("agencyguid"));
                agencyList.add(agencymap);
            }
            DeptPerformanceBO deptPerformanceBO = (DeptPerformanceBO) ServiceFactory.getBean("pmkpi.deptperformance.DeptPerformanceBOTX");
            if(isEnd){ //终审备份批复版本记录
                deptPerformanceBO.saveDeptPerfPfdata(agencyList,false);
            }
            if(iscancelEnd){ //取消终审删除批复版本记录
                deptPerformanceBO.delDeptPerfPfdata(agencyList,false);
            }
        }
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 修改预算终审数据工作流状态
     * @param params
     */
    public void updateWfStatus(HashMap<String, Object> params){

    }

}
