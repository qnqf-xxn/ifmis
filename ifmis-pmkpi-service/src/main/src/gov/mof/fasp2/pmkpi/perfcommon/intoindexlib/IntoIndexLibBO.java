package gov.mof.fasp2.pmkpi.perfcommon.intoindexlib;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;

public class IntoIndexLibBO extends PmkpiBO {

    /**
     * 纳入指标库
     * @param params
     * @throws AppException
     */
    public void intoindexlib(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String bustype = (String) params.get("bustype");
        String workflow = (String) params.get("workflow");  //工作流
        String agency_code = (String) params.get("agency_code");
        List<String> selindguids = (List<String>) params.get("selindguids");
        List<Map<String, Object>> dataList = new ArrayList<>();
        if (datas != null && datas.size() >= 0) {
            String guid = "";
            for (Map<String, Object> map : datas) {
                guid = this.getCreateguid();
                if (bustype != null && "dept".equals(bustype)) {
                    map.put("is_pm_perf_ind", PerfConstant.PMKPI_TOW);
                    map.put("framesystem", "DEPT");
                } else {
                    map.put("is_pm_perf_ind", PerfConstant.PMKPI_ONE);
                    map.put("framesystem", "PM001");
                }
                map.put("is_last_inst", 2);
                map.put("is_common_ind", 2);
                map.put("adjuststatus", 1);  //数据状态：1新增 2修改 3删除
                map.put("apply_status", 1);
                map.put("guid", guid);
                map.put("status", 1);
                map.put("kpi_val", map.get("indexval"));
                map.put("indexvalue", map.get("indexval"));
                map.put("perf_ind_name", map.get("name"));
                map.put("parent_id", map.get("sindex"));
                map.put("ind_id", guid);
                map.put("level_no", 3);
                map.put("is_leaf", 1);
                map.put("agencyguid", StringUtil.isNullOrEmpty(agency_code) ? CommonUtil.getCurrentUser().getAgency() : agency_code);
                if (StringUtil.isNullOrEmpty((String) map.get("value_desc"))) {
                    map.put("value_desc", map.get("perf_ind_name"));
                }
                map.put("biz_key", null); // 业务唯一标识
                if(PerfUtil.getIsNINGXIA()){
                    map.put("wfstatus","011");
                }else{
                    map.put("wfstatus",null);
                }
                this.getBasMap(map, "add");
                dataList.add(map);
            }
            this.setIndexCode(dataList);
            PmkpiDAO pmkpiDAO = PerfServiceFactory.getPmkpiDAO();
            if(PerfUtil.getIsNINGXIA()){ // 宁夏，直接保存 011 终审状态
                pmkpiDAO.saveAll(dataList,PmkpiDAO.PMKPI_TABLE_BAS_PERF_INDICATOR);
            }else{
                this.workflow("create", workflow, "", PmkpiDAO.PMKPI_TABLE_BAS_PERF_INDICATOR, dataList);
            }
            if (selindguids != null && selindguids.size() >= 0) { // 更新申报指标的 IS_INTOINDEXLIB
                String timestamp = PerfUtil.getServerTimeStamp();
                String wheresql = pmkpiDAO.createInSql("guid", selindguids);
                String updatasql = "update "+PerfConstant.PMKPI_BACKUP_INDICATOR+" t set is_intoindexlib = 1,update_time = '"+timestamp+"' where t.is_intoindexlib = 2 and " + wheresql;
                pmkpiDAO.update(updatasql);
            }
        }
    }

    /**
     * 指标重复校验
     * @param params
     * @throws AppException
     */
    public Map<String, Object> checkExists(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backmap = new HashMap<>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String bustype = (String) params.get("bustype");
        String agency_code = (String) params.get("agency_code");
        StringBuilder wheresql = new StringBuilder(" agency_code = ? ");
        List<Object> sqlParams = new ArrayList<>();
        sqlParams.add(agency_code);
        if (bustype != null && "dept".equals(bustype)) {
            wheresql.append(" and framesystem = 'DEPT' ");
        } else {
            wheresql.append(" and framesystem = 'PM001' ");
        }
        if (datas != null && datas.size() >= 0) {
            StringBuilder qsql = new StringBuilder();
            qsql.append("select industrycategory,sindex,name from ").append(PmkpiDAO.PMKPI_TABLE_BAS_PERF_INDICATOR)
                .append(" where").append(wheresql);
            PmkpiDAO pmkpiDAO = PerfServiceFactory.getPmkpiDAO();
            List<Map<String, Object>> indilist = pmkpiDAO.queryForList(qsql.toString(), sqlParams.toArray());
            // 查询同一个单位下的指标 根据 industrycategory sindex name 作为依据key判断该指标是否存在
            Set<String> existMatchKeys = new HashSet<>();
            if (indilist != null && !indilist.isEmpty()) {
                for (Map<String, Object> indi : indilist) {
                    String industrycategory = indi.get("industrycategory")!=null ? (String) indi.get("industrycategory") : "";
                    String sindex = indi.get("sindex")!=null ? (String) indi.get("sindex") : "";
                    String name = indi.get("name")!=null ? (String) indi.get("name") : "";
                    String matchKey = String.join("\u0000",industrycategory,sindex,name);
                    existMatchKeys.add(matchKey);
                }
            }
            List<String> matchedNames = new ArrayList<>();
            for (Map<String, Object> data : datas) {
                String industrycategory = data.get("industrycategory")!=null ? (String) data.get("industrycategory") : "";
                String sindex = data.get("sindex")!=null ? (String) data.get("sindex") : "";
                String name = data.get("name")!=null ? (String) data.get("name") : "";
                String matchKey = String.join("\u0000",industrycategory,sindex,name);
                // 三个字段完全一致则判定为匹配
                if (existMatchKeys.contains(matchKey)) {
                    matchedNames.add(name);
                }
            }
            backmap.put("nopassname", matchedNames);
        }
        return backmap;
    }

    /**
     * 纳入指标填报要素说明
     * @param params
     * @return
     * @throws AppException
     */
    @Override
    public String getVodSql(Map params) throws AppException {
        String tablecode = params.get("tablecode")!=null ? (String)params.get("tablecode") : "PERF_T_INTOINDEXLIBEXPLAN";
        String tablesql = (String)params.get("tablesql");
        StringBuffer sql = new StringBuffer("select t.* from ").append(tablecode).append(" t ");
        if (tablesql != null && !tablesql.isEmpty()) {
            sql.append(" where (").append(tablesql).append(") ");
        }
        return sql.toString();
    }
}
