package gov.mof.fasp2.pmkpi.prorevision.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProrevisionCheckBO extends PmkpiBO {
    private ProrevisionReportDAO revisionReportDAO;

    public void setRevisionReportDAO(ProrevisionReportDAO revisionReportDAO) {
        this.revisionReportDAO = revisionReportDAO;
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

        String checksql = "";
        if(PerfUtil.getIsHbei()){
            checksql = " t.guid=a.proguid ";
        }else {
            checksql = " t.pro_code=a.pro_code ";
        }
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select t.* from ");
        returnsql.append(tablecode).append(" t where not exists(select 1 from " + revisionReportDAO.PERF_TABLE_PROVISIONDECLARE + " a where "+ checksql +" and a.wfstatus <> '011')");
        returnsql.append(" and not exists(select 1 from V_PERF_T_ADJUST a where "+ checksql +" and a.wfstatus <> '011')");//增加条件不在绩效目标调整模块流程中
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        //根据数据单位和授权单位表联查得出授权单位--只在选择项目种控制
        datarule += " and exists "
                + "(select 1  from " + revisionReportDAO.PERF_TABLE_REVISION_AGENCY + " a where a.guid = t.agencyguid )";

        if (wheresql != null && !wheresql.isEmpty()){
            returnsql.append(" and ").append(wheresql);
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
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, revisionReportDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        returnsql.append(" and (t.pro_cat_code in ('22','3'))");
        return returnsql.toString();
    }
    /**
     * 保存调整数据
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveProgramadjust(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>>  datas = (List<Map<String, Object>>) params.get("datas");
        String tablecode = revisionReportDAO.PERF_TABLE_PROVISIONDECLARE;
        String workflow = (String)params.get("workflow");
        String bustype = (String) params.get("bustype");
        if (datas != null && datas.size() >= 0) {
            revisionReportDAO.saveAll(datas, revisionReportDAO.PMKPI_TABLE_TMP_GUIDS);
            String wheresql = "";
            //根据项目信息获取调整主单信息
            wheresql = " exists(select * from "+ revisionReportDAO.PMKPI_TABLE_TMP_GUIDS + " a where t.proguid=a.guid) ";
            List<Map<String, Object>> maindatas = revisionReportDAO.getDatas(tablecode, wheresql, null);
            //删除临时表数据
            revisionReportDAO.delDatas(revisionReportDAO.PMKPI_TABLE_TMP_GUIDS, null);
            revisionReportDAO.saveAll(maindatas, revisionReportDAO.PMKPI_TABLE_TMP_GUIDS);
            //获取项目最大修订次数
            List<Map<String, Object>> revisionnums = revisionReportDAO.getJustnums();
            List<Map<String, Object>> adjustList = new ArrayList<Map<String, Object>>();
            Map<String, Object> adjustMap = null;
            for (Map<String, Object> map : datas) {
                String agencyguid = (String) map.get("agencyguid");
                adjustMap = new HashMap<String, Object>();
                String guid = this.getCreateguid();
                adjustMap.put("revisionnum", 1);
                adjustMap.put("pro_code",map.get("pro_code"));
                adjustMap.put("pro_name",map.get("pro_name"));
                int adjustnum = 0;
                for (Map<String, Object> m : revisionnums) {
                    String proguid = (String) m.get("proguid");
                    adjustnum = this.mapGetInt(m,"revisionnum");
                    if (map.get("guid") != null && map.get("guid").equals(proguid)) {
                        adjustMap.put("revisionnum", adjustnum + 1);
                        break;
                    }
                }
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
                adjustMap.put("modtype", "revision");
                adjustMap.put("revisionstatus", "2");
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
