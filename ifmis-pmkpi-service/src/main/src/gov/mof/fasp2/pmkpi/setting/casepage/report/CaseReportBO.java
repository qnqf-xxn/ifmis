package gov.mof.fasp2.pmkpi.setting.casepage.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscommon.fileimport.fileimport.component.FileUploadService;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportErrorDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.datacommon.workflow.service.IWorkflowService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.setting.casepage.audit.CaseAuditBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CaseReportBO extends PmkpiBO {
    private CaseReportDAO caseReportDAO;

    public void setCaseReportDAO(CaseReportDAO caseReportDAO) {
        this.caseReportDAO = caseReportDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String nodeguid = (String)sqlmap.get("nodeguid"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String type = (String) sqlmap.get("type"); //项目调整选择项目
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String isCasetype = (String) sqlmap.get("isCasetype");
        String leftsource = (String) sqlmap.get("leftsource");
        StringBuffer returnsql = new StringBuffer();
        if (type != null && "check".equals(type)) {
            returnsql.append("select t.*,'' as upstatus from ").append(tablecode);
            returnsql.append(" t where t.wfstatus = '011' and t.status <> '3' and ");
        } else {
            returnsql.append("select t.* from ").append(tablecode).append(" t ");
            returnsql.append(" where ");
        }
        returnsql.append(" t.bustype='").append(lefttabtype).append("'");
        if (StringUtil.isEmpty(isCasetype)) {
            String columncode = "agencyguid";
            returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, nodeguid, caseReportDAO.PMKPI_TABLE_T_AGENCY));
        } else {
            if ("treeroot".equals(nodeguid)) {
                returnsql.append(" and exists(select 1 from v_perf_enum en where en.guid=t.casetype and en.elementcode='" + leftsource + "')");
            } else if ("1".equals(isleaf)) {
                returnsql.append(" and casetype='").append(nodeguid).append("'");
            } else if (!"treeroot".equals(nodeguid) && "0".equals(isleaf)) {
                List<Map<String,Object>> list = caseReportDAO.getCaseType(nodeguid, leftsource);
                StringBuffer caseguids = new StringBuffer();//调整前guid
                for (Map<String,Object> map : list) {
                    String caseguid = (String) map.get("guid");
                    caseguids.append("'").append(caseguid).append("',");
                }
                caseguids.deleteCharAt(caseguids.length() - 1);
                returnsql.append(" and casetype in(").append(caseguids.toString()).append(")");
            }
        }
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
            String wfsql = this.getWfSql(tabcode, workflow, "t");
            if (wfsql != null && !wfsql.isEmpty()) {
                returnsql.append(" and (").append(wfsql).append(") ");
            }
        }
        returnsql.append(datarule);
        return returnsql.toString();
    }

    /**
     * 获取数据源
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> getTreeData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        String leftmenuid = (String) params.get("leftmenuid");
        String leftsource = (String) params.get("leftsource");
        String datarule = "";
        if (caseReportDAO.CASETYEP_SOURCE.equals(leftsource)) {
            String upagency = SecureUtil.getCurrentUser().getUpagencyid();
            String agency = SecureUtil.getCurrentUser().getAgency();
            if (!StringUtil.isEmpty(upagency) && !upagency.equals(agency)){ //提级用户保存的是提级
                backMap.put("agencyguid", upagency);
            } else {
                backMap.put("agencyguid", agency);
            }
            backMap.put("finintorgguid", SecureUtil.getCurrentUser().getDivision());//处室
            backMap.put("isCasetype", "true");
        } else {
            datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        }
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> treeDatas = dss.getRangesByWhereSql(leftsource, datarule);
        backMap.put("treeDatas", treeDatas);
        return backMap;
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
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        String bustype = (String) params.get("bustype");
        CaseAuditBO caseAuditBO = (CaseAuditBO) PerfServiceFactory.getBean("pmkpi.casepage.audit.CaseAuditBOTX");
        //取消送审
        if ("cancelsendaudit".equals(actioncode)) {
            caseAuditBO.adjustBeforeDatas(datas, "cancel");
        }
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        //送审
        if ("sendaudit".equals(actioncode)) {
            caseAuditBO.basIndexData(datas, bustype);
            caseAuditBO.adjustBeforeDatas(datas, null);
        }
        return this.auditdefine(datas, busguid, "perf", null);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode = caseReportDAO.TABLECODE_T_CASE;
        String goaltablecode = caseReportDAO.TABLECODE_T_CASEMODELGOAL;
        String indextablecode = caseReportDAO.TABLECODE_T_CASEMODELINDEX;
        List<Map<String,Object>> dellist =  (List<Map<String,Object>>)parms.get("datas");
        try {
            if (dellist.size() > 0) {
                List<String> delguids = new ArrayList<>();
                StringBuffer adjustguids = new StringBuffer();//调整前guid
                for (Map<String,Object> map : dellist) {
                    delguids.add((String) map.get("guid"));
                    String adjustguid = (String) map.get("adjustguid");
                    if (!StringUtil.isEmpty(adjustguid)){
                        adjustguids.append("'").append(adjustguid).append("',");
                    }
                }
                if (adjustguids.length() > 0) {
                    adjustguids.deleteCharAt(adjustguids.length() - 1);
                    String wheresql = " set isadjust='0' where is_deleted = 2 and guid in(" + adjustguids.toString() + ") ";
                    caseReportDAO.updateDatas(caseReportDAO.TABLECODE_CASE, wheresql);
                }
                caseReportDAO.deleteAllByColumn("guid", delguids, tablecode);
                caseReportDAO.deleteAllByColumn("mainguid", delguids, goaltablecode);
                caseReportDAO.deleteAllByColumn("mainguid", delguids, indextablecode);
            }
            backMap.put("flg","1");
        }catch (AppException e){
            logger.error(e.getMessage());
            backMap.put("flg","2");
        }
        return backMap;
    }

    /**
     * 保存调整数据
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveAdjuctCase(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>>  datas = (List<Map<String, Object>>) params.get("datas");
        String tablecode = (String) params.get("tablecode");
        String workflow = (String)params.get("workflow");
        String bustype = (String) params.get("bustype");
        String goaltablecode = caseReportDAO.TABLECODE_T_CASEMODELGOAL;
        String indextablecode = caseReportDAO.TABLECODE_T_CASEMODELINDEX;
        if (datas != null && datas.size() >= 0) {
            //根据项目信息获取调整主单信息
            List<Map<String, Object>> adjustList = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> adjustGoalList = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> adjustIndexList = new ArrayList<Map<String, Object>>();
            Map<String, Object> adjustMap = null;
            Map<String, Object> adjustGoalMap = null;
            Map<String, Object> adjustIndexMap = null;
            caseReportDAO.saveAll(datas, caseReportDAO.PMKPI_TABLE_TMP_GUIDS);
            String wheresql = " exists(select 1 from " + caseReportDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.mainguid)";
            //查询案例目标
            List<Map<String, Object>> goalList = caseReportDAO.getDatas(goaltablecode, wheresql, null);
            //查询案例指标
            List<Map<String, Object>> indexList = caseReportDAO.getDatas(indextablecode, wheresql + " and nvl(t.status, 2) <> 3", null);
            String province = SecureUtil.getUserSelectProvince();
            String year = CommonUtil.getYear();
            String creater = SecureUtil.getCurrentUser().getGuid();
            for (Map<String, Object> map : datas) {
                String time = PerfUtil.getServerTimeStamp();
                adjustMap = new HashMap<String, Object>();
                String newguid = this.getCreateguid();
                String mainguid = (String) map.get("guid");
                adjustMap.put("guid", newguid);
                adjustMap.put("adjustguid", mainguid);
                adjustMap.put("bustype", bustype);
                adjustMap.put("is_deleted", 2);
                adjustMap.put("createtime", time);
                adjustMap.put("updatetime", time);
                adjustMap.put("creater", creater);
                adjustMap.put("province", province);
                adjustMap.put("year", year);
                adjustMap.put("status", map.get("upstatus"));
                adjustMap.put("casetype", map.get("casetype"));
                adjustMap.put("name", map.get("name"));
                adjustMap.put("describe", map.get("describe"));
                adjustMap.put("agencyguid", map.get("agencyguid"));
                adjustMap.put("finintorgguid", map.get("finintorgguid"));
                adjustMap.put("isadjust", "0");
                adjustList.add(adjustMap);
                map.put("isadjust", "1");
                if (goalList.size() > 0) {
                    for (Map<String, Object> goal : goalList) {
                        if (mainguid.equals(goal.get("mainguid"))) {
                            adjustGoalMap = new HashMap<String, Object>();
                            adjustGoalMap.putAll(goal);
                            adjustGoalMap.put("guid", this.getCreateguid());
                            adjustGoalMap.put("createtime", time);
                            adjustGoalMap.put("updatetime", time);
                            adjustGoalMap.put("creater", creater);
                            adjustGoalMap.put("province", province);
                            adjustGoalMap.put("year", year);
                            adjustGoalMap.put("mainguid", newguid);
                            adjustGoalList.add(adjustGoalMap);
                        }
                    }
                }
                if (indexList.size() > 0) {
                    for (Map<String, Object> index : indexList) {
                        if (mainguid.equals(index.get("mainguid"))) {
                            adjustIndexMap = new HashMap<String, Object>();
                            adjustIndexMap.putAll(index);
                            adjustIndexMap.put("adjustindexguid", index.get("guid"));
                            adjustIndexMap.put("guid", this.getCreateguid());
                            adjustIndexMap.put("createtime", time);
                            adjustIndexMap.put("updatetime", time);
                            adjustIndexMap.put("creater", creater);
                            adjustIndexMap.put("province", province);
                            adjustIndexMap.put("year", year);
                            adjustIndexMap.put("status", "");
                            adjustIndexMap.put("mainguid", newguid);
                            adjustIndexList.add(adjustIndexMap);
                        }
                    }
                }
            }
            //更新选中数据，标记为调整
            List<String> cols = new ArrayList<>();
            cols.add("isadjust");
            caseReportDAO.updateAll(cols, datas, tablecode);
            //新增数据
            this.workflow("create", workflow, "", tablecode, adjustList);
            caseReportDAO.saveAll(adjustGoalList, goaltablecode);
            caseReportDAO.saveAll(adjustIndexList, indextablecode);
        }
        return backMap;
    }

    public List impCaseIndex(ArrayList<Map<String, Object>> impDatas, ArrayList<Map<String, Object>> impCols,
                             String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        if (impDatas != null && impDatas.size() > 0) {
            Map<String, Object> caseMap = new HashMap<>();
            //校验数据
            String error = "";
            FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
            ImportErrorDTO dto = null;
            Pattern valpattern = Pattern.compile("[*_-]");
            if(PerfUtil.get_isCheckSpace()){
                valpattern = Pattern.compile("[ 　*_-]");
            }
            Pattern spacePattern = Pattern.compile("[ 　]"); // 匹配全角/半角空格
            Matcher matcher = null;
            for (Map<String, Object> data : impDatas) {
                Integer linenum = (Integer) data.get("linenum");
                String casename = (String) data.get("casename");
                String findex = (String) data.get("findex");
                String sindex = (String) data.get("sindex");
                String name = (String) data.get("name");
                String computesign = (String) data.get("computesign");
                String indexvalue = (String) data.get("indexvalue");
                caseMap.put(casename, new ArrayList<>());
                for (Map<String, Object> col : impCols) {
                    String columncode = (String) col.get("columncode");
                    String redden = (String) col.get("redden");
                    String showname = StringUtil.isEmpty((String) col.get("showname")) ? (String) col.get("name") : (String) col.get("showname");
                    columncode = columncode.toLowerCase();
                    String value = (String) data.get(columncode);
                    //标红，不能为空
                    if ("checked".equals(redden) && StringUtil.isEmpty(value)) {
                        error = showname + "必填！";
                        dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, error);
                        errordao.saveErrorMsg(dto);
                    }
                    if ("value_change".equals(columncode) && "2".equals(data.get(columncode)) && StringUtil.isEmpty(indexvalue)) {
                        error = showname + "选择“固定值”时，指标值必填！";
                        dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, error);
                        errordao.saveErrorMsg(dto);
                    }
                    if ("meterunit".equals(columncode) && StringUtil.isEmpty((String) data.get(columncode)) &&
                            ("1".equals(computesign) || "2".equals(computesign) || "3".equals(computesign) || "4".equals(computesign) || "5".equals(computesign))) {
                        error = "定量指标" + showname + "必填！";
                        dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, error);
                        errordao.saveErrorMsg(dto);
                    }
                }
                if (!StringUtil.isEmpty(findex) && !StringUtil.isEmpty(sindex)) {
                    sindex = sindex.substring(0, 1);
                }
                if (!findex.equals(sindex)) {
                    error = "一二级指标对应不上，请修改！";
                    dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, error);
                    errordao.saveErrorMsg(dto);
                }
                if (!StringUtil.isEmpty(name) && PerfUtil.get_isCheckSpace()) {
                    matcher = spacePattern.matcher(name);
                    if (matcher.find()) {
                        dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, "指标名称填写不支持空格，请重新填写 ");
                        errordao.saveErrorMsg(dto);
                    }
                    if ("null".equals(name)) {
                        dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, "指标名称填写不能为null，请重新填写 ");
                        errordao.saveErrorMsg(dto);
                    }
                    if ("NULL".equals(name)) {
                        dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, "指标名称填写不能为NULL，请重新填写 ");
                        errordao.saveErrorMsg(dto);
                    }
                }
                if (!StringUtil.isEmpty(indexvalue)) {
                    if ("1".equals(computesign) || "2".equals(computesign) || "3".equals(computesign) || "4".equals(computesign) || "5".equals(computesign)) {
                        if (!PerfUtil.isNumeric(indexvalue)){
                            error = "定量指标值只能填写数字！";
                            dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, error);
                            errordao.saveErrorMsg(dto);
                        }
                    }else{
                        matcher = valpattern.matcher(indexvalue);
                        if (matcher.find()) {
                            String msg = "定性指标值填写不支持特殊字符，请重新填写 ";
                            if(PerfUtil.get_isCheckSpace()){
                                msg = "定性指标值填写不支持特殊字符和空格，请重新填写 ";
                            }
                            dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, msg);
                            errordao.saveErrorMsg(dto);
                        }
                    }
                    if (PerfUtil.get_isCheckSpace() && "null".equals(indexvalue)) {
                        dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, "定性指标值填写不能为null，请重新填写 ");
                        errordao.saveErrorMsg(dto);
                    }
                    if (PerfUtil.get_isCheckSpace() && "NULL".equals(indexvalue)) {
                        dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, "定性指标值填写不能为NULL，请重新填写 ");
                        errordao.saveErrorMsg(dto);
                    }
                }
            }
            PmkpiDAO pmkpiDAO = PerfServiceFactory.getPmkpiDAO();
            if (errordao.haveUnsavedErrorMsg()) {
                throw new AppException("ANA-ERROR", "导入数据填写不规范");
            }
            CaseReportBO caseReportBO = (CaseReportBO) PerfServiceFactory.getBean("pmkpi.casepage.report.CaseReportBOTX");
            //查询填报且未删除状态的案例
            String workflow = (String) busParams.get("workflow");
            String lefttabtype = (String) busParams.get("lefttabtype");
            IWorkflowService workflowService = (IWorkflowService) ServiceFactory.getBean("datacommon.wf.WorkflowService");
            List<String> wfids = new ArrayList<String>();
            wfids.add(workflow);
            String wfsql = workflowService.getWFSqlByWfIds(wfids);
            String wheresql = pmkpiDAO.createInSql("name", caseMap.keySet());
            wheresql += " and status <> '3' and " + wfsql;
            List<Map<String, Object>> caseList = pmkpiDAO.getDatas("v_perf_t_case", wheresql, null);
            if (caseList.size() > 0) {
                List<Map<String, Object>> saveIndexList = new ArrayList<>();
                List<Map<String, Object>> saveGoalList = new ArrayList<>();
                Map<String, Object> goalMap = null;
                List<String> caseGuids = new ArrayList<>();
                //根据查询到符合规则案例，处理导入的数据
                for (Map<String, Object> caseData : caseList) {
                    goalMap = new HashMap<>();
                    String name = (String) caseData.get("name");
                    String agencyguid = (String) caseData.get("agencyguid");
                    String mainguid = (String) caseData.get("guid");
                    for (Map<String, Object> impData : impDatas) {
                        String casename = (String) impData.get("casename");
                        String aguid = (String) impData.get("agencyguid");
                        //导入案例名称、单位编码和库里案例的名称、单位编码一直，才能入库
                        if (casename.equals(name) && aguid.equals(agencyguid)) {
                            //导入目标只取有数据的
                            String zqgoal = (String) impData.get("zqgoal");
                            String ndgoal = (String) impData.get("ndgoal");
                            if (!StringUtil.isEmpty(zqgoal)) {
                                goalMap.put("zqgoal", zqgoal);
                            }
                            if (!StringUtil.isEmpty(ndgoal)) {
                                goalMap.put("ndgoal", ndgoal);
                            }
                            this.setImpData(impData, caseData, lefttabtype);
                            saveIndexList.add(impData);
                        }
                    }
                    //年度或中期不为空是，保存起来
                    if (!StringUtil.isEmpty((String) goalMap.get("zqgoal")) || !StringUtil.isEmpty((String) goalMap.get("ndgoal"))) {
                        this.setImpData(goalMap, caseData, lefttabtype);
                        saveGoalList.add(goalMap);
                        caseGuids.add(mainguid);
                    }
                }
                if (saveIndexList.size() > 0) {
                    caseReportBO.setIndexCode(saveIndexList);
                    pmkpiDAO.saveAll(saveIndexList, "v_perf_t_casemodelindex");
                }
                if (saveGoalList.size() > 0) {
                    pmkpiDAO.delDatas("v_perf_t_casemodelgoal", pmkpiDAO.createInSql("mainguid", caseGuids));
                    pmkpiDAO.saveAll(saveGoalList, "v_perf_t_casemodelgoal");
                }
            }
        }
        return null;
    }

    /**
     * 导入数据赋值
     * @param dataMap --导入数据
     * @param mainMap --案例数据
     * @param lefttabtype --导入类型，项目支出、部门整体
     */
    private void setImpData(Map<String, Object> dataMap, Map<String, Object> mainMap, String lefttabtype){
        String mainguid = (String) mainMap.get("guid");
        String agencyguid = (String) mainMap.get("agencyguid");
        String finintorgguid = (String) mainMap.get("finintorgguid");
        dataMap.put("guid", CommonUtil.createGUID());
        dataMap.put("year", SecureUtil.getUserSelectYear());
        dataMap.put("province", SecureUtil.getUserSelectProvince());
        dataMap.put("createtime", PerfUtil.getServerTimeStamp());
        dataMap.put("updatetime", PerfUtil.getServerTimeStamp());
        dataMap.put("creater", SecureUtil.getCurrentUserID());
        dataMap.put("mainguid", mainguid);
        dataMap.put("agencyguid", agencyguid);
        dataMap.put("is_deleted", 2);
        dataMap.put("status", 1);
        dataMap.put("finintorgguid", finintorgguid);
        if ("DEPT".equals(lefttabtype)) {
            dataMap.put("framesystem", "DEPT");
        } else {
            dataMap.put("framesystem", "PM001");
        }
    }

}
