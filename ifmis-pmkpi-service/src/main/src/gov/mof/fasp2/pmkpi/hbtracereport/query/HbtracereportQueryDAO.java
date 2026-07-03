package gov.mof.fasp2.pmkpi.hbtracereport.query;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;

public class HbtracereportQueryDAO extends PmkpiDAO {

    public List getFileNameList(String mainguid, String filebustype){
        StringBuffer sql = new StringBuffer();
        sql.append("SELECT * FROM perf_file t,v_perf_t_hbtracereportupload a where a.GUID=t.billguid and t.billguid = '").append(mainguid);
        sql.append("' and exists (select 1 from perf_filetype a WHERE t.filetype = a.guid and a.bustype='");
        sql.append(filebustype).append("' )");
        return this.queryForList(sql.toString());
    }
}
