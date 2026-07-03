package gov.mof.fasp2.pmkpi.doubleprocess.jxaudit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TlpJxAuditBO extends PmkpiBO {
    
    private TlpJxAuditDAO tlpJxAuditDAO;

    public void setTlpJxAuditDAO(TlpJxAuditDAO tlpJxAuditDAO) {
        this.tlpJxAuditDAO = tlpJxAuditDAO;
    }

    /**
    *
    * @param sqlmap
    * @return
    * @throws AppException
    */
   @Override
   public String getVodSql(Map sqlmap) throws AppException {
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
       String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
       Integer year = SecureUtil.getUserSelectYear();
       String province = SecureUtil.getUserSelectProvince();
       StringBuffer sql = new StringBuffer("select * from ");
       sql.append(tablecode).append(" t ");
       sql.append(" where t.province='").append(province).append("'");
       sql.append(" and t.year=").append(year);
       String columncode = "agencyguid";
       sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, tlpJxAuditDAO.PMKPI_TABLE_T_AGENCY));
       sql.append(datarule);
       if (!StringUtils.isEmpty(wheresql)){
           sql.append(" and (").append(wheresql).append(")");
       }
       if (!StringUtils.isEmpty(tabfilter)){
           sql.append(" and ").append(tabfilter);
       }
       if (!StringUtils.isEmpty(tablesql)){
           sql.append(" and ").append(tablesql);
       }
       String wfsql = getWfSql(tabcode, workflow);
       if (!StringUtils.isEmpty(wfsql)) {
           sql.append(" and ").append(wfsql);
       }
       if (!StringUtils.isEmpty(orderby)){
           sql.append(" ").append(orderby);
       }
       return sql.toString();
   }


    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId, String prolev) throws AppException {
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("menuid",menuId);
        leftconfig.put("datas", this.getTreeData(map));
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
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    public List<Map<String,Object>> getProInfo(HashMap<String, Object> params) {
        String proguid = String.valueOf(params.get("proguid"));
        StringBuffer sql = new StringBuffer();
        sql.append("select * from v_perf_project_info where pro_id = '"+proguid +"'");
        List<Map<String,Object>> list = tlpJxAuditDAO.queryForList(sql.toString());
        return list;
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String leftmenuid = (String) params.get("menuid");
        String tablecode = "V_PERF_PROJECT_REVIEW";
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        return tlpJxAuditDAO.getLeftTree(tablecode, datarule);
    }
}
