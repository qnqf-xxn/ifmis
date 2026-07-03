package gov.mof.fasp2.pmkpi.perfprogrammiddle.midaudit;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.externalsys.pdm.PdmBackInfoBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.setting.casepage.report.CaseReportBO;
import gov.mof.fasp2.pmkpi.setting.casepage.report.CaseReportDAO;

import java.util.*;
import java.util.stream.Collectors;

public class MidProgramAuditBO extends PmkpiBO {
	
	private MidProgramAuditDAO midProgramAuditDAO;

	public void setMidProgramAuditDAO(MidProgramAuditDAO midProgramAuditDAO) {
		this.midProgramAuditDAO = midProgramAuditDAO;
	}

	public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf");
        String agency = (String)sqlmap.get("agency");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String workflow = (String) sqlmap.get("workflow");
        String tablesql = (String) sqlmap.get("tablesql");//查询条件
        String tabcode = (String) sqlmap.get("tabcode");
        String datarule = this.getDataRuleByMenuguid(menuid, "t", "1=1"); //数据权限
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where ");
        StringBuffer wsql = new StringBuffer();
        if (wheresql != null && !wheresql.isEmpty()){
            wsql.append(" and (").append(wheresql).append(")");
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            wsql.append(" and ").append(tabfilter);
        }
        if (tablesql != null && !tablesql.isEmpty()){
            wsql.append(" and ").append(tablesql);
        }
        String wfsql = getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            wsql.append(" and ").append(wfsql);
        }
        sql.append(datarule);
        if (wsql.length() > 0) {
            sql.append(wsql);
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, midProgramAuditDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }

    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId, String prolev) throws AppException {
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String sysvalue = PerfUtil.getSystemSet("tlprogram_lefttree_" + prolev);
        if (StringUtil.isEmpty(sysvalue)){
            sysvalue  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        }
        leftconfig.put("datas", this.getLeftTreeData(menuId,sysvalue));
        return leftconfig;
    }

    /**
     * 左侧树数据
     * @param menuId
     * @param sysvalue
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getLeftTreeData(String menuId,String sysvalue)
            throws AppException {
        String tablecode = "V_PERF_T_DEPTPERFMIDDECLARE";
        String sql = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        //根据权限查询
        return midProgramAuditDAO.getLeftTree(tablecode, sql);
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String tablecode = "V_PERF_T_DEPTPERFMIDDECLARE";
        String busguid = (String) params.get("busguid");
        String remark = (String) params.get("remark");
        List<String> guidList = new ArrayList<>();
        String guid = "";
        //取消审核执行流程前终审的数据
        int is_last_inst = 0;
        List<Map<String, Object>> proList = new ArrayList<>();
        if ("cancelaudit".equals(actioncode) || "back".equals(actioncode)) {
            Map<String, Object> backData;
            is_last_inst = 2;
            for (Map<String, Object> data : datas){
                String wfstatus = (String) data.get("wfstatus");
                if (PerfUtil.getIsHbei()){
                    guid = (String) data.get("guid");
                }else{
                    guid = (String) data.get("pro_code");
                }
                if("011".equals(wfstatus)){
                    guidList.add(guid);
                }
                backData  = new HashMap<>();
                backData.put("pro_code", data.get("pro_code"));
                backData.put("pro_id", data.get("proguid"));
                backData.put("stage", "3");
                backData.put("wfstatus", wfstatus);
                proList.add(backData);
            }
        }
        if (PerfUtil.getIsNINGXIA() && "back".equals(actioncode)) {
            Map data = new HashMap();
            Map<String, Object> backMap = new HashMap<>();
            backMap.put("backType", "4");
            backMap.put("opinion", remark);
            data.put("proList", proList);
            data.put("backMap", backMap);
            PdmBackInfoBO pdmBackInfoBO = (PdmBackInfoBO) PerfServiceFactory.getBean("pmkpi.service.PdmBackInfoBOTX");
            pdmBackInfoBO.save(data);
        }
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        //走完流程后，审核完获取终审数据
        if ("audit".equals(actioncode) || "auditbatch".equals(actioncode)) {
            is_last_inst = 1;
            for (Map<String, Object> data : datas){
                String wfstatus = (String) data.get("wfstatus");
                if (PerfUtil.getIsHbei()){
                    guid = (String) data.get("guid");
                }else{
                    guid = (String) data.get("pro_code");
                }
                if("011".equals(wfstatus)){
                    guidList.add(guid);
                }
            }
        }
        if(guidList.size() > 0){
            String upcol = "";
            if (PerfUtil.getIsHbei()){
                upcol = "mainguid";
            }else{
                upcol = "pro_code";
            }
            String upsql = " is_last_inst = " + is_last_inst;
            String wheresql = " yearflag = '0' ";
            midProgramAuditDAO.updateAllByColumn(upcol, guidList, PerfConstant.PMKPI_VPM_GOAL_INFO, upsql, wheresql);
            midProgramAuditDAO.updateAllByColumn(upcol, guidList, PerfConstant.PMKPI_VPM_INDICATOR, upsql, wheresql); 
        }
        return this.auditdefine(datas, busguid, actioncode, null);
    }


    /**
     * 纳入案例库
     * @param params --
     * @return --
     */
    public Map<String, Object> intoCase(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String province = SecureUtil.getUserSelectProvince();
        String year = CommonUtil.getYear();
        String creater = SecureUtil.getCurrentUser().getGuid();
        List<String> procodeList = new ArrayList<>();
        List<String> proguidList = new ArrayList<>();
        Map<String, Object> proMap = new HashMap<>();
        datas.forEach(map-> {
            String pro_code = (String) map.get("pro_code");
            procodeList.add(pro_code);
            proguidList.add((String) map.get("proguid"));
            proMap.put(pro_code, map);
        });
        StringBuffer wheresql = new StringBuffer();
        wheresql.append(midProgramAuditDAO.createInSql("code", procodeList));
        List<Map<String, Object>> caseList = this.getDatas(CaseReportDAO.TABLECODE_T_CASE, wheresql.toString(), null);
        if (!caseList.isEmpty()) {
            //删除已存在的案例
            CaseReportBO caseReportBO = (CaseReportBO) PerfServiceFactory.getBean("pmkpi.casepage.report.CaseReportBOTX");
            HashMap par = new HashMap();
            par.put("datas", caseList);
            caseReportBO.del(par);
        }
        wheresql = new StringBuffer();
        wheresql.append(midProgramAuditDAO.createInSql("pro_code", procodeList));
        wheresql.append(" and perf_obj_type_code='2'");
        List<Map<String, Object>> goalList = this.getDatas(PerfConstant.PMKPI_VPM_GOAL_INFO, wheresql.toString(), null);
        List<Map<String, Object>> indexList = this.getDatas(PerfConstant.PMKPI_VPM_INDICATOR, wheresql.toString(), null);
        wheresql = new StringBuffer();
        wheresql.append(midProgramAuditDAO.createInSql("mainguid", proguidList));
        wheresql.append(" and is_deleted = 2 and is_backup = 2 and t.perf_obj_type_code='1' and province=?");
        goalList.addAll(this.getDatas(PerfConstant.PMKPI_BACKUP_GOAL_INFO, wheresql.toString(), null, new String[]{province}));
        // 预处理：将 goalList 按 pro_code 分组
        Map<String, List<Map<String, Object>>> goalMap = goalList.stream().collect(Collectors.groupingBy(m -> (String) m.get("pro_code")));
        // 预处理：将 indexList 按 pro_code 分组
        Map<String, List<Map<String, Object>>> indexMap = indexList.stream().collect(Collectors.groupingBy(m -> (String) m.get("pro_code")));
        // 循环处理每个 procode
        //根据项目信息获取调整主单信息
        List<Map<String, Object>> addCaseList = new ArrayList<>();
        List<Map<String, Object>> addCaseGoalList = new ArrayList<>();
        List<Map<String, Object>> addCaseIndexList = new ArrayList<>();
        Map<String, Object> caseMap = null;
        Map<String, Object> caseGoalMap = null;
        Map<String, Object> caseIndexMap = null;
        for (String procode : proMap.keySet()) {
            List<Map<String, Object>> goalDatas = goalMap.getOrDefault(procode, Collections.emptyList());
            List<Map<String, Object>> indexDatas = indexMap.getOrDefault(procode, Collections.emptyList());
            if (!indexDatas.isEmpty()) {
                Map<String, Object> data = (Map<String, Object>) proMap.get(procode);
                caseMap = new HashMap<>();
                String guid = this.getCreateguid();
                String time = PerfUtil.getServerTimeStamp();
                String agencyguid = (String) data.get("agencyguid");
                agencyguid = agencyguid.substring(0, 3);
                String finintorgguid = (String) data.get("finintorgguid");
                caseMap.put("guid", guid);
                caseMap.put("bustype", "PM001");
                caseMap.put("is_deleted", 2);
                caseMap.put("createtime", time);
                caseMap.put("updatetime", time);
                caseMap.put("creater", creater);
                caseMap.put("province", province);
                caseMap.put("year", year);
                caseMap.put("code", procode);
                caseMap.put("name", data.get("pro_name"));
                caseMap.put("agencyguid", agencyguid);
                caseMap.put("finintorgguid", finintorgguid);
                caseMap.put("wfstatus", "011");
                caseMap.put("status", 1);
                caseMap.put("isadjust", "0");
                addCaseList.add(caseMap);
                if (!goalDatas.isEmpty()) {
                    caseGoalMap = new HashMap<>();
                    caseGoalMap.put("guid", this.getCreateguid());
                    caseGoalMap.put("createtime", time);
                    caseGoalMap.put("updatetime", time);
                    caseGoalMap.put("creater", creater);
                    caseGoalMap.put("province", province);
                    caseGoalMap.put("year", year);
                    caseGoalMap.put("mainguid", guid);
                    caseGoalMap.put("is_deleted", 2);
                    caseGoalMap.put("agencyguid", agencyguid);
                    caseGoalMap.put("finintorgguid", finintorgguid);
                    caseGoalMap.put("status", "1");
                    for (Map<String, Object> goal : goalDatas) {
                        String kpi_target = (String) goal.get("kpi_target");
                        if ("1".equals(goal.get("perf_obj_type_code"))) {
                            caseGoalMap.put("zqgoal", kpi_target);
                        } else {
                            caseGoalMap.put("ndgoal", kpi_target);
                        }
                    }
                    addCaseGoalList.add(caseGoalMap);
                }
                if (!indexDatas.isEmpty()) {
                    for (Map<String, Object> index : indexDatas) {
                        caseIndexMap = new HashMap<>();
                        caseIndexMap.putAll(index);
                        caseIndexMap.put("guid", this.getCreateguid());
                        caseIndexMap.put("createtime", time);
                        caseIndexMap.put("updatetime", time);
                        caseIndexMap.put("creater", creater);
                        caseIndexMap.put("province", province);
                        caseIndexMap.put("year", year);
                        caseIndexMap.put("status", "1");
                        caseIndexMap.put("mainguid", guid);
                        caseIndexMap.put("is_deleted", 2);
                        caseIndexMap.put("agencyguid", agencyguid);
                        caseIndexMap.put("finintorgguid", finintorgguid);
                        caseIndexMap.put("framesystem", "PM001");
                        caseIndexMap.put("indexvalue", index.get("kpi_val"));
                        addCaseIndexList.add(caseIndexMap);
                    }
                }
            }
        }
        //新增数据
        if (!addCaseList.isEmpty()) {
            midProgramAuditDAO.saveAll(addCaseList, CaseReportDAO.TABLECODE_T_CASE);
        }
        if (!addCaseGoalList.isEmpty()) {
            midProgramAuditDAO.saveAll(addCaseGoalList, CaseReportDAO.TABLECODE_T_CASEMODELGOAL);
        }
        if (!addCaseIndexList.isEmpty()) {
            midProgramAuditDAO.saveAll(addCaseIndexList, CaseReportDAO.TABLECODE_T_CASEMODELINDEX);
        }
        backMap.put("success", true);
        return backMap;
    }

}
