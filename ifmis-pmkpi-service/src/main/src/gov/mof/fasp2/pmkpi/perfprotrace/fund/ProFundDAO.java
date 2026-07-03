package gov.mof.fasp2.pmkpi.perfprotrace.fund;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.Map;

public class ProFundDAO extends PmkpiDAO {

    /**
     * 获取任务对象.
     * @param taskguid--任务guid
     * @return
     */
    public Map<String, Object> getTaskData(String taskguid) {
        String sql = "select * from " + this.PMKPI_TABLE_T_TAKSSET + " t where t.guid='" + taskguid + "'";
        return this.queryForMap(sql);
    }
}
