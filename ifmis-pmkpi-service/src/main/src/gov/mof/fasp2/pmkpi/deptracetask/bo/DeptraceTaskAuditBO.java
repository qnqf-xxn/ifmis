package gov.mof.fasp2.pmkpi.deptracetask.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.deptperformance.audit.PmkpiPerfAuditDAO;
import gov.mof.fasp2.pmkpi.deptracetask.dao.DeptraceTaskAuditDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptraceTaskAuditBO extends PmkpiBO {

    private DeptraceTaskAuditDAO deptraceTaskAuditDAO;

    public void setDeptraceTaskAuditDAO(DeptraceTaskAuditDAO deptraceTaskAuditDAO) {
        this.deptraceTaskAuditDAO = deptraceTaskAuditDAO;
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
        List<Map<String, Object>> data = deptraceTaskAuditDAO.getDatas(s.toString(), wheresql, null);
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
       if (!"1".equals(isleaf) && !"treeroot".equals(agency)) {
           // 数据权限
           String datarule = this.getDicDSDataListByWheresql("t", menuid, "PMKPIAGENCYALLPAY");
           if (!"treeroot".equals(agency)) {
               datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
           }
           IDataSetService dss = PerfServiceFactory.getIDataSetService();
           List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("AGENCY",datarule);
           deptraceTaskAuditDAO.saveAll(eledatas, deptraceTaskAuditDAO.PMKPI_TABLE_TMP_AGENCY);
       } else if ("treeroot".equals(agency)) {
    	   String sysvalue = deptraceTaskAuditDAO.getSystemDepttree();
           List<Map<String, Object>> treeData =  this.getLeftTree(menuid,sysvalue);
           deptraceTaskAuditDAO.saveAll(treeData, deptraceTaskAuditDAO.PMKPI_TABLE_TMP_AGENCY);
       }
       Integer year = SecureUtil.getUserSelectYear();
       String province = SecureUtil.getUserSelectProvince();
       StringBuffer sql = new StringBuffer("(select * from ");
       sql.append(tablecode).append(" t ");
       sql.append(" where t.province='").append(province).append("'");
       sql.append(" and t.year=").append(year);
       if (wheresql != null && !wheresql.isEmpty()){
           sql.append(" and ").append(wheresql);
       }
       if (tabfilter != null && !tabfilter.isEmpty()){
           sql.append(" and ").append(tabfilter);
       }
       if (tablesql != null && !tablesql.isEmpty()){
           sql.append(" and ").append(tablesql);
       }
       String wfsql = getWfSql(tabcode, workflow);
       if (wfsql != null && !wfsql.isEmpty()) {
           sql.append(" and ").append(wfsql);
       }
       if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
           sql.append(" and t.agencyguid='").append(agency).append("')");
       } else if ("0".equals(isleaf)) {
           sql.append(" and exists(select * from ").append(deptraceTaskAuditDAO.PMKPI_TABLE_TMP_AGENCY)
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
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.FALSE);
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        String sysvalue = deptraceTaskAuditDAO.getSystemDepttree();
        leftconfig.put("datas", this.getLeftTree(menuId,sysvalue));
        return leftconfig;
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        Map<String, Object> auditdata = (Map<String, Object>) params.get("auditdata");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = (String) params.get("tablecode");
        if (actioncode != null && ("back".equals(actioncode) || "cancelaudit".equals(actioncode))) {
            String mainguid = (String) datas.get(0).get("guid");
            String mainsql = "mainguid='" + mainguid + "'";
            deptraceTaskAuditDAO.delDatas(PmkpiPerfAuditDAO.AUDITMAIN_TABLE, mainsql);
            List<Map<String, Object>> sublist = deptraceTaskAuditDAO.getDatas(PmkpiPerfAuditDAO.AUDITMAIN_TABLE, mainsql, null);
            if (sublist != null && sublist.size() >0 ) {
                String guid = (String) sublist.get(0).get("guid");
                deptraceTaskAuditDAO.delDatas(PmkpiPerfAuditDAO.AUDITSUB_TABLE, "mainguid='" + guid + "'");
            }
        } else if (actioncode != null && "audit".equals(actioncode)) {
            String mainguid = (String) auditdata.get("mainguid");
            String agency = (String) auditdata.get("agency");
            Map<String, Object> maindata = (Map<String, Object>) auditdata.get("maindata");
            String guid = this.getCreateguid();
            maindata.put("mainguid", mainguid);
            maindata.put("nodeguid", mainguid);
            maindata.put("agencyguid", agency);
            maindata.put("createtime", StringUtil.getSysDBDate());
            maindata.put("updatetime", StringUtil.getSysDBDate());
            maindata.put("province", SecureUtil.getUserSelectProvince());
            maindata.put("year", CommonUtil.getYear());
            maindata.put("guid", guid);
            maindata.put("userguid", SecureUtil.getCurrentUserID());
            deptraceTaskAuditDAO.save(maindata, PmkpiPerfAuditDAO.AUDITMAIN_TABLE);
        }
        return this.workflow(actioncode, workflow, remark, tablecode, datas);
    }
}
