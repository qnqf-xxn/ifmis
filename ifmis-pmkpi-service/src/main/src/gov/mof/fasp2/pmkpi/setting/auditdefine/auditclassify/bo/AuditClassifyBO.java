package gov.mof.fasp2.pmkpi.setting.auditdefine.auditclassify.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.setting.auditdefine.auditclassify.dao.AuditClassifyDAO;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AuditClassifyBO extends PmkpiBO  {

	@Resource(name = "pmkpi.setting.auditclassify.AuditClassifyDAO")
	private AuditClassifyDAO auditClassifyDAO;
    
    private final String tablecode = "PMKPI_T_AUDITCLASSIFY";

    /**
     * 审核类型临时表.
     */
    public static final String PMKPI_TABLE_AUDITCLASSIFY = "PMKPI_TMP_AUDITCLASSIFY";
    
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        return "select * from "+tablecode +" order by ordernum";
    }


	public Map infosave(HashMap config) throws AppException {
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) config.get("deldatas");
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String guid = (String) map.get("guid");
            map.put("ordernum", i++);
            if (guid == null || guid.isEmpty()) {
                map.put("guid", StringUtil.createUUID());
    			//初始化有效状态
                map.put("status", "1");
    			//年、省设置
                map.put("province", CommonUtil.getProvince());
                map.put("year", CommonUtil.getYear());
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                addlist.add(map);
            }
        }
        if (deldatas.size() > 0) {
        	auditClassifyDAO.saveAll(deldatas, PMKPI_TABLE_AUDITCLASSIFY);
            String delsql = " exists(select 1 from " + PMKPI_TABLE_AUDITCLASSIFY + " a where a.guid=t.guid)";
            auditClassifyDAO.delDatas(tablecode, delsql);
        }
        if (addlist.size() > 0) {
        	auditClassifyDAO.saveAll(addlist, tablecode);
        }
        return config;
	}
}
