package gov.mof.fasp2.pmkpi.evaluation.financial.additonalinfo;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;

public class AdditionalInfoDAO extends PmkpiDAO {

    /**
     * 根据guid查询数据
     * @param guid
     * @return
     */
    public List getByGuid(String tablecode, String guid){
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from ").append(tablecode).append(" where mainguid = '").append(guid).append("'");
        return this.queryForList(sql.toString());
    }
}
