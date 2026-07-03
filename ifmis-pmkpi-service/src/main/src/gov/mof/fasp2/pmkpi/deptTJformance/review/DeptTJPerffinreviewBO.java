package gov.mof.fasp2.pmkpi.deptTJformance.review;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.deptTJformance.audit.DeptTJPerfAuditDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptTJPerffinreviewBO extends PmkpiBO {

    private DeptTJPerfAuditDAO deptTJPerfAuditDAO;

    public void setDeptTJPerfAuditDAO(DeptTJPerfAuditDAO deptTJPerfAuditDAO) {
        this.deptTJPerfAuditDAO = deptTJPerfAuditDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        return this.getQuerySql(sqlmap).toString();
    }

    /**
    *
    * @param sqlmap
    * @return
    * @throws AppException
    */
   public StringBuffer getQuerySql(Map sqlmap) throws AppException {
       String menuid = (String)sqlmap.get("menuid");
       String tabfilter = (String) sqlmap.get("tabfilter");
       String tablesql = (String) sqlmap.get("tablesql");
       String tabcode = (String) sqlmap.get("tabcode");
       String wheresql = (String) sqlmap.get("querySql");
       String datarule = this.getDataRuleByMenuguid(menuid, "t", null); //数据权限
       String dsql = datarule.replace("t.finintorgguid","t.finitorg");
       StringBuffer sql = new StringBuffer();
       sql.append("select t.* from (select a.*,b.finitorg,b.guid as reviewguid from ");
       sql.append(deptTJPerfAuditDAO.PERF_DEPTP_ERFDECLARE).append(" a ");
       sql.append(" left join ").append(deptTJPerfAuditDAO.PERF_DEPTPERF_TOFININTORG).append(" b ");
       sql.append(" on a.guid = b.mainguid and a.province = b.province and a.year =b.year ");
//       String currentfinitorg = SecureUtil.getCurrentUser().getDivision();
//       sql.append(" and b.finitorg = '"+currentfinitorg+"'");
       if ("waitaudit".equals(tabcode)) {//未纳入
           sql.append("and b.isreview=0 ) t");
       } else {
           sql.append("and b.isreview=1 ) t");
       }
       sql.append(" where 1=1  and finitorg is not null ");
       if (wheresql != null && !wheresql.isEmpty()) {
           sql.append(" and ").append(wheresql);
       }
       if (tablesql != null && !StringUtils.isEmpty(tablesql)){
           sql.append(" and ").append(tablesql);
       }
       if (tabfilter != null && !StringUtils.isEmpty(tabfilter)){
           sql.append(" and ").append(tabfilter);
       }
       sql.append(dsql);
       sql.append(" order by t.code");
       return sql;
   }


    /**
     * 审阅/取消审阅
     * @param params --
     * @return --
     */
    public Map<String, Object> review(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String actioncode = (String) params.get("actioncode");
        String busguid = (String) params.get("busguid");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("seldatas");
        deptTJPerfAuditDAO.saveAll(datas, deptTJPerfAuditDAO.PMKPI_TABLE_TMP_AGENCY);
        int count = deptTJPerfAuditDAO.getDataCount(deptTJPerfAuditDAO.PERF_DEPTP_ERFDECLARE," t.wfstatus ='011' and exists (select 1 from "+deptTJPerfAuditDAO.PMKPI_TABLE_TMP_AGENCY+" a where a.guid=t.guid)");
        if(actioncode!= null && "del".equals(actioncode) && count>0){
            backMap.put("msg","流程已终审，不能取消审阅!");
            return backMap;
        }
        datas.forEach(m->{m.put("guid",m.get("reviewguid"));});
        deptTJPerfAuditDAO.saveAll(datas, deptTJPerfAuditDAO.PMKPI_TABLE_TMP_GUIDS);
        String isreview = "0";
        if(datas!=null && datas.size()>0){
            if(actioncode!= null && "add".equals(actioncode)){//审阅
                isreview = "1";
            }
        }
        StringBuffer exesql = new StringBuffer();
        exesql.append("update ").append(deptTJPerfAuditDAO.PERF_DEPTPERF_TOFININTORG).append(" t set t.isreview =").append(isreview);
        exesql.append(" where  exists(select 1 from " + deptTJPerfAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)");
        deptTJPerfAuditDAO.update(exesql.toString());
        return this.auditdefine(datas, busguid, "perf", null);
    }

}
