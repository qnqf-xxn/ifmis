package gov.mof.fasp2.pmkpi.hbtracereport.upload;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;

public class HbtracereportDAO extends PmkpiDAO {

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
}
