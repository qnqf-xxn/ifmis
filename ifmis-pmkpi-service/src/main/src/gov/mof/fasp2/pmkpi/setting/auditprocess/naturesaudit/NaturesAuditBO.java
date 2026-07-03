package gov.mof.fasp2.pmkpi.setting.auditprocess.naturesaudit;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 21:29 2020/8/13  chongdayong
 */
public class NaturesAuditBO extends PmkpiBO {
    private NaturesAuditDAO naturesAuditDAO;

    public void setNaturesAuditDAO(NaturesAuditDAO naturesAuditDAO) {
        this.naturesAuditDAO = naturesAuditDAO;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public void tablesave(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //修改数据
//        List<Map<String, Object>> updatas = (List<Map<String, Object>>) params.get("updatas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");

        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            map.put("ordernum", i++);
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("agencyguid", SecureUtil.getCurrentUser().getAgency());
                map.put("status", 1);
                addlist.add(map);
            } else {
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            naturesAuditDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            naturesAuditDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            naturesAuditDAO.saveAll(deldatas, naturesAuditDAO.PMKPI_TABLE_TMP_GUIDS);
            String delsql = " exists(select 1 from " + naturesAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
            naturesAuditDAO.delDatas(tablecode, delsql);
        }
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        String tablecode = (String)params.get("tablecode");
        String tablesql = (String)params.get("tablesql");
        String orderby = (String)params.get("tableorderby");
        List<Map<String, Object>> data = naturesAuditDAO.getDatas(tablecode, tablesql, orderby);
        backMap.put("data", data);
        return backMap;
    }
}
