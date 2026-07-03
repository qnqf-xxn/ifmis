package gov.mof.fasp2.pmkpi.evaluation.financial.deptfill;

import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class DeptfillDAO extends PmkpiDAO {
    public static final String PERF_STRING_DEPTFILL = "findeptfillhide";

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

    /**
     * 查询数据.
     * @param wheresql
     * @return
     */
    public List<Map<String, Object>> getDeptScoreDatas(String wheresql,String mainguid,String filetype) {
        String sql = "select t.*,a.selfscore,a.remark,a.remarks,a.mainguid,a.creater,a.status, '' isdeptadd,nvl(t.score,a.score)score,(select replace(wm_concat(vpf.filename), ',', '；') as FILENAME from V_PERF_FILE vpf where vpf.BILLGUID = t.GUID||'"+mainguid+"' and vpf.FILETYPE = '"+filetype+"') as filename  from v_perf_t_evaluatetemp t left join v_perf_t_deptscore a on ";
        sql += wheresql;
        sql += " order by t.ordernum";
        logger.info("查询sql输出----------" + sql);
        return this.queryForList(sql);
    }

    /**
     * 去联查附件上传的数据获取已经上传的文件名
     * @param tablecode
     * @param wheresql
     * @param orderby
     * @return
     */
    public List<Map<String, Object>> getDataFile(String tablecode, String wheresql, String orderby,String filetype,String mainguid) {
        StringBuffer sqlStr = new StringBuffer();
        sqlStr.append(" select t.*,(select replace(wm_concat(vpf.filename), ',', '；') as FILENAME from V_PERF_FILE vpf where vpf.BILLGUID = t.GUID||'")
                .append(mainguid).append("' and vpf.FILETYPE = '").append(filetype).append("') as filename  from ");
        sqlStr.append(tablecode).append(" t where 1 = 1 ");
        if (!StringUtils.isEmpty(wheresql)) {
            sqlStr.append(" and ").append(wheresql).append(" ");
        }
        if (!StringUtils.isEmpty(orderby)) {
            sqlStr.append(orderby);
        }
        logger.info("查询sql输出----------" + sqlStr.toString());
        return this.queryForList(sqlStr.toString());
    }
}
