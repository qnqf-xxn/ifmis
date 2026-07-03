package gov.mof.fasp2.pmkpi.evaluation.dept.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscommon.fileimport.fileimport.component.FileUploadService;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportErrorDTO;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.evaluation.dept.audit.DeptAuditBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptReportBO extends PmkpiBO {
    private DeptReportDAO deptReportDAO;

    public void setDeptReportDAO(DeptReportDAO deptReportDAO) {
        this.deptReportDAO = deptReportDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String) sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String) sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String type = (String) sqlmap.get("type"); //选择项目
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String queryview = (String) sqlmap.get("queryview");
        String columncode = "agencyguid";
        StringBuffer returnsql = new StringBuffer();
        if (type != null && "check".equals(type)) {
            if (lefttabtype != null && "program".equals(lefttabtype)){
                tablecode = deptReportDAO.PMKPI_TABLE_SELFPROJECT_CHECK;
            }
            returnsql.append("select t.* from ").append(tablecode);
            if (lefttabtype != null && "program".equals(lefttabtype)) {
                returnsql.append(" t where wfstatus = '011' and ");
            } else {
                returnsql.append(" t where ");
            }
            returnsql.append(" not exists(select 1 from ").append(deptReportDAO.PERF_TABLE_DEPTEVAL).append(" a where ");
            if ("dept".equals(lefttabtype) || PerfUtil.getIsHbei()) {
                returnsql.append(" a.proguid=t.guid ");
            } else {
                returnsql.append(" a.code=t.pro_code ");  //根据项目编码查询项目信息
            }
            returnsql.append(" and a.wfstatus<>'011')");
        } else if(!StringUtil.isEmpty(queryview)){
            returnsql.append("select t.* from ").append(queryview).append(" t ");
        } else {
            returnsql.append("select t.* from ").append(deptReportDAO.PERF_TABLE_DEPTEVAL).append(" t where t.bustype='").append(lefttabtype).append("' ");
        }
        String datarule =  this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (!StringUtils.isEmpty(wheresql)) {
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (!StringUtils.isEmpty(tablesql)) {
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtils.isEmpty(tabfilter)) {
            returnsql.append(" and ").append(tabfilter);
        }
        if(StringUtil.isEmpty(queryview)) {
            if (StringUtils.isEmpty(type)) {
                String wfsql = this.getWfSql(tabcode, workflow);
                if (!StringUtils.isEmpty(wfsql)) {
                    returnsql.append(" and (").append(wfsql).append(") ");
                }
            }
            returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, deptReportDAO.PMKPI_TABLE_T_AGENCY));
            returnsql.append(datarule);
        }
        return returnsql.toString();
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode="v_perf_t_deptevaluation";
        String bustype = (String) params.get("bustype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype='" + bustype + "' ";
        return deptReportDAO.getLeftTree(tablecode, datarule);
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
        this.workflow(actioncode, workflow, remark, deptReportDAO.PERF_TABLE_DEPTEVAL, datas);
        //处理规范表数据
        DeptAuditBO deptAuditBO = (DeptAuditBO) ServiceFactory.getBean("pmkpi.evaluation.dept.audit.DeptAuditBOTX");
        deptAuditBO.updateDeptEvalTabelDatas(datas, actioncode);
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 保存调整数据
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveProgram(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>>  datas = (List<Map<String, Object>>) params.get("datas");
        String tablecode = deptReportDAO.PERF_TABLE_DEPTEVAL;
        String workflow = (String)params.get("workflow");
        String bustype = (String) params.get("bustype");
        Boolean isNINGXIA = (Boolean) params.get("isNINGXIA");
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
                proconfirmMap.put("province", SecureUtil.getCurrentUser().getProvince());
                proconfirmMap.put("year", CommonUtil.getYear());
                proconfirmMap.put("wfid", workflow);
                proconfirmMap.put("isrelease", 2);
                if (bustype != null && "program".equals(bustype)) {
                    String proCode = (String)map.get("pro_code");
                    proconfirmMap.put("code", proCode);
                    proconfirmMap.put("pro_code", map.get("pro_code"));
                    proconfirmMap.put("name", map.get("pro_name"));
                    proconfirmMap.put("finintorgguid", map.get("mof_dep_code"));
                    proconfirmMap.put("agencyguid", agencyguid);
                    proconfirmMap.put("manage_dept_code",map.get("manage_dept_code"));
                    proconfirmMap.put("manage_mof_dep_code",map.get("manage_mof_dep_code"));
                    proconfirmMap.put("mof_dep_code",map.get("mof_dep_code"));
                    proconfirmMap.put("dept_code",map.get("dept_code"));
                    if(isNINGXIA){
                        proconfirmMap.put("eval_amt",map.get("pro_total_amt")); // 评价期资金
                        proconfirmMap.put("year",CommonUtil.getYear()); // 评价年度，默认登录年度
                        proconfirmMap.put("agencyguid", map.get("dept_code")); // 宁夏选择项目预算单位给部门值
                    }
                    String startYearStr = map.get("pro_start_year") == null ? "0" : (String) map.get("pro_start_year");
                    String proTermStr = map.get("pro_term") == null ? "0" : (String) map.get("pro_term");
                    Integer endtime = Integer.valueOf(startYearStr) + Integer.valueOf(proTermStr) - 1;
                    if (endtime > 0) {
                        proconfirmMap.put("endtime", endtime + "1231");   //截止日期：公式=开始时间+项目期限(pro_start_year + pro_term - 1)
                    }
                    proconfirmMap.put("pro_start_year", startYearStr + "0101"); //开始日期：取开始时间字段(pro_start_year)
                    proconfirmMap.put("leader_name", map.get("leader_name")); //项目负责人：取负责人名称字段(leader_name)
                    proconfirmMap.put("projectcon", map.get("leader_tel")); //项目联系人：取负责人电话字段(leader_tel)
                    proconfirmMap.put("pro_total_amt", map.get("pro_total_amt")); //项目总金额：取项目总额字段(pro_total_amt)
                    proconfirmMap.put("projamt", this.getProjAmt(proCode)); //当年预算金额
                } else {
                    proconfirmMap.put("code", map.get("code"));
                    proconfirmMap.put("name", map.get("name"));
                    proconfirmMap.put("finintorgguid", map.get("finintorgguid"));
                    proconfirmMap.put("agencyguid", agencyguid);
                }
                proconfirmMap.put("bustype", bustype);
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
        String tablecode = deptReportDAO.PERF_TABLE_DEPTEVAL;
        List<String> deltables = (List<String>) parms.get("deltables");
        List<String> delcols = (List<String>) parms.get("delcols");
        try {
            deptReportDAO.saveAll(deldatas, deptReportDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + deptReportDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            deptReportDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + deptReportDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    deptReportDAO.delDatas(deltable, delsql);
                }
            }
            backMap.put("flg", "1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 导入项目
     * @param impDatas
     * @param impCols
     * @param tablecode
     * @param resultList
     * @param busParams
     * @throws AppException
     */
    public void importProData(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        if (impDatas != null && impDatas.size() > 0) {
            List<Map<String, Object>> errorlist = this.checkImpColLength(impDatas, impCols);
            errorlist.addAll(this.checkProCode(impDatas));
            if (errorlist.size() > 0) {
                throw new AppException("ANA-ERROR", "导入数据错误");
            } else {
                this.impData(impDatas, tablecode, busParams);
            }
        }
    }

    public void impData( ArrayList impDatas, String tablecode, HashMap busParams) throws AppException {
        DeptReportDAO deptReportDAO = (DeptReportDAO) PerfServiceFactory.getBean("pmkpi.evaluation.dept.report.DeptReportDAO");
        String workflow = (String) busParams.get("workflow");
        Boolean isNINGXIA = (Boolean) busParams.get("isNINGXIA");
        UserDTO user = SecureUtil.getCurrentUser();
        List<Map<String, Object>> dataList = new ArrayList<>();
        BigInteger initOrderOn = BigInteger.ONE;
        if(isNINGXIA){
            Map<String, Object> count = deptReportDAO.getCount(tablecode);
            if (count.get("code") != null && count.get("code") !="") {
                String code = count.get("code").toString();
                BigInteger bigInteger = new BigInteger(code);
                initOrderOn = bigInteger.add(BigInteger.ONE);
            }
        }
        for (Object dataMap : impDatas) {
            HashMap<String, Object> data = (HashMap<String, Object>) dataMap;
            String newguid = this.getCreateguid();
            data.put("guid", newguid);
            data.put("proguid", newguid);

            data.put("createtime", StringUtil.getSysDBDate());
            data.put("updatetime", StringUtil.getSysDBDate());
            data.put("creater", user.getGuid());
            data.put("province", user.getProvince());
            data.put("year", CommonUtil.getYear());
            data.put("wfid", workflow);
            data.put("isrelease", 2);
            data.put("bustype", "program");
            String startYearStr = data.get("pro_start_year") == null ? "0" : (String) data.get("pro_start_year");
            String proTermStr = data.get("pro_term") == null ? "0" : (String) data.get("pro_term");
            Integer endtime = Integer.valueOf(startYearStr) + Integer.valueOf(proTermStr) - 1;
            if (endtime > 0) {
                data.put("endtime", endtime + "1231");   //截止日期：公式=开始时间+项目期限(pro_start_year + pro_term - 1)
            }
            data.put("pro_start_year", startYearStr + "0101"); //开始日期：取开始时间字段(pro_start_year)
            if(isNINGXIA){
                data.put("isadd", 1);
                String dept_code = (String) data.get("dept_code");
                List<Map<String, Object>> list = deptReportDAO.getDatas("fasp_t_pubdepartment", "t.guid = '" + dept_code + "'", null);
                if(list.size() > 0){
                    data.put("finintorgguid", list.get(0).get("finintorgguid"));
                }
                data.put("agencyguid", dept_code);
                if(StringUtil.isEmpty((String)data.get("code"))){
                    data.put("pro_code",initOrderOn);
                    data.put("code",initOrderOn);
                    initOrderOn = initOrderOn.add(BigInteger.ONE);
                } else {
                    data.put("pro_code", data.get("code"));
                }
            } else {
                data.put("code",data.get("pro_code"));
            }
            dataList.add(data);
        }
        if (workflow != null) {
            this.workflow("create", workflow, "", tablecode, dataList);
        } else {
            deptReportDAO.saveAll(dataList, tablecode);
        }
    }

    /**
     * 在导入项目时，如有项目编码列，需校验本表导入模板中项目编码是否唯一，如存在重复提示“第X行项目重复！”，所有数据都不处理
     * @return
     */
    public List<Map<String, Object>> checkProCode(List<Map<String, Object>> datas) throws AppException {
        DeptReportDAO deptReportDAO = (DeptReportDAO) PerfServiceFactory.getBean("pmkpi.evaluation.dept.report.DeptReportDAO");
        List<Map<String, Object>> errorlist = new ArrayList<>();
        int j = 1;
        StringBuffer error = null;
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        ImportErrorDTO dto = null;
        List<String> procodes = new ArrayList<String>();
        List<String> codes = new ArrayList<String>();
        for (Map data : datas) {
            error = new StringBuffer();
            ++j;
            String code = (String) data.get("code");
            String pro_code = (String) data.get("pro_code");
            String fund_type = (String) data.get("fund_type");//类别
            //校验项目编码重复(通版)
            if (!StringUtil.isEmpty(pro_code) && procodes.contains(pro_code)) {
                error.append("第"+j+"行项目重复！");
            }
            //校验:类别下拉选择1-中央对省 则中央金额必填；类别下拉选择2-省级对下 则省级金额为必填（湖北个性化）
            if(PerfUtil.getIS_HUBEI() && !StringUtil.isEmpty(fund_type)){
                if("HBDEPTEVALFUNDTYPE01".equals(fund_type) && StringUtil.isEmpty((String)data.get("projamt"))){
                    error.append("第"+j+"行中央金额为必填！");
                }else if("HBDEPTEVALFUNDTYPE02".equals(fund_type) && StringUtil.isEmpty((String)data.get("amt1"))){
                    error.append("第"+j+"行省级金额为必填！");
                }
            }

            if (PerfUtil.getIsNINGXIA()){
                if ((!StringUtil.isEmpty(code)) && codes.contains(code)) {
                    error.append("第"+j+"行项目编码重复！");
                }
                if (!StringUtil.isEmpty((String)data.get("code"))) {
                    String str = (String) data.get("code");
                    if(!str.isEmpty() && !str.matches("\\d+")){
                        error.append("第"+j+"行项目编码格式错误，请输入数字字符！");
                    }
                }
                if(!StringUtil.isEmpty((String)data.get("code"))){
                    List<Map<String, Object>> list = deptReportDAO.getDatas("V_PERF_T_DEPTEVALUATION", "t.code = '" + data.get("code") + "'", null);
                    if(list.size() > 0){
                        error.append("第"+j+"行项目编码已存在，请重新填写！");
                    }
                }
                if(StringUtil.isEmpty((String)data.get("name"))){
                    error.append("第"+j+"行项目名称为必填！");
                }
                if(StringUtil.isEmpty((String)data.get("eval_amt"))){
                    error.append("第"+j+"行评价期资金为必填！");
                }
                if(StringUtil.isEmpty((String)data.get("eval_type"))){
                    error.append("第"+j+"行评价资金类型为必填！");
                }
                if(StringUtil.isEmpty((String)data.get("dept_code"))){
                    error.append("第"+j+"行主管部门为必填！");
                }
            }
            procodes.add(pro_code);
            codes.add(code);
            if (!StringUtil.isEmpty(error.toString())) {
                dto = new ImportErrorDTO(FileUploadService.fileguids.get(), j, error.toString());
                errordao.saveErrorMsg(dto);
                errorlist.add(dto);
            }
        }
        return errorlist;
    }

}
