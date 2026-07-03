package gov.mof.fasp2.pmkpi.setting.auditdefine.define;


import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AuditDefinedDAO extends PmkpiDAO  {
	
	 /**
     * 视图审核表
     */                                              
    public static final String TABLE_CODE = "V_PERF_T_AUDITDEFINE";
    
	 /**
     * 审核定义数据查询
     * @param parms --
     * @return
     */
    public List<Map<String, Object>> getData(HashMap<String,Object> parms) {
    	String auditdetype=(String)parms.get("auditdetype");
    	String sql = "select * from "+ TABLE_CODE +" t where t.auditdetype='"+auditdetype+"'";
        logger.info("---查询审核定义：" + sql);
        return this.queryForList(sql);
    }

}
