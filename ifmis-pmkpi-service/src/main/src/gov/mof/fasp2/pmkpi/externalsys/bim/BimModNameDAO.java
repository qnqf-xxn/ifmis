package gov.mof.fasp2.pmkpi.externalsys.bim;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;

public class BimModNameDAO extends PmkpiDAO {
    public static final String CONFIG_TALBE = "PERF_T_BIMMODNAMECONFIG";

    public static final String LOG_TALBE = "PERF_T_BIMMODNAMELOG";

    /**
     * 查询配置信息
     * @param wheresql
     * @return
     */
    public List queryModConfig(String wheresql) {
        String sql = "select * from " + this.CONFIG_TALBE + " t where status=1 ";
        if (!StringUtil.isEmpty(wheresql)) {
            sql += wheresql;
        }
        return queryForList(sql);
    }

    /**
     * 查询日志表，是否已修改
     * @param msgid
     * @param year
     * @param province
     * @return
     */
    public List checkSuccessLog(String msgid, String year, String province) {
        String sql = "select 1 from " + this.LOG_TALBE + " where status=1 and msgid=? and year=? and province=?";
        return queryForList(sql, new Object[] {msgid, year, province});
    }

    /**
     * 日志保存
     * @param saveLogDatas
     * @throws AppException
     */
    public void saveLog(List saveLogDatas) throws AppException {
        this.saveAll(saveLogDatas, this.LOG_TALBE);
    }
}
