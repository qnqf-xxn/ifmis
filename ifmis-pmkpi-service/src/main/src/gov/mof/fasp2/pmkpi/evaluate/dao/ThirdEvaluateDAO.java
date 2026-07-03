package gov.mof.fasp2.pmkpi.evaluate.dao;


import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

public class ThirdEvaluateDAO extends PmkpiDAO {

    public static final String PERF_STRING_HIDEMENU = "thirdevaluatehide";

    /**
     * 项目评审表.
     */
    public static final String PERF_REVIEW_SOURCE = "V_PERF_T_REVIEW";

    /**
     * 修改意见
     */
    public void evaluateOpention(String type) {
        String str = "";
        if (type != null && "confirm".equals(type)) {
            str = "BCB5B04419F20765E053480A050ABEE5";
        } else if (type != null && "unconfirm".equals(type)) {
            str = "BC4E595CCE4511C7E053B11FA8C0AD52";
        } else if (type != null && "back".equals(type)) {
            str = "BC4E595CCE4611C7E053B11FA8C0AD52";
        }
        String sql = "update v_perf_t_evaluateaudit t set t.audittype='" + str + "' where exists(select 1 from " + this.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.proguid)";
        this.execute(sql);
    }

    /**
     * 同步修改项目库评审结论
     * @param tablecode
     */
    public void updateProOpenion(String tablecode) {
        String sql = "update " + tablecode + " f set f.v_col18 = (select name from(select c.name,a.proguid from perf_t_evaluateaudit a left join v_perf_enum c on c.guid=a.audittype where a.proguid=f.guid))" +
                "where exists(select 1 from " + this.PMKPI_TABLE_TMP_GUIDS + " d where d.guid=f.guid)";
        this.execute(sql);
    }
}
