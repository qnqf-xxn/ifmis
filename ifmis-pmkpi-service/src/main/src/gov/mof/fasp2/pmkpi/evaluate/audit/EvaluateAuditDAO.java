package gov.mof.fasp2.pmkpi.evaluate.audit;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class EvaluateAuditDAO extends PmkpiDAO {

    public List<Map<String, Object>> getFile (String proguid){
        String sql = "select s.filename,s.filecontent as fileguid,s.createtime as create_time from v_pm_attachment t,v_pm_filecontents s where t.guid=s.attachguid and t.attachtype='DE9176' and t.proguid='"+proguid+"'";
        return this.queryForList(sql);
    }

    /**
     * 获取审核类型数据源
     * @return
     */
    public List<Map<String, Object>> getAudittypeDatas() {
        String sql = "SELECT t.guid itemid,t.name,t.code,t.levelno,t.isleaf,t.superid superitemid  FROM v_perf_enum t where t.elementcode='AUDITTYPE' " +
                " and t.code in ('001','002','003') order by t.ordernum";
        return this.queryForList(sql);
    }

}
