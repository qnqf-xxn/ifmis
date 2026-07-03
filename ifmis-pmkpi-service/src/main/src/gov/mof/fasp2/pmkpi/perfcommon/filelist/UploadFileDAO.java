package gov.mof.fasp2.pmkpi.perfcommon.filelist;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class UploadFileDAO extends PmkpiDAO {

    public List<Map<String, Object>> getDatas(String wheresql, String filebustype, String subprovince, String billid) {
        String sql = "select t.guid,t.code,t.name,t.SUPERID,t.ORDERNUM,'' as supername,t.REMARK,replace(wm_concat(pf.filename), ',', '；') as FILENAME,t.levelno from perf_filetype t left join  (select * from ";
        if ("subprovinceworkeval".equals(filebustype)) {
            sql += "PERF_FILE where province = '" + subprovince + "'";
        } else {
            sql += "v_PERF_FILE where 1=1 ";
        }
        sql += " and BILLGUID = '" + billid + "' ) pf on (t.guid = pf.filetype) where ";
        if (wheresql != null && !wheresql.isEmpty()) {
            sql += wheresql;
        }
        sql += "  group by t.guid,t.code,t.name,t.SUPERID,t.ORDERNUM,t.REMARK,t.levelno ";
        logger.info("查询sql输出----------" + sql);
        return this.queryForList(sql);
    }

}
