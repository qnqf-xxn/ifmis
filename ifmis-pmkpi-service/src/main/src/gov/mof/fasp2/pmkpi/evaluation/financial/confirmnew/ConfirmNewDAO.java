package gov.mof.fasp2.pmkpi.evaluation.financial.confirmnew;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ConfirmNewDAO extends PmkpiDAO{

    /**
     * 根据guid查询数据
     * @param guid
     * @return
     */
    public List getDataByGuid(String tablecode, String guid){
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from ");
        sql.append(tablecode).append(" where guid = '").append(guid).append("'");
        return this.queryForList(sql.toString());
    }

    public Map<String, Object> getCount(String tablecode) {
        String sql = "SELECT MAX(TO_NUMBER(code)) AS code FROM " + tablecode + " t  where  t.isadd='1'";
        List list = (List) PerfUtil.lowMapKey(this.queryForList(sql));
        if (list.size() > 0) {
            return (Map<String, Object>) list.get(0);
        } else {
            return new HashMap<>();
        }
    }
}
