package gov.mof.fasp2.pmkpi.perfprotrace.deptsum;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptSumBO extends PmkpiBO {
    private DeptSumDAO deptSumDAO;

    public void setDeptSumDAO(DeptSumDAO deptSumDAO) {
        this.deptSumDAO = deptSumDAO;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<>();
        String tablecode = (String)parms.get("tablecode");
        String tablesql = (String) parms.get("tablesql"); //页签过滤sql
        String mainguid = (String) parms.get("mainguid");
        String agency = (String) parms.get("agency");
        String sql = " mainguid='" + mainguid + "'";
        if (tablesql != null && !"".equals(tablesql)) {
            sql += " and " + tablesql;
        }
        String queryYear = (String)parms.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)parms.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            deptSumDAO.setYearAndProvince(queryYear, queryProvince);
        }
        List<Map<String, Object>> datatablevol = deptSumDAO.getDatas("V_PERF_T_DEPTSUMBM", " agency_code = '"+agency+"'" , " order by ordernum");
        List<Map<String, Object>> datatableear = deptSumDAO.getDatas("V_PERF_T_DEPTSUMYJ", "agency_code = '"+agency+"'", " order by ordernum");
        List<Map<String, Object>> datatablekey = deptSumDAO.getDatas("V_PERF_T_DEPTSUMZD", " t.AGENCYGUID in (select guid from pmkpi_fasp_t_pubagency where superid = '"+agency+"') ", null);
        Map<String, Object> editfrommea = deptSumDAO.getDataMap(tablecode, sql += " and type = '3' ");
        backMap.put("datatablevol", datatablevol);
        backMap.put("datatableear", datatableear);
        backMap.put("datatablekey", datatablekey);
        backMap.put("editfrommea", editfrommea);
        return backMap;
    }

    /**
     * 最终保存方法.
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveData(HashMap<String, Object> params) throws AppException {
        String mainguid = (String) params.get("mainguid");
        String busguid = (String) params.get("busguid");
        String tablecode = (String) params.get("tablecode");
        String saveAgency = (String) params.get("saveAgency");
        List<Map<String, Object>> volList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> earList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> editList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> datatablevol = (List<Map<String, Object>>) params.get("datatablevol");
        List<Map<String, Object>> datatablekey = (List<Map<String, Object>>) params.get("datatablekey");
        Map<String, Object> editfrommea = (Map<String, Object>) params.get("editfrommea");
        Map volMap1 = datatablevol.get(0);
        Map volMap2 = datatablevol.get(1);
        Map vol = new HashMap();
        vol.put("ordernum", 1);
        vol.put("province", CommonUtil.getProvince());
        vol.put("guid", this.getCreateguid());
        vol.put("year", CommonUtil.getYear());
        vol.put("mainguid", mainguid);
        vol.put("createtime", PerfUtil.getServerTimeStamp());
        vol.put("updatetime", PerfUtil.getServerTimeStamp());
        vol.put("status", 1);
        vol.put("type", "1");
        vol.put("vcol2", volMap1.get("vcol2"));
        vol.put("vcol3", volMap1.get("vcol3"));
        vol.put("vcol4", volMap2.get("vcol3"));
        vol.put("vcol5", volMap2.get("vcol3"));
        vol.put("agencyguid", saveAgency);

        volList.add(vol);
        //删除保存
        String delvolsql = " type = '1' and mainguid='" + mainguid + "'";
        deptSumDAO.delDatas(tablecode, delvolsql);
        deptSumDAO.saveAll(volList, tablecode);
        int k = 0;
        for (Map<String, Object> map : datatablekey) {
            k++;
            Map key = new HashMap();
            key.put("ordernum", k);
            key.put("province", CommonUtil.getProvince());
            key.put("guid", this.getCreateguid());
            key.put("year", CommonUtil.getYear());
            key.put("mainguid", mainguid);
            key.put("updatetime", PerfUtil.getServerTimeStamp());
            key.put("createtime", PerfUtil.getServerTimeStamp());
            key.put("status", 1);
            key.put("type", "2");
            key.put("proguid", map.get("proguid"));
            key.put("vcol1", map.get("ssjd"));
            key.put("agencyguid", saveAgency);
            earList.add(key);
        }
        //删除保存
        String delkeysql = " type = '2' and mainguid='" + mainguid + "'";
        deptSumDAO.delDatas(tablecode, delkeysql);
        deptSumDAO.saveAll(earList, tablecode);
        Map<String, Object> deptSumMap = this.getDeptSumEdit(tablecode, mainguid);
        if (deptSumMap.isEmpty()) {
            deptSumMap.put("province", CommonUtil.getProvince());
            deptSumMap.put("guid", this.getCreateguid());
            deptSumMap.put("year", CommonUtil.getYear());
            deptSumMap.put("mainguid", mainguid);
            deptSumMap.put("updatetime", PerfUtil.getServerTimeStamp());
            deptSumMap.put("createtime", PerfUtil.getServerTimeStamp());
            deptSumMap.put("status", 1);
            deptSumMap.put("type", "3");
            deptSumMap.put("immeasures", editfrommea.get("immeasures"));
            deptSumMap.put("agencyguid", saveAgency);
            editList.add(deptSumMap);
            deptSumDAO.save(deptSumMap, tablecode);
        } else {
            deptSumMap.put("updatetime", PerfUtil.getServerTimeStamp());
            deptSumMap.put("immeasures", editfrommea.get("immeasures"));
            deptSumDAO.update(deptSumMap, tablecode);
        }
        return this.auditdefine(volList, busguid,"perf", null);
    }


    public Map<String, Object> getDeptSumEdit(String tablecode, String mainguid) {
        List<Map<String, Object>> list = deptSumDAO.getDatas(tablecode, " type = '3' and mainguid='"+mainguid+"'", null);
        if (list != null && list.size()>0){
            return list.get(0);
        }
        return new HashMap<String, Object>();
    }
}
