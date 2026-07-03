package gov.mof.fasp2.pmkpi.setting.evaluation.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EvaluationCheckBO extends PmkpiBO {
    private EvaluationReportDAO evaluationReportDAO;

    public void setEvaluationReportDAO(EvaluationReportDAO evaluationReportDAO) {
        this.evaluationReportDAO = evaluationReportDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String type = (String) sqlmap.get("type"); //项目调整选择项目
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select t.* from ").append(tablecode);
        returnsql.append(" t where not exists(select 1 from V_PERF_T_EVALUATION a where a.proguid = t.pro_id )");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (wheresql != null && !wheresql.isEmpty()){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            returnsql.append(" and ").append(tabfilter);
        }
        if (type == null || type.isEmpty()) {
            String wfsql = this.getWfSql(tabcode, workflow);
            if (wfsql != null && !wfsql.isEmpty()) {
                returnsql.append(" and (").append(wfsql).append(") ");
            }
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, evaluationReportDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        returnsql.append(" and (t.pro_cat_code in ('22','3'))");
        return returnsql.toString();
    }
    /**
     * 保存项目数据
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveProgramadjust(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>>  datas = (List<Map<String, Object>>) params.get("datas");
        String tablecode = "V_PERF_T_EVALUATION";
        String workflow = (String)params.get("workflow");
        String bustype = (String) params.get("bustype");
        if (datas != null && datas.size() >= 0) {
            //evaluationReportDAO.saveAll(datas, evaluationReportDAO.PMKPI_TABLE_TMP_GUIDS);
            List<Map<String, Object>> adjustList = new ArrayList<Map<String, Object>>();
            Map<String, Object> adjustMap = null;
            for (Map<String, Object> map : datas) {
                String agencyguid = (String) map.get("agencyguid");
                adjustMap = new HashMap<String, Object>();
                String guid = this.getCreateguid();
                adjustMap.put("pro_code",map.get("pro_code"));
                adjustMap.put("pro_name",map.get("pro_name"));

                adjustMap.put("proguid", map.get("guid"));
                adjustMap.put("guid", guid);
                adjustMap.put("createtime", StringUtil.getSysDBDate());
                adjustMap.put("updatetime", StringUtil.getSysDBDate());
                adjustMap.put("creater", SecureUtil.getCurrentUser().getGuid());
                adjustMap.put("province", SecureUtil.getUserSelectProvince());
                adjustMap.put("year", CommonUtil.getYear());
                adjustMap.put("wfid", workflow);
                adjustMap.put("agencyguid", agencyguid);
                if (bustype != null && !bustype.isEmpty() && "program".equals(bustype)) {
                    adjustMap.put("finintorgguid", map.get("mof_dep_code"));
                } else {
                    adjustMap.put("finintorgguid", map.get("finintorgguid"));
                }
                adjustMap.put("manage_dept_code", map.get("manage_dept_code"));
                adjustMap.put("manage_mof_dep_code", map.get("manage_mof_dep_code"));
                adjustMap.put("mof_dep_code", map.get("mof_dep_code"));
                adjustMap.put("dept_code", map.get("dept_code"));
                adjustMap.put("agency_code", map.get("agency_code"));
                adjustMap.put("islast", 1);
                adjustMap.put("pro_total_amt", map.get("pro_total_amt"));
                adjustMap.put("bustype", bustype);
                adjustList.add(adjustMap);
            }
            this.workflow("create", workflow, "", tablecode, adjustList);
        }
        return backMap;
    }
    /**
     * 字符数字转换.
     * @param map -- map.
     * @param col -- 字段.
     * @return int.
     * @throws
     */
    public int mapGetInt(Map<String, Object> map, String col) {
        Object o = map.get(col);
        if (o == null) {
            return 0;
        }
        return Integer.parseInt(o.toString());
    }
}
