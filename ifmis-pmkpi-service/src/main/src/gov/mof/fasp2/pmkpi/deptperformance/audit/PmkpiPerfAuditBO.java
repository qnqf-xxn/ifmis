
package gov.mof.fasp2.pmkpi.deptperformance.audit;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PmkpiPerfAuditBO extends PmkpiBO {

    private PmkpiPerfAuditDAO pmkpiPerfAuditDAO;

    public void setPmkpiPerfAuditDAO(PmkpiPerfAuditDAO pmkpiPerfAuditDAO) {
        this.pmkpiPerfAuditDAO = pmkpiPerfAuditDAO;
    }

    /**
     * 获取审核数据.
     * @param nodeguid --节点guid
     * @return --
     * @throws AppException
     */
    @SuppressWarnings({"unchecked", "rawtypes" })
    public Map<String, Object> getTableData(String busguid, String audittype, String agencyguid, String nodeguid)
            throws AppException {
        Map<String, Object> rt = new HashMap<String, Object>();
        List<Map<String, Object>> auditlist = pmkpiPerfAuditDAO.getAuditData(busguid, audittype, nodeguid);
        String mainguid = "";
        Map<String, Object> editmap = new HashMap<String, Object>();
        if (auditlist.size() > 0) {
            editmap = auditlist.get(0);
            mainguid = String.valueOf(editmap.get("guid"));
        }
        Map<String, Object> dataMap = new HashMap<String, Object>();
        List<Map<String, Object>> subdatas = pmkpiPerfAuditDAO.getData(mainguid);
        for (Map<String, Object> data : subdatas) {
            data.put("tempguid", data.get("guid"));
        }
        dataMap.put("datas", subdatas);
        rt.putAll(dataMap);
        rt.put("editmap", editmap);
        return rt;
    }

    @SuppressWarnings("unchecked")
    public Map<String, Object> save(HashMap<String, Object> param) throws AppException {
        Map<String, Object> resMap = new HashMap<String, Object>();
        Map<String, Object> mainMap = (Map<String, Object>) param.get("maindata");
        String mainguid = String.valueOf(param.get("mainguid"));
        String nodeguid = String.valueOf(param.get("nodeguid"));
        String audittype = String.valueOf(param.get("audittype"));
        String agencyguid = String.valueOf(param.get("agency"));
        mainMap.put("mainguid", mainguid);
        mainMap.put("nodeguid", nodeguid);
        mainMap.put("agencyguid", agencyguid);
        mainMap.put("createtime", StringUtil.getSysDBDate());
        mainMap.put("updatetime", StringUtil.getSysDBDate());
        mainMap.put("province", SecureUtil.getUserSelectProvince());
        mainMap.put("type", audittype);
        mainMap.put("year", CommonUtil.getYear());
        String guid = (String) mainMap.get("guid");
        if (guid == null || StringUtils.isEmpty(guid)) {
            mainMap.put("guid", this.getCreateguid());
            mainMap.put("userguid", SecureUtil.getCurrentUser().getGuid());
        }
        //String guid = mainMap.get("guid").toString();
        if (null != param.get("datas")) {
            List<Map<String, Object>> datas = (List<Map<String, Object>>) param.get("datas");
            for (Map<String, Object> map : datas) {
                map.put("guid", this.getCreateguid());
                map.put("mainguid", mainguid);
                map.put("auditguid", guid);
            }
            String delsql = " auditguid ='" + guid + "'";
            pmkpiPerfAuditDAO.delDatas(pmkpiPerfAuditDAO.AUDITSUB_TABLE, delsql);
            pmkpiPerfAuditDAO.saveAll(datas, pmkpiPerfAuditDAO.AUDITSUB_TABLE);

        }
		String wheresql = " and nodeguid='" + nodeguid + "' and userguid='" + SecureUtil.getCurrentUserID() + "' and type='" + audittype + "'";
        String delsql = " mainguid ='" + mainguid + "'" + wheresql;
        pmkpiPerfAuditDAO.delDatas(pmkpiPerfAuditDAO.AUDITMAIN_TABLE, delsql);
        pmkpiPerfAuditDAO.save(mainMap, pmkpiPerfAuditDAO.AUDITMAIN_TABLE);
        return resMap;
    }

    public Integer queryFileCount(HashMap<String,Object> params){
        String guid = (String) params.get("guid");
        String wheresql ="select count(pf.guid) from perf_filetype t left join (select * from v_PERF_FILE " +
                " where BILLGUID = '"+guid+"') pf on t.guid = pf.filetype" +
                " where t.bustype = 'evaluatereport' and t.guid ='DEF4883808B14613E0533315A8C0BC2A'";
        return pmkpiPerfAuditDAO.queryForInt(wheresql);
    }

}
