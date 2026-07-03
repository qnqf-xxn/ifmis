package gov.mof.fasp2.pmkpi.deptTJformance.audit;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptTJPerftofinintorgBO extends PmkpiBO {

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
       String mainguid = (String)sqlmap.get("mainguid");
       String tabfilter = (String) sqlmap.get("tabfilter");
       String tablesql = (String) sqlmap.get("tablesql");
       String wheresql = (String) sqlmap.get("querySql");
       String tabcode = (String) sqlmap.get("tabcode");
       StringBuffer sql = new StringBuffer();
       if ("waitaudit".equals(tabcode)) {//未纳入
           sql.append("select * from (select '' as guid,'"+mainguid+"' as mainguid,a.code as finitorg,a.name as finitorgname,a.province,a.year from ");
           sql.append(deptTJPerfAuditDAO.PERF_DEPTPERF_WAITFININTORG).append(" a ");
           sql.append(" where not exists (select 1 from ").append(deptTJPerfAuditDAO.PERF_DEPTPERF_TOFININTORG);
           sql.append(" b where b.mainguid = '"+mainguid+"' and a.code = b.finitorg and a.province = b.province and a.year =b.year)) t");
       } else {
           sql.append("select * from (select * from ");
           sql.append(deptTJPerfAuditDAO.PERF_DEPTPERF_TOFININTORG).append(" where mainguid = '"+mainguid+"' and province ='"+ SecureUtil.getUserSelectProvince()+"' and year = '"+ CommonUtil.getYear()+"') t");
       }
       sql.append(" where 1=1 ");
       if (wheresql != null && !wheresql.isEmpty()) {
           sql.append(" and ").append(wheresql);
       }
       if (tablesql != null && !StringUtils.isEmpty(tablesql)){
           sql.append(" and ").append(tablesql);
       }
       if (tabfilter != null && !StringUtils.isEmpty(tabfilter)){
           sql.append(" and ").append(tabfilter);
       }
       sql.append(" order by t.finitorg");
       return sql;
   }


    /**
     * 分发/取消分发
     * @param params --
     * @return --
     */
    public Map<String, Object> tofinintorg(HashMap<String, Object> params) throws AppException {
        String actioncode = (String) params.get("actioncode");
        String busguid = (String) params.get("busguid");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("seldatas");
        if(datas!=null && datas.size()>0){
            if(actioncode!= null && "add".equals(actioncode)){//分发
                datas.forEach(m -> {m.put("guid",this.getCreateguid());m.put("isreview",0);});
                deptTJPerfAuditDAO.saveAll(datas, deptTJPerfAuditDAO.PERF_DEPTPERF_TOFININTORG);
            } else if(actioncode!= null && "del".equals(actioncode)){//取消分发
                deptTJPerfAuditDAO.saveAll(datas, deptTJPerfAuditDAO.PMKPI_TABLE_TMP_AGENCY);
                String delsql = " exists(select 1 from " + deptTJPerfAuditDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
                deptTJPerfAuditDAO.delDatas(deptTJPerfAuditDAO.PERF_DEPTPERF_TOFININTORG,delsql);
            }
        }
        return this.auditdefine(datas, busguid, "perf", null);
    }

}
