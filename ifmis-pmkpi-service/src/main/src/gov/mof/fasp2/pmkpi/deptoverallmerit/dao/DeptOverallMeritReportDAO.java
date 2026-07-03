package gov.mof.fasp2.pmkpi.deptoverallmerit.dao;

import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import java.util.List;
import java.util.Map;

public class DeptOverallMeritReportDAO extends PmkpiDAO {
	
	public static final String ANSWER_TABLE = "perf_t_questanswer";
    public static final String AUDITSUB_TABLE = "perf_t_audititems";
    public static final String AUDITMAIN_TABLE = "perf_t_auditmain";
    public static final String TEMPLATE_TABLE = "perf_t_natrueaudittemp";


    /**
     * 监控项目来源.
     */
    private static final String PERF_PROGRAM_SOURCE = "PERF_V_TRACEPROGRAMS";

    /**
     * 查询符合的项目.
     * @param cols -- 列.
     * @param filter -- 条件.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> getProList(String cols, String filter) {
        StringBuffer sql = new StringBuffer("select ");
        sql.append(cols).append(", t.tracenum from ");
        sql.append(PERF_PROGRAM_SOURCE);
        if (filter != null && StringUtils.isEmpty(filter)) {
            sql.append(" t where ").append(filter);
        }
        sql.append(" order by code");
        return this.getJdbcTemplate().queryForList(sql.toString());
    }
    
    public void deleteByMainguid(String tableName, String guidcol, String mainguid, String where) {
        StringBuilder sql = new StringBuilder("delete from ");
        sql.append(tableName).append(" where ").append(guidcol).append(" = '").append(mainguid).append("'");
        if (null != where) {
            sql.append(" and ").append(where);
        }
        this.execute(sql.toString());
    }


    /**
     * @description 获取四性审核明细数据.
     * @param mainguid -- 主表guid
     * @return map
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getData(String mainguid) {
        //Map<String, Object> map = new HashMap<String, Object>();
        StringBuilder sql = new StringBuilder("select t.*, m.proposal from ");
        sql.append(TEMPLATE_TABLE).append(" t left join (select * from ").append(AUDITSUB_TABLE);
        sql.append(" where auditguid = '").append(mainguid).append("') m on t.guid = m.tempguid order by ordernum");
        List<Map<String, Object>> datas = this.queryForList(sql.toString());
        return datas;
    }
    
    public List<Map<String, Object>> getDataList(String tablecode, String wheresql) {
        String sql = "select * from " + tablecode + " t where 1=1 ";
        if (wheresql != null && !"".equals(wheresql)) {
            sql += " and " + wheresql;
        }
        return this.queryForList(sql);
    }

    public List<Map<String, Object>> checkFile(String billid) {
        String sql = "select " +
                "case when b.code = '00100101' then '0'" +
                " when b.code = '00100102' then '0'" +
                " when b.code = '00100101,00100102' or b.code = '00100102,00100101' then '1'" +
                " when b.code is null or b.code = '' then '0'" +
                "end as code," +
                "case when b.code = '00100101' then b.name||'-工作绩效情况表附件未上传;'" +
                " when b.code = '00100102' then b.name||'-年度总结报告附件未上传;'" +
                " when b.code = '00100101,00100102' or b.code = '00100102,00100101' then ''" +
                " when b.code is null or b.code = '' then b.name||'-年度总结报告和工作绩效情况表附件未上传;' " +
                "end as name " +
                "from (" +
                "select a.name,string_agg(a.code,',') as code from " +
                "(select tt.name,t1.code,t1.name as typename,string_agg(t.filename,',') as filename from PERF_T_DEPTOVERALLMERIT tt " +
                " left join PERF_FILE t on t.billguid = tt.guid" +
                " left join (select * from PERF_FILETYPE where bustype ='deptoverallmerit') t1 on t.filetype = t1.guid " +
                " where tt.guid in ("+billid+")" +
                " group by t1.code,tt.name,t1.name" +
                " )a where a.code in('00100101','00100102') or code is null group by a.name)b";
        logger.info("查询sql输出----------" + sql);
        return this.queryForList(sql);
    }

}
