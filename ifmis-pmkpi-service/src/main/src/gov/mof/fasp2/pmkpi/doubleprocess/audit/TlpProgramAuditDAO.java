package gov.mof.fasp2.pmkpi.doubleprocess.audit;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class TlpProgramAuditDAO extends PmkpiDAO {

    /**
     * 获取预算单位与项目的对应状态.
     * @return
     */
    public List<Map<String, Object>> findPBdmWf(){
        String sql = "select t.bdmwf,t.perfwf,t.beforewf from v_perf_bdmwfstatus t";
        return this.queryForList(sql);
    }
}
