package gov.mof.fasp2.pmkpi.rectification.dao;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class RectificationFileDAO extends PmkpiDAO {

    public List<Map<String, Object>> getDatas(String tablecode,String billid) {
        String sql = "select t.guid,t.code,t.name,t.superid,t.ordernum,t.supername,t.remark," +
                "pf.filename,t.levelno from " + tablecode + " t left join (select filetype,billguid,listagg(a.filename, '；') within group (order by a.filename) as filename from v_perf_file a where billguid ='"+billid+"' group by billguid,filetype) pf on t.guid = pf.filetype";
        sql += " order by t.ordernum,t.code";
        logger.info("查询sql输出----------" + sql);
        return this.queryForList(sql);
    }

}
