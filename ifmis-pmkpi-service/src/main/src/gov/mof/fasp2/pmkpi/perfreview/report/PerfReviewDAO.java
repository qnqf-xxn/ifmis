package gov.mof.fasp2.pmkpi.perfreview.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfReviewDAO extends PmkpiDAO {


    public void updateislast(String wheresql, String bustype){
        String sql = "update v_perf_t_review t set t.islast = 0 where t.type='" + bustype + "' and " + wheresql;
        this.update(sql);
    }

    /**
     * 查询评审次数
     * @param wheresql
     * @param bustype
     * @return
     */
    public int findReviewNum(String wheresql, String bustype){
        String sql = "select NVL(max(t.reviewnum), 0) from v_perf_t_review t where t.type='" + bustype + "' and " + wheresql;
        return this.queryForInt(sql);
    }

    /**
     * 查询初次评审意见
     * @param wheresql
     * @return
     */
    public Map<String, Object> getFirstReview(String wheresql, String bustype, int reviewnum){
        String sql = "select * from " + this.PMKPI_TABLE_T_AUDITMAIN + " a where exists(select 1 from v_perf_t_review t where t.reviewnum=? and a.mainguid=t.guid and t.type=? and " + wheresql + ")";
        List<Map<String, Object>> list = this.queryForList(sql, new Object[]{reviewnum, bustype});
        Map<String, Object> map = new HashMap<>();
        if (list.size() > 0) {
            map.put("mainlist", PerfUtil.lowMapKey(list));
        }
        sql = "select a.*,bb.ordernum from " + this.PMKPI_TABLE_T_AUDITITEMS + " a left join v_perf_t_reviewtemp bb on bb.guid=a.tempguid where exists(select 1 from v_perf_t_review t where t.reviewnum=? and a.mainguid=t.guid and t.type=? and " + wheresql + ")";
        list = this.queryForList(sql, new Object[]{reviewnum, bustype});
        if (list.size() > 0) {
            map.put("sublist", PerfUtil.lowMapKey(list));
        }
        return map;
    }

    /**
     * 确认评审；
     * @return
     */
    public void updateconfirm (String tablecode, String col, String wheresql, String flag) throws AppException {
        String sql = "update "+tablecode+" t set t." + col +" = '"+flag+"' where 1=1 and "+wheresql;
        this.execute(sql);
    }

    /**
     * 同步修改项目库评审结论
     * @param tablecode
     */
    public void updateProOpenion(String tablecode) {
        String sql = "update " + tablecode + " f set f.v_col17 = (select name from(select c.name,b.proguid from (select  case when a.sreview is null then" +
                " a.freview else a.sreview end freview,a.proguid from " + this.PMKPI_TABLE_T_AUDITITEMS + " a where a.tempguid = 'B9C7D80EC0298933E053B11FA8C0A5D6')b left join v_perf_enum c on c.guid=b.freview)d where d.proguid=f.guid)" +
                "where exists(select 1 from " + this.PMKPI_TABLE_TMP_GUIDS + " d where d.guid=f.guid)";
        this.execute(sql);
    }

    /**
     * 查询评审的主单数据
     */
    public List<Map<String, Object>> getReviewData(String wheresql) {
        String sql = "select t.* from v_perf_t_review t where 1=1 and t.islast=1 and t.isconfirm<>'1' " + wheresql;
        //删除审核意见
        String delsql = "delete from " + this.PMKPI_TABLE_T_AUDITMAIN + " f where exists (select 1 from (" + sql + " )e where e.guid=f.mainguid) ";
        this.execute(delsql);
        delsql = "delete from " + this.PMKPI_TABLE_T_AUDITITEMS + " f where exists (select 1 from (" + sql + " )e where e.guid=f.mainguid) ";
        this.execute(delsql);
        return this.queryForList(sql);
    }

    /**
     * 查询评审意见模板数据
     */
    public List<Map<String, Object>> getReviewTemp() {
        String sql = "select t.* from v_perf_t_reviewtemp t ";
        return this.queryForList(sql);
    }

    /**
     * 获取未提交的数据
     * @param tablecode
     * @param wheresql
     * @return
     */
    public List<Map<String, Object>> getReViewData(String tablecode, String wheresql){
        String sql = "select * from " + tablecode + " t where exists(select 1 from "+ this.PMKPI_TABLE_T_AGENCY +" b where t.agencyguid=t.guid) and not exists(select 1 from v_perf_t_review a where " + wheresql + ")";
        return this.queryForList(sql);
    }

    /**
     * 获取项目单位信息.
     * @param wfstatus --
     * @throws AppException
     */
    public String getProAgencyDatas(String wfstatus) {
        String sql = "select 1 from (select agencyguid as guid  from busfw_t_dctableprocess where taskguid in('A69147082E975D0733386A42C3E5F4B5','9EE3A842793449818960559B00660C1B') and wfstatus in(" + wfstatus + ")) tt where tt.guid=t.agencyguid";
        logger.info("项目查询sql++++++++++" + sql.toString());
        return sql.toString();
    }

    /**
     * 获取项目编码信息.
     * @param wfstatus --
     * @throws AppException
     */
    public String getProCodeDatas(String wfstatus) {
        String sql = "select 1 from (select PROCODE as PROCODE from busfw_t_dctableprocess where taskguid in ('4B67D882C7AE41CC951D761853827E9C') and wfstatus in (" + wfstatus + ")) tt where tt.PROCODE = t.pro_code";
        logger.info("转移支付查询sql++++++++++" + sql.toString());
        return sql.toString();
    }

    /**
     * 获取部门单位信息.
     * @param wfstatus --
     * @throws AppException
     */
    public String getDeptAgencyDatas(String wfstatus) {
        String whersql = " taskguid in('A69147082E975D0733386A42C3E5F4B5','9EE3A842793449818960559B00660C1B') and wfstatus in(" + wfstatus + ") ";
        StringBuffer sql = new StringBuffer();
        sql.append(" select 1 from (select  agencyguid as guid from busfw_t_dctableprocess where ").append(whersql);
        sql.append(" union all ");
        sql.append(" select distinct substr(agencyguid,0,3) as guid from busfw_t_dctableprocess where ").append(whersql);
        sql.append(" ) tt where tt.guid=t.agencyguid");
        logger.info("部门查询sql++++++++++" + sql.toString());
        return sql.toString();
    }
}
