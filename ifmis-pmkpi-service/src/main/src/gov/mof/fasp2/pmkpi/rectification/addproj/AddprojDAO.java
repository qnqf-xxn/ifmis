package gov.mof.fasp2.pmkpi.rectification.addproj;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import java.util.List;

public class AddprojDAO extends PmkpiDAO {

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

    /**
     * 根据guid查询数据
     * @param guid
     * @return
     */
    public List getDataByMainguid(String tablecode, String guid){
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from ");
        sql.append(tablecode).append(" where mainguid = '").append(guid).append("'");
        return this.queryForList(sql.toString());
    }
}
