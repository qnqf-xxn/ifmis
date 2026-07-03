package gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.apiInterface.dto.*;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.evaluation.financial.result.ResultBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class ProConfirmBO extends PmkpiBO {
    private ProConfirmDAO proConfirmDAO;

    public void setProConfirmDAO(ProConfirmDAO proConfirmDAO) {
        this.proConfirmDAO = proConfirmDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        //String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String defquery = (String) sqlmap.get("defquery"); //表格配置的sql
        String prowheresql = (String) sqlmap.get("prowheresql"); //选择项目过滤条件
        //String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String type = (String) sqlmap.get("type"); //项目调整选择项目
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String columncode = "agencyguid";
        StringBuffer returnsql = new StringBuffer();
        if (type != null && "check".equals(type)) {
            saveAgency = "treeroot";
            if (lefttabtype != null && "program".equals(lefttabtype)) {
                returnsql.append("select t.* from ").append(proConfirmDAO.PMKPI_TABLE_SELFPROJECT_CHECK);
                returnsql.append(" t where ");
                if (StringUtils.isEmpty(prowheresql)){
                    returnsql.append(prowheresql).append(" and ");
                }
            } else {
                returnsql.append("select t.* from ").append(tablecode);
                returnsql.append(" t where ");
            }
            returnsql.append(" not exists(select 1 from ").append(proConfirmDAO.PERF_TABLE_PROCONFIRM).append(" a where ");
            if (PerfUtil.getIsHbei() || "dept".equals(lefttabtype)){
                returnsql.append(" a.proguid=t.guid ");
            }else{
                returnsql.append(" a.code=t.pro_code ");  //根据项目编码查询项目信息
            }
            returnsql.append(" and a.wfstatus<>'011')");
        } else {
            returnsql.append("select t.* from ").append(proConfirmDAO.PERF_TABLE_PROCONFIRM).append(" t where t.bustype='").append(lefttabtype).append("' ");
        }
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (!StringUtils.isEmpty(wheresql)){
            returnsql.append(" and ").append(wheresql);
        }
        if (!StringUtils.isEmpty(tablesql)){
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtils.isEmpty(tabfilter)){
            returnsql.append(" and ").append(tabfilter);
        }
        if (!StringUtils.isEmpty(defquery)){
            returnsql.append(" and ").append(defquery);
        }
        if (StringUtils.isEmpty(type)) {
            String wfsql = this.getWfSql(tabcode, workflow);
            if (!StringUtils.isEmpty(wfsql)) {
                returnsql.append(" and (").append(wfsql).append(") ");
            }
        }
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, proConfirmDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        return returnsql.toString();
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode="v_perf_t_finevaluation";
        String bustype = (String) params.get("bustype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype='" + bustype + "' ";
        return proConfirmDAO.getLeftTree(tablecode, datarule);
    }

    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, proConfirmDAO.PERF_TABLE_PROCONFIRM, datas);
        //处理规范表数据
        ResultBO resultBO = (ResultBO) PerfServiceFactory.getBean("pmkpi.evaluation.financial.ResultBOTX");
        resultBO.updateDeptEvalTabelDatas(datas, actioncode);
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 保存调整数据
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveProgramProConfirm(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>>  datas = (List<Map<String, Object>>) params.get("datas");
        String tablecode = proConfirmDAO.PERF_TABLE_PROCONFIRM;
        String workflow = (String)params.get("workflow");
        String bustype = (String) params.get("bustype");
        String isZJ = PerfUtil.getSystemSet("isZJ");
        Boolean isNINGXIA = PerfUtil.getIsNINGXIA();
        if (datas != null && datas.size() >= 0) {
            List<Map<String, Object>> adjustList = new ArrayList<Map<String, Object>>();
            Map<String, Object> proconfirmMap = null;
            for (Map<String, Object> map : datas) {
                String agencyguid = (String) map.get("agencyguid");
                proconfirmMap = new HashMap<String, Object>();
                String guid = this.getCreateguid();
                proconfirmMap.put("proguid", map.get("guid"));
                proconfirmMap.put("guid", guid);
                proconfirmMap.put("createtime", StringUtil.getSysDBDate());
                proconfirmMap.put("updatetime", StringUtil.getSysDBDate());
                proconfirmMap.put("creater", SecureUtil.getCurrentUser().getGuid());
                proconfirmMap.put("province", SecureUtil.getUserSelectProvince());
                proconfirmMap.put("year", CommonUtil.getYear());
                proconfirmMap.put("wfid", workflow);
                proconfirmMap.put("isrelease", 2);
                if (bustype != null && "program".equals(bustype)) {
                    String proCode = (String)map.get("pro_code");
                    proconfirmMap.put("code", map.get("pro_code"));
                    proconfirmMap.put("pro_code", proCode);
                    proconfirmMap.put("name", map.get("pro_name"));
                    if (!"1".equals(isZJ)){//财政评价项目确定-选择项目，当是浙江时FININTORGGUID不存入值
                        proconfirmMap.put("finintorgguid", map.get("mof_dep_code"));
                    }
                    proconfirmMap.put("agencyguid", agencyguid);
                    proconfirmMap.put("manage_dept_code",map.get("manage_dept_code"));
                    proconfirmMap.put("manage_mof_dep_code",map.get("manage_mof_dep_code"));
                    proconfirmMap.put("mof_dep_code",map.get("mof_dep_code"));
                    proconfirmMap.put("dept_code",map.get("dept_code"));

                    String startYearStr = map.get("pro_start_year") == null ? "0" : (String) map.get("pro_start_year");
                    String proTermStr = map.get("pro_term") == null ? "0" : (String) map.get("pro_term");
                    Integer endtime = Integer.valueOf(startYearStr) + Integer.valueOf(proTermStr) - 1;
                    if (endtime > 0) {
                        proconfirmMap.put("endtime", endtime + "1231");   //截止日期：公式=开始时间+项目期限(pro_start_year + pro_term - 1)
                    }
                    proconfirmMap.put("pro_start_year", startYearStr + "0101"); //开始日期：取开始时间字段(pro_start_year)
                    proconfirmMap.put("leader_name", map.get("leader_name")); //项目负责人：取负责人名称字段(leader_name)
                    proconfirmMap.put("projectcon", map.get("leader_tel")); //项目负责人：取负责人电话字段(leader_tel)
                    proconfirmMap.put("pro_total_amt", map.get("pro_total_amt")); //项目总金额：取项目总额字段(pro_total_amt)
                    proconfirmMap.put("projamt", this.getProjAmt(proCode)); //当年预算金额
                    if(isNINGXIA){
                        proconfirmMap.put("eval_amt",map.get("pro_total_amt")); // 评价期资金
                        proconfirmMap.put("year",CommonUtil.getYear()); // 评价年度，默认登录年度
                        proconfirmMap.put("agencyguid", map.get("dept_code")); // 宁夏选择项目预算单位给部门值
                    }
                } else {
                    proconfirmMap.put("code", map.get("code"));
                    proconfirmMap.put("name", map.get("name"));
                    proconfirmMap.put("finintorgguid", map.get("finintorgguid"));
                    proconfirmMap.put("agencyguid", agencyguid);
                }
                proconfirmMap.put("bustype", bustype);
                proconfirmMap.put("isadd", 0);  //是否财政评价新增项目 1：是   0：否
                adjustList.add(proconfirmMap);
            }
            this.workflow("create", workflow, "", tablecode, adjustList);
        }
        return backMap;
    }

    /**
     * 删除
     *
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("data");
        String tablecode = proConfirmDAO.PERF_TABLE_PROCONFIRM;
        List<String> deltables = (List<String>) parms.get("deltables");
        List<String> delcols = (List<String>) parms.get("delcols");
        try {
            proConfirmDAO.saveAll(deldatas, proConfirmDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + proConfirmDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            proConfirmDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + proConfirmDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    proConfirmDAO.delDatas(deltable, delsql);
                }
            }
            backMap.put("flg", "1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    public List<FineEvalInfo> getFineEvalResult(PerfQueryRequest request) {
        String province = request.getProvince();
        String year = request.getYear();
        List<FineEvalInfo> result = new ArrayList<>();
        List<String> maingList = new ArrayList<>();
        List<String> procodeList = new ArrayList<>();
        List<String> maingMonList = new ArrayList<>();
        List<String> maingSelfList = new ArrayList<>();

        List<Map<String, Object>> bgtFundList = new ArrayList<>();
        List<Map<String, Object>> indexTraceList = new ArrayList<>();
        List<Map<String, Object>> proFineEvalProjectList = new ArrayList<>();
        List<Map<String, Object>> proPerfMonitorInfoList = new ArrayList<>();
        List<Map<String, Object>> proSelfEvalList = new ArrayList<>();
        List<Map<String, Object>> proSelfBudgetList = new ArrayList<>();
        List<Map<String, Object>> proSelfIndexList = new ArrayList<>();

        // 1. 查询财政评价主表数据
        String sql1 = "select t.*,t1.ele_name as agency_name from "+proConfirmDAO.PERF_TABLE_T_FINEVALUATION+" t" +
                " left join ELE_VD00010 t1 on t.year = t1.fiscal_year and t.province = t1.mof_div_code and t.agencyguid = t1.ele_code" +
                " where t.bustype='program' " +
                // " and t.wfstatus = '011'" +
                " and t.year = '"+year+"' and t.province = '"+province+"'" ;
        List<Map<String, Object>> datas = proConfirmDAO.queryForList(sql1);
        for (Map<String, Object> data : datas) {
            maingList.add((String) data.get("guid"));
        }
        if(maingList.size() > 0){
            // 2. 查询财政评价关联项目明细
            String sql2 = proConfirmDAO.createInSql("mainguid",maingList);
            // sql2 += " and t.wfstatus = '011' ";
            sql2 += " and t.year = '" + year + "' and t.province = '" + province + "' ";
            String tablecode1 = "(select t1.*,t2.ele_name as agency_name from "+proConfirmDAO.PERF_TABLE_T_FINEVARELATION+" t1" +
                    " left join ELE_VD00010 t2 on t1.year = t2.fiscal_year and t1.province = t2.mof_div_code and t1.agencyguid = t2.ele_code)";
            proFineEvalProjectList = proConfirmDAO.getDatas(tablecode1, sql2, "");
            for (Map<String, Object> data : proFineEvalProjectList) {
                procodeList.add((String) data.get("pro_code"));
            }
            if(!procodeList.isEmpty()){
                // 3. 查询关联项目的监控信息（可能有多个监控阶段）
                String sql3 = proConfirmDAO.createInSql("pro_code",procodeList);
                        sql3 += " and t.year = '" + year + "' and t.province = '" + province + "' ";
                String tablecode2 = "(select t1.*,t2.ele_name as agency_name,b.taskstage from "+proConfirmDAO.PERF_TABLE_PROMONITOR+" t1" +
                        " left join ELE_VD00010 t2 on t1.year = t2.fiscal_year and t1.province = t2.mof_div_code and t1.agencyguid = t2.ele_code" +
                        " left join perf_t_taskset b on b.guid = t1.taskguid" +
                        " where t1.PROVINCETASK = '1' and t1.is_deleted = '2' and t1.wfstatus = '011')" ;
                proPerfMonitorInfoList = proConfirmDAO.getDatas(tablecode2, sql3, "");
                for (Map<String, Object> data : proPerfMonitorInfoList) {
                    maingMonList.add((String) data.get("guid"));
                }
                if(!maingMonList.isEmpty()){
                    // 4. 查询监控预算执行情况
                    String sql4 = proConfirmDAO.createInSql("mainguid",maingMonList);
                    sql4 += " and t.year = '" + year + "' and t.province = '" + province + "' ";
                    bgtFundList = proConfirmDAO.getDatas(proConfirmDAO.PERF_TABLE_T_PROBGTFUND, sql4, "");
                    // 5. 查询监控指标
                    String sql5 = proConfirmDAO.createInSql("mainguid",maingMonList);
                    sql5 += " and t.is_deleted = '2' and t.year = '" + year + "' and t.province = '" + province + "' ";
                    String tablecode3 = "(select t1.*,t2.ele_name as findex_name,t3.ele_name as sindex_name,t4.name as computesign_name from " + proConfirmDAO.PERF_TABLE_PROINDEXTRACE + " t1" +
                            " left join PERF_T_FRAME t2 on t2.frametype = 'PM001' and t2.ele_code = t1.findex and t2.year = t1.year and t2.province = t1.province" +
                            " left join PERF_T_FRAME t3 on t3.frametype = 'PM001' and t3.ele_code = t1.sindex and t3.year = t1.year and t3.province = t1.province" +
                            " left join PERF_ENUM T4 on t4.ELEMENTCODE = 'PMKPIZBXS' and t4.code = t1.COMPUTESIGN and t4.year = t1.year and t4.province = t1.province)";
                    indexTraceList = proConfirmDAO.getDatas(tablecode3, sql5, "");
                }
                // 6. 查询自评信息
                String sql6 = proConfirmDAO.createInSql("pro_code",procodeList);
                String tablecode4 = "(select t1.*,t2.ele_name as agency_name,t3.yeargoal,t3.allyeargoal from "+proConfirmDAO.PERF_TABLE_T_SELFEVALTASK+" t1" +
                        " left join ELE_VD00010 t2 on t1.year = t2.fiscal_year and t1.province = t2.mof_div_code and t1.agencyguid = t2.ele_code" +
                        " left join PERF_T_SELFPERFDESC t3 on t3.mainguid = t1.guid and t3.year = '"+year+"' and t3.province = '"+province+"' " +
                        " where t1.is_deleted = '2' and t1.wfstatus = '011'" +
                        " and t1.year = '"+year+"' and t1.province = '"+province+"')";
                proSelfEvalList = proConfirmDAO.getDatas(tablecode4, sql6, "");
                for (Map<String, Object> data : proSelfEvalList) {
                    maingSelfList.add((String) data.get("guid"));
                }
                if(!maingSelfList.isEmpty()){
                    // 7. 查询自评预算执行情况
                    String sql7 = proConfirmDAO.createInSql("mainguid",maingSelfList);
                    sql7 += " and t.year = '" + year + "' and t.province = '" + province + "'";
                    proSelfBudgetList = proConfirmDAO.getDatas(proConfirmDAO.PERF_TABLE_T_SELFPROFUND, sql7, "");
                    // 8. 查询自评指标完成情况
                    String sql8 = proConfirmDAO.createInSql("mainguid",maingSelfList);
                    String tablecode5 = "(select t1.*,t2.ele_name as findex_name,t3.ele_name as sindex_name,t4.name as computesign_name from " + proConfirmDAO.PERF_TABLE_T_SELFPERFINDEX + " t1" +
                            " left join PERF_T_FRAME t2 on t2.frametype = 'PM001' and t2.ele_code = t1.findex and t2.year = t1.year and t2.province = t1.province" +
                            " left join PERF_T_FRAME t3 on t3.frametype = 'PM001' and t3.ele_code = t1.sindex and t3.year = t1.year and t3.province = t1.province" +
                            " left join PERF_ENUM T4 on t4.ELEMENTCODE = 'PMKPIZBXS' and t4.code = t1.COMPUTESIGN and t4.year = t1.year and t4.province = t1.province" +
                            " where t1.is_deleted = '2' and t1.year = '" + year + "' and t1.province = '" + province + "')";
                    proSelfIndexList = proConfirmDAO.getDatas(tablecode5, sql8, "");
                }
            }
        }
        // 1. 组装财政评价主表数据
        for (Map<String, Object> fineEvalMainMap : datas) {
            FineEvalInfo info = new FineEvalInfo();
            String guid = (String) fineEvalMainMap.get("guid");
            info.setGuid(guid);
            info.setProCode((String) fineEvalMainMap.get("code"));
            info.setProName((String) fineEvalMainMap.get("name"));
            info.setAgencyCode((String) fineEvalMainMap.get("agencyguid"));
            info.setAgencyName((String) fineEvalMainMap.get("agency_name"));
            info.setCreateTime((String) fineEvalMainMap.get("createtime"));
            info.setUpdateTime((String) fineEvalMainMap.get("updatetime"));
            // 2. 组装财政评价关联项目明细
            List<Map<String, Object>> fineEvalProjectList = proFineEvalProjectList.stream()
                    .filter(map -> {
                        String mainGuid = (String) map.get("mainguid");
                        return mainGuid != null && guid.equals(mainGuid);
                    })
                    .collect(Collectors.toList());
            if(!fineEvalProjectList.isEmpty()){
                List<FineEvalProject> projectList = new ArrayList<>();
                for (Map<String, Object> projectMap : fineEvalProjectList) {
                    FineEvalProject project = new FineEvalProject();
                    project.setMainguid((String) projectMap.get("mainguid"));
                    project.setProCode((String) projectMap.get("pro_code"));
                    project.setProName((String) projectMap.get("pro_name"));
                    project.setAgencyCode((String) projectMap.get("agency_code"));
                    project.setAgencyName((String) projectMap.get("agency_name"));
                    String pro_code = (String) projectMap.get("pro_code");
                    // 3. 组装关联项目的监控信息（可能有多个监控阶段）
                    List<Map<String, Object>> perfMonitorInfoList = proPerfMonitorInfoList.stream()
                            .filter(map -> {
                                String proCode = (String) map.get("pro_code");
                                return proCode != null && pro_code != null && pro_code.equals(proCode);
                            })
                            .collect(Collectors.toList());
                    if(!perfMonitorInfoList.isEmpty()){
                        List<PerfMonitorInfo> traceInfoList = new ArrayList<>();
                        for (Map<String, Object> perfMonitorInfoMap : perfMonitorInfoList) {
                            PerfMonitorInfo traceInfo  = new PerfMonitorInfo();
                            String guidMon = (String) perfMonitorInfoMap.get("guid");
                            traceInfo.setGuid(guidMon);
                            traceInfo.setProCode((String) perfMonitorInfoMap.get("pro_code"));
                            traceInfo.setProName((String) perfMonitorInfoMap.get("name"));
                            traceInfo.setAgencyCode((String) perfMonitorInfoMap.get("agency_code"));
                            traceInfo.setAgencyName((String) perfMonitorInfoMap.get("agency_name"));
                            traceInfo.setTaskstage((String) perfMonitorInfoMap.get("taskstage"));
                            traceInfo.setYeargoaltion((String) perfMonitorInfoMap.get("yeargoal"));
                            traceInfo.setYeargoalExecution((String) perfMonitorInfoMap.get("yeargoal_execution"));
                            traceInfo.setCreateTime((String) perfMonitorInfoMap.get("create_time"));
                            traceInfo.setUpdateTime((String) perfMonitorInfoMap.get("update_time"));
                            traceInfo.setProTotalAmt((BigDecimal) perfMonitorInfoMap.get("pro_total_amt"));
                            // 4. 组装监控预算执行情况
                            List<Map<String, Object>> proBgtFundList = bgtFundList.stream()
                                    .filter(map -> {
                                        String mainGuid = (String) map.get("mainguid");
                                        return mainGuid != null && guidMon.equals(mainGuid);
                                    })
                                    .collect(Collectors.toList());
                            if(!proBgtFundList.isEmpty()){
                                List<BudgetExecutionTrace> bgtList = new ArrayList<>();
                                for (Map<String, Object> proBgtFundMap : proBgtFundList) {
                                    BudgetExecutionTrace bgt = new BudgetExecutionTrace();
                                    bgt.setMainguid((String) proBgtFundMap.get("mainguid"));
                                    bgt.setName((String) proBgtFundMap.get("name"));
                                    bgt.setAmt1((BigDecimal) proBgtFundMap.get("amt1"));
                                    bgt.setAmt2((BigDecimal) proBgtFundMap.get("amt2"));
                                    bgt.setAmt3((BigDecimal) proBgtFundMap.get("amt3"));
                                    bgt.setAmt4((BigDecimal) proBgtFundMap.get("amt4"));
                                    bgt.setAmt6((BigDecimal) proBgtFundMap.get("amt6"));
                                    BigDecimal bgtget = null;
                                    String bgtgetStr = (String) proBgtFundMap.get("bgtget");
                                    if (bgtgetStr != null) {
                                        bgtget = new BigDecimal(bgtgetStr);
                                    } else {
                                        bgtget = BigDecimal.ZERO;
                                    }
                                    bgt.setBgtget(bgtget);
                                    bgtList.add(bgt);
                                }
                                traceInfo.setProtracebgtlist(bgtList);
                            }
                            // 5. 组装监控指标完成情况
                            List<Map<String, Object>> proIndexTraceList = indexTraceList.stream()
                                    .filter(map -> {
                                        String mainGuid = (String) map.get("mainguid");
                                        return mainGuid != null && guidMon.equals(mainGuid);
                                    })
                                    .collect(Collectors.toList());
                            if(!proIndexTraceList.isEmpty()){
                                List<MonitorIndex> indexList = new ArrayList<>();
                                for (Map<String, Object> proIndexTraceMap : proIndexTraceList) {
                                    MonitorIndex idx = new MonitorIndex();
                                    idx.setMainguid((String) proIndexTraceMap.get("mainguid"));
                                    idx.setFindexName((String) proIndexTraceMap.get("findex_name"));
                                    idx.setSindexName((String) proIndexTraceMap.get("sindex_name"));
                                    idx.setIndiName((String) proIndexTraceMap.get("name"));
                                    idx.setComputesign((String) proIndexTraceMap.get("computesign_name"));
                                    idx.setMeterunit((String) proIndexTraceMap.get("meterunit"));
                                    idx.setTargetvalue((String) proIndexTraceMap.get("targetvalue"));
                                    idx.setIndexval((String) proIndexTraceMap.get("indexval"));
                                    idx.setCompleteanalysis((String) proIndexTraceMap.get("completeanalysis"));
                                    idx.setCompleteanalyscon((String) proIndexTraceMap.get("completeanalyscon"));
                                    idx.setDeviationanalysis((String) proIndexTraceMap.get("deviationanalysis"));
                                    idx.setWarn((String) proIndexTraceMap.get("warn"));
                                    idx.setRemark((String) proIndexTraceMap.get("remark"));
                                    indexList.add(idx);
                                }
                                traceInfo.setProtraceindexlist(indexList);
                                traceInfoList.add(traceInfo);
                            }
                        }
                        project.setProtraceinfolist(traceInfoList);
                    }

                    // 6. 组装自评信息
                    List<Map<String, Object>> selfEvalList = proSelfEvalList.stream()
                            .filter(map -> {
                                String proCode = (String) map.get("code");
                                return proCode != null && pro_code != null && pro_code.equals(proCode);
                            })
                            .collect(Collectors.toList());

                    if (!selfEvalList.isEmpty()) {
                        Map<String, Object> selfEvalMap = selfEvalList.get(0);
                        SelfEvalInfo selfEval = new SelfEvalInfo();
                        String guidSelf = (String) selfEvalMap.get("guid");
                        selfEval.setGuid(guidSelf);
                        selfEval.setProCode((String) selfEvalMap.get("code"));
                        selfEval.setProName((String) selfEvalMap.get("name"));
                        selfEval.setAgencyCode((String) selfEvalMap.get("agencyguid"));
                        selfEval.setAgencyName((String) selfEvalMap.get("agency_name"));
                        selfEval.setYeargoaltion((String) selfEvalMap.get("yeargoal"));
                        selfEval.setYeargoalExecution((String) selfEvalMap.get("allyeargoal"));

                        // 7. 组装自评预算执行情况
                        List<Map<String, Object>> selfBudgetList = proSelfBudgetList.stream()
                                .filter(map -> {
                                    String mainGuid = (String) map.get("mainguid");
                                    return mainGuid != null && guidSelf.equals(mainGuid);
                                })
                                .collect(Collectors.toList());
                        if(!selfBudgetList.isEmpty()){
                            List<BudgetExecutionSelf> selfBgtList = new ArrayList<>();
                            for (Map<String, Object> selfBudgetMap : selfBudgetList) {
                                BudgetExecutionSelf selfBgt = new BudgetExecutionSelf();
                                selfBgt.setMainguid((String) selfBudgetMap.get("mainguid"));
                                selfBgt.setName((String) selfBudgetMap.get("name"));
                                selfBgt.setAmt1((BigDecimal) selfBudgetMap.get("amt1"));
                                selfBgt.setAmt2((BigDecimal) selfBudgetMap.get("amt2"));
                                selfBgt.setAmt3((BigDecimal) selfBudgetMap.get("amt3"));
                                selfBgt.setAmt4((BigDecimal) selfBudgetMap.get("amt4"));

                                BigDecimal bgtget = null;
                                String bgtgetStr = (String) selfBudgetMap.get("bgtget");
                                if (bgtgetStr != null) {
                                    bgtget = new BigDecimal(bgtgetStr);
                                } else {
                                    bgtget = BigDecimal.ZERO;
                                }
                                selfBgt.setBgtget(bgtget);

                                BigDecimal score = null;
                                String scoreStr = (String) selfBudgetMap.get("score");
                                if (scoreStr != null) {
                                    score = new BigDecimal(scoreStr);
                                } else {
                                    score = BigDecimal.ZERO;
                                }
                                selfBgt.setScore(score);
                                selfBgtList.add(selfBgt);
                            }
                            selfEval.setProselfevalbgtlist(selfBgtList);
                        }

                        // 8. 组装自评指标完成情况
                        List<Map<String, Object>> selfIndexList = proSelfIndexList.stream()
                                .filter(map -> {
                                    String mainGuid = (String) map.get("mainguid");
                                    return mainGuid != null && guidSelf.equals(mainGuid);
                                })
                                .collect(Collectors.toList());
                        if(!selfIndexList.isEmpty()){
                            List<SelfEvalIndex> selfEvalIndexList = new ArrayList<>();
                            for (Map<String, Object> selfIndexMap : selfIndexList) {
                                SelfEvalIndex selfIdx = new SelfEvalIndex();
                                selfIdx.setMainguid((String) selfIndexMap.get("mainguid"));
                                selfIdx.setFindexName((String) selfIndexMap.get("findex_name"));
                                selfIdx.setSindexName((String) selfIndexMap.get("sindex_name"));
                                selfIdx.setIndiName((String) selfIndexMap.get("name"));
                                selfIdx.setComputesign((String) selfIndexMap.get("computesign"));
                                selfIdx.setMeterunit((String) selfIndexMap.get("meterunit"));
                                selfIdx.setIndexval((String) selfIndexMap.get("indexval"));
                                selfIdx.setActualvalue((String) selfIndexMap.get("actualvalue"));
                                selfIdx.setActualweight((BigDecimal) selfIndexMap.get("actualweight"));
                                selfIdx.setScore((BigDecimal) selfIndexMap.get("score"));
                                selfIdx.setKpiRemark((String) selfIndexMap.get("kpi_remark"));
                                selfIdx.setIndRemark((String) selfIndexMap.get("ind_remark"));
                                selfEvalIndexList.add(selfIdx);
                            }
                            selfEval.setProselfevalindexlist(selfEvalIndexList);
                            project.setSelfEvalInfo(selfEval);
                        }
                    }
                    projectList.add(project);
                }
                info.setFinevalprolist(projectList);
            }
            result.add(info);
        }
        return result;
    }
}
