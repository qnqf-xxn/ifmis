package gov.mof.fasp2.pmkpi.wfparallel;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;

import java.util.List;
import java.util.Map;

public class WfParallelAuditDAO extends PmkpiDAO {

    public static final String PERF_STRING_TRACE = "wfparallelaudithide";

    /**
     * 根据类型获取表名
     * @param lefttabtype 左侧树
     * @param modeltype
     * @return
     */
    public String getTabelByType(String lefttabtype, String modeltype) {
        String tablecode = "";
        if(modeltype != null && "dept".equals(modeltype)){
            tablecode = this.PMKPI_TABLE_DEPTPERFDECLARE;
        }else if(modeltype != null && "trace".equals(modeltype)){
            tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE;
        }
        return tablecode;
    }

    public String getseletcols(String tablecode){
        String sql = "SELECT t.* FROM fasp_t_Diccolumn t WHERE t.tablecode='"+tablecode.toUpperCase()+"'"
                +" and t.columncode not in (select a.columncode from fasp_t_Diccolumn a where a.tablecode ='V_PERF_T_BUSWFPARALLEL')";
        List<Map<String, Object>> list = this.queryForList(sql);
        String column = "";
        for (Map map : list){
            column += "q." + map.get("columncode") + ",";
        }
        return column;
    }

    /**
     * 根据权限获取单位
     * @param wheresql
     * @return
     */
    public List<Map<String, Object>> getTreeList(String wheresql, String tablecode) {
        String sql = "select * from PMKPI_FASP_T_PUBAGENCY m where 1=1 and exists "
                + "(select 1 from (select * from " + tablecode + " t where "
                + wheresql
                + " ) n where m.guid = n.agencyguid ) order by code";
        return this.queryForList(sql);
    }

}
