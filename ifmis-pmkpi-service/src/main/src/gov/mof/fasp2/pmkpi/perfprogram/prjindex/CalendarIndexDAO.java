package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 参考历年指标
 */
public class CalendarIndexDAO extends PmkpiDAO {
    /**
     * 层次分类编码对比关系中间表
     */
    public String PERF_TABLE_FRAMECONTRAST = "v_perf_t_framecontrast";

    /**
     * 查询指标数据
     * @return
     */
    public Map<String, Object> getIndexDatas(List<Integer> years, String wheresql, String querysql){
        Map<String, Object> backMap = new HashMap<String, Object>();
        StringBuffer sql = new StringBuffer();
        String province = SecureUtil.getUserSelectProvince();
        for (int i=0; i<years.size(); i++) {
            Integer year = years.get(i);
            //查询中间表是否存在数据
            String qsql = " frametype='PM001' and contrastyear='" + year + "'";
            int count = this.getDataCount(this.PERF_TABLE_FRAMECONTRAST, qsql);
            if (count > 0) {//存在，替换一二级指标编码
                sql.append("select t.*, a.newfindex, a.newsindex from pm_perf_indicator t,v_perf_t_framecontrast a where a.frametype='PM001' and a.oldfindex=t.findex and a.oldsindex=t.sindex and a.contrastyear=t.year");
                sql.append(" and t.year=").append(year).append(" and t.province=").append(province);
                sql.append(" and t.yearflag='0' and t.is_deleted=2 and t.is_backup=2 ").append(wheresql);
            } else {
                sql.append("select t.*, t.findex as newfindex, t.sindex as newsindex from pm_perf_indicator t where ");
                sql.append(" t.year=").append(year).append(" and t.province=").append(province);
                sql.append(" and t.yearflag='0' and t.is_deleted=2 and t.is_backup=2 ").append(wheresql);
            }
            if (PerfUtil.getProgramIsyear()) {
                sql.append(" and nvl(t.is_adj, 2) = 2 ");
            }
            if (i != years.size() - 1) {
                sql.append(" union ");
            }
        }
        List<Map<String, Object>> indexList = this.queryForList(sql.toString());
        StringBuffer indexsql = new StringBuffer();
        indexsql.append(" select e.*,'' as indexval0, '' as indexval1, '' as indexval2 from (");
        indexsql.append(" select * from (select b.newfindex as findex,b.newsindex as sindex,b.name,b.computesign,b.meterunit,round(avg(b.indexval),4) as averageval from (").append(sql).append(") b ");
        indexsql.append(" where b.computesign in('1','2','3','4','5') group by b.newfindex,b.newsindex,b.name,b.computesign,b.meterunit)");
        indexsql.append(" union ");
        indexsql.append(" select * from (select b.newfindex as findex,b.newsindex as sindex,b.name,b.computesign,b.meterunit,0 as averageval from (").append(sql).append(") b ");
        indexsql.append(" where b.computesign not in('1','2','3','4','5') group by b.newfindex,b.newsindex,b.name,b.computesign,b.meterunit)");
        indexsql.append(" )e where exists(select 1 from v_perf_t_frame a where a.frametype='PM001' and a.levelno=2 and a.superid=e.findex and a.guid=e.sindex) ");
        if (!StringUtil.isEmpty(querysql)) {
            indexsql.append(" and ").append(querysql);
        }
        indexsql.append(" order by findex,sindex,name");
        List<Map<String, Object>> dataList = this.queryForList(indexsql.toString());
        backMap.put("allIndexList", indexList);
        backMap.put("dataList", dataList);
        return backMap;
    }
}
