package gov.mof.fasp2.pmkpi.adjust.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.datacommon.workflow.dto.WorkflowBranchDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;
import java.util.stream.Collectors;

public class AdjustReportBO extends PmkpiBO {
    private AdjustReportDAO adjustReportDAO;

    public void setAdjustReportDAO(AdjustReportDAO adjustReportDAO) {
        this.adjustReportDAO = adjustReportDAO;
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
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String checktablecode = "";
        String checksql = "";
        if ("dept".equals(lefttabtype)) {
            checktablecode = adjustReportDAO.PMKPI_TABLE_DEPTPERFDECLARE;
            checksql = " t.guid=a.proguid ";
        } else {
            checktablecode = adjustReportDAO.PMKPI_TABLE_ADJUSTPROJECT_INFO;
            if(PerfUtil.getIsHbei()){
                checksql = " t.guid=a.proguid ";
            }else {
                checksql = " t.pro_code=a.pro_code ";
            }
        }
        StringBuffer returnsql = new StringBuffer();
        if (type != null && "check".equals(type)) {
            returnsql.append("select t.* from ").append(checktablecode);
            returnsql.append(" t where not exists(select 1 from v_perf_t_adjust a where ").append(checksql);
            returnsql.append(" and nvl(a.wfstatus,'0')<>'011')");
        } else {
            returnsql.append("select t.* from ").append(tablecode).append(" t ");
            returnsql.append(" where t.bustype='").append(lefttabtype).append("'");
            if (PerfUtil.getIsNINGXIA()) {
                if ("waitaudit".equals(tabcode)) {
                    returnsql.append(" and (t.delwfstatus != '2' or t.delwfstatus is null) ");
                } else if ("delwaitaudit".equals(tabcode)){
                    returnsql.append(" and t.delwfstatus in ('1','2','3') ");
                } else if ("delaudit".equals(tabcode)) {
                    returnsql.append(" and t.delwfstatus in ('1') ");
                } else if ("delalreadyaudit".equals(tabcode)) {
                    returnsql.append(" and t.delwfstatus in ('2','3') ");
                }
            }
        }
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (!StringUtil.isEmpty(tabfilter)){
            returnsql.append(" and ").append(tabfilter);
        }
        if (!"delwaitaudit".equals(tabcode) && !"delaudit".equals(tabcode) && !"delalreadyaudit".equals(tabcode)) {
            if (type == null || type.isEmpty()) {
                String wfsql = this.getWfSql(tabcode, workflow, "t");
                if (wfsql != null && !wfsql.isEmpty()) {
                    returnsql.append(" and (").append(wfsql).append(") ");
                }
            }
        }
        returnsql.append(datarule);
        if (!StringUtil.isEmpty(tablesql)){
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtil.isEmpty(wheresql)){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, adjustReportDAO.PMKPI_TABLE_T_AGENCY));
        return returnsql.toString();
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = "v_perf_t_adjust";
        String lefttabtype = (String) params.get("lefttabtype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype='" + lefttabtype + "' ";
        return adjustReportDAO.getLeftTree(tablecode, datarule);
    }
    
    /**
     * 保存调整数据
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveProgramadjust(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        List<Map<String, Object>>  datas = (List<Map<String, Object>>) params.get("datas");
        String adjustType = StringUtil.isEmpty((String) params.get("adjustType")) ? "1" : (String) params.get("adjustType");
        String tablecode = "v_perf_t_adjust";
        String workflow = (String)params.get("workflow");
        String bustype = (String) params.get("bustype");
        String queryYear = (String)params.get("queryYear");
        String queryProvince = (String)params.get("queryProvince");
        if (!StringUtil.isNullOrEmpty(queryYear) && !StringUtil.isNullOrEmpty(queryProvince)) {
            this.setYearAndProvince(queryYear, queryProvince);
        }
        if (datas != null && datas.size() >= 0) {
            String type = "dept";
            String col = "";
            String wheresql = "";
            if (PerfUtil.getIsHbei() || type.equals(bustype)) {
                col = "proguid";
                adjustReportDAO.saveAll(datas, adjustReportDAO.PMKPI_TABLE_TMP_GUIDS);
            } else {
                col = "pro_code";
                List pro_codes = new ArrayList();
                Map mm = null;
                for (Map<String, Object> proMap : datas) {
                    mm = new HashMap();
                    mm.put("guid", proMap.get(col));
                    pro_codes.add(mm);
                }
                adjustReportDAO.saveAll(pro_codes, adjustReportDAO.PMKPI_TABLE_TMP_GUIDS);
            }
            wheresql = " exists(select * from "+ PmkpiDAO.PMKPI_TABLE_TMP_GUIDS + " a where t." + col + "=a.guid) and islast = 1";
            //根据项目信息获取调整主单信息
            List<Map<String, Object>> maindatas = adjustReportDAO.getDatas(tablecode, wheresql, null);
            //删除临时表数据
            adjustReportDAO.delDatas(PmkpiDAO.PMKPI_TABLE_TMP_GUIDS, null);
            adjustReportDAO.saveAll(maindatas, adjustReportDAO.PMKPI_TABLE_TMP_GUIDS);
            //获取项目最大调整次数
            List<Map<String, Object>> adjustnums = adjustReportDAO.getJustnums(bustype);
            List<Map<String, Object>> adjustList = new ArrayList<>();
            Map<String, Object> adjustMap = null;
            for (Map<String, Object> map : datas) {
                String agencyguid = (String) map.get("agencyguid");
                adjustMap = new HashMap<String, Object>();
                String guid = this.getCreateguid();
                String value = "";
                if (PerfUtil.getIsHbei() || type.equals(bustype)) {
                    value = (String) map.get("guid");
                } else {
                    value = (String) map.get(col);
                }
                adjustMap.put("adjustnum", 1);
                int adjustnum = 0;
                for (Map<String, Object> m : adjustnums) {
                    String v = (String) m.get(col);
                    adjustnum = this.mapGetInt(m,"adjustnum");
                    if (value != null && value.equals(v)) {
                        adjustMap.put("adjustnum", adjustnum + 1);
                        break;
                    }
                }
                adjustMap.put("proguid", map.get("guid"));
                adjustMap.put("guid", guid);
                adjustMap.put("createtime", PerfUtil.getServerTimeStamp());
                adjustMap.put("updatetime", PerfUtil.getServerTimeStamp());
                adjustMap.put("creater", SecureUtil.getCurrentUser().getGuid());
                adjustMap.put("province", StringUtil.isNullOrEmpty(queryProvince) ? SecureUtil.getUserSelectProvince() : queryProvince);
                adjustMap.put("year", StringUtil.isNullOrEmpty(queryYear) ? CommonUtil.getYear() : queryYear);
                adjustMap.put("wfid", workflow);
                adjustMap.put("agencyguid", agencyguid);
                adjustMap.put("manage_dept_code", map.get("manage_dept_code"));
                adjustMap.put("manage_mof_dep_code", map.get("manage_mof_dep_code"));
                adjustMap.put("mof_dep_code", map.get("mof_dep_code"));
                adjustMap.put("dept_code", map.get("dept_code"));
                adjustMap.put("agency_code", agencyguid);
                adjustMap.put("pro_lev", map.get("pro_lev"));
                adjustMap.put("adjustsource", adjustType);
                if (bustype != null && "program".equals(bustype)) {
                    adjustMap.put("finintorgguid", map.get("mof_dep_code"));
                    adjustMap.put("proguid", map.get("guid"));
                    adjustMap.put("name", map.get("pro_name"));
                    adjustMap.put("pro_code", map.get("pro_code"));
                    adjustMap.put("projectkind",map.get("projectkind"));          //支出项目类别
                    adjustMap.put("pro_levone_code",map.get("pro_levone_code"));  //专项资金、一级项目编码
                } else {
                    adjustMap.put("finintorgguid", map.get("finintorgguid"));
                    adjustMap.put("name", map.get("name"));
                }
                adjustMap.put("v_colk1", map.get("v_colk1"));
                adjustMap.put("v_colk2", map.get("v_colk2"));
                adjustMap.put("v_colk3", map.get("v_colk3"));
                adjustMap.put("v_colk4", map.get("v_colk4"));
                adjustMap.put("v_colk5", map.get("v_colk5")); //预留的扩展字段
                adjustMap.put("islast", 1);
                adjustMap.put("adjstatus", "2");
                adjustMap.put("bustype", bustype);
                adjustList.add(adjustMap);
            }
            if (StringUtil.isEmpty(workflow)) {
                adjustReportDAO.saveAll(adjustList, tablecode);
            } else {
                this.workflow("create", workflow, "", tablecode, adjustList);
            }
            backMap.put("success",true);
            backMap.put("adjustList", adjustList);
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
        String tablecode = "v_perf_t_adjust";
        String busguid = (String) params.get("busguid");
        String wfstatus = (String) datas.get(0).get("wfstatus");
        if("cancelsendaudit".equals(actioncode) && !StringUtil.isEmpty(wfstatus) && "011".equals(wfstatus)){
            Map remap = new HashMap();
            remap.put("msg", "请使用正确的审核菜单进行取消终审！");
            throw new PerfAppException("", (String) remap.get("msg"), remap);
        }else if("sendaudit".equals(actioncode)){
            List<WorkflowBranchDTO> workflowBranchList= PerfServiceFactory.getIWorkflowService().queryWorkflowBranchsByWfStatus(workflow,wfstatus);
            if(workflowBranchList.size()>0){
                for (WorkflowBranchDTO workflowBranch : workflowBranchList) {
                    if(workflowBranch.getAction().equals("audit") && workflowBranch.getWfstatus().equals("011")){
                        Map remap = new HashMap();
                        remap.put("msg", "请使用正确的审核菜单进行终审！");
                        throw new PerfAppException("", (String) remap.get("msg"), remap);
                    }
                }
            }
        }
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid, "perf", null);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> deladjust(HashMap<String, Object> parms) {
        String bustype = (String) parms.get("bustype");
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode = "v_perf_t_adjust";
        String goaltablecode ="v_perf_t_adjustgoal";
        String indextablecode = "v_perf_t_adjustindex";
        List<Map<String,Object>> dellist =  (List<Map<String,Object>>)parms.get("datas");
        try {
            List<String> guids = new ArrayList<>();
            List<String> proguids = new ArrayList<>();
            List<String> procodes = new ArrayList<>();
            dellist.forEach(map -> {
                guids.add((String) map.get("guid"));
                proguids.add((String) map.get("proguid"));
                procodes.add((String) map.get("pro_code"));
            });
            //删除调整表的数据
            StringBuffer wheresql = new StringBuffer();
            wheresql.append(adjustReportDAO.createInSql("guid", guids));
            adjustReportDAO.delDatas(tablecode, wheresql.toString());
            wheresql = new StringBuffer();
            wheresql.append(adjustReportDAO.createInSql("mainguid", guids));
            //删除调整目标表的数据
            adjustReportDAO.delDatas(goaltablecode, wheresql.toString());
            //删除调整目标表的数据
            adjustReportDAO.delDatas(indextablecode, wheresql.toString());
            //还原之前调整数据状态
            String type = "dept";
            wheresql = new StringBuffer();
            if (PerfUtil.getIsHbei() || type.equals(bustype)) {
                wheresql.append(adjustReportDAO.createInSql("proguid", proguids));
            } else {
                wheresql.append(adjustReportDAO.createInSql("pro_code", procodes));
            }
            adjustReportDAO.updateIsLast(bustype, wheresql.toString());
            backMap.put("flg","1");
        }catch (Exception e){
            logger.error("删除调整项目时："+e.getMessage());
            backMap.put("flg","2");
        }
        return backMap;
    }

    /**
     * 预算调整调剂处理调整数据
     * @param year
     * @param province
     * @param procode
     * @return
     * @throws AppException
     */
    public Map<String, Object> tztjAdjust(String year, String province, String procode) throws AppException {
        //设置年度、区划
        this.setYearAndProvince(year, province);
        //是否存在调整数据，且永远获取最后一次调整，调整调剂指标随时调，随时终审、取消终审，所以所有指标修改的同一项目，都是一份调整数据，取消也是取消最后一次调整数据
        String wheresql = " pro_code=? and ((islast=1 and wfid is null) or (wfid is not null and wfstatus <> '011'))";
        Map<String, Object> adjustMap = this.getDataMap("v_perf_t_adjust", wheresql, new String[]{procode});
        //是否存在调整主表数据，不存在则新增
        if (adjustMap.isEmpty()){
            List<Map<String, Object>> proList = this.getDatas(PmkpiDAO.PMKPI_TABLE_PROJECT_INFO, " pro_code=? ", null, new String[]{procode});
            if (proList.size() > 0) {
                HashMap<String, Object> params = new HashMap<>();
                params.put("datas", proList);
                params.put("bustype", "program");
                params.put("queryYear", year);
                params.put("queryProvince", province);
                Map<String, Object> backMap = this.saveProgramadjust(params);
                List<Map<String, Object>> adjustList = (List<Map<String, Object>>) backMap.get("adjustList");
                if (adjustList.size() > 0) {
                    adjustMap = adjustList.get(0);
                    //清理绩效目标指标标记
                    String upsql = "status = null, fromguid = null";
                    wheresql = " pro_code='" + procode + "' and yearflag='0' and (status='6' or fromguid is not null ) and year='" + year + "' and province='" + province + "'";
                    adjustReportDAO.updateAllByColumn(null, null, PerfConstant.PMKPI_BACKUP_GOAL_INFO, upsql, wheresql);
                    adjustReportDAO.updateAllByColumn(null, null, PerfConstant.PMKPI_BACKUP_INDICATOR, upsql, wheresql);
                }
            } else {
                throw new AppException("ERROR", "项目未在项目库表中查询到，请联系研发！");
            }
        } else {
            if (!StringUtil.isNullOrEmpty(adjustMap.get("wfid"))) {
                throw new AppException("ERROR", "项目已在预算绩效系统中进行绩效目标调整，请调整完成后再次进行调整操作！");
            }
        }
        return adjustMap;
    }

    /**
     * 指标/支付调用生成调整数据
     * @param params
     * @return
     */
    public Map<String, Object> saveAdjust(Map<String, Object> params) throws AppException {
        String bustype = "program";
        String tablecode = "v_perf_t_adjust";
        List<Map<String, Object>>  proList = (List<Map<String, Object>>) params.get("proList");
        List<String> procodeList = new ArrayList<>();
        StringBuffer wheresql = new StringBuffer();
        for (Map<String, Object> proMap : proList) {
            proMap.put("agencyguid", proMap.get("agency_code"));
            proMap.put("manage_mof_dep_code", proMap.get("bgt_mof_dep_code"));
            procodeList.add((String) proMap.get("pro_code"));
        }
        //查询项目是否进行调整，且是否填报了数据
        wheresql.append(adjustReportDAO.createInSql("pro_code", procodeList));
        List<Map<String, Object>> adjustList = adjustReportDAO.getAdjustDatas(wheresql.toString());
        List<Map<String, Object>> filteredProList = null;
        //过滤掉调整的数据
        if (!adjustList.isEmpty()) {
            // 获取adjustList中所有的pro_code
            Set<Object> adjustProCodes = adjustList.stream().map(map -> map.get("pro_code")).collect(Collectors.toSet());
            // 过滤proList，保留pro_code不在adjustProCodes中的元素
            filteredProList = proList.stream().filter(map -> !adjustProCodes.contains(map.get("pro_code"))).collect(Collectors.toList());
            Set<String> delProCodes = filteredProList.stream().map(map -> (String) map.get("pro_code")).collect(Collectors.toSet());
            procodeList = delProCodes.stream().collect(Collectors.toList());
        } else {
            filteredProList = proList;
        }
        if (procodeList != null && !procodeList.isEmpty()) {
            wheresql = new StringBuffer();
            wheresql.append(adjustReportDAO.createInSql("pro_code", procodeList)).append(" and t.wfstatus <> '011' and t.delwfstatus is null");
            adjustReportDAO.delDatas(tablecode, wheresql.toString());
        }
        String isproadj = (String) params.get("isproadj");
        if (!"true".equals(isproadj) && procodeList != null && !procodeList.isEmpty()) {
            wheresql = new StringBuffer();
            wheresql.append(adjustReportDAO.createInSql("pro_code", procodeList));
            filteredProList = this.getDatas(adjustReportDAO.PMKPI_TABLE_PROJECT_INFO, wheresql.toString(), null);
        }
        if (filteredProList != null && !filteredProList.isEmpty()) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("bustype", bustype);
            map.put("adjustType", params.get("adjustType"));
            map.put("datas", filteredProList);
            map.put("workflow", "B9A12B5D94761164E053B11FA8C0460E");
            return this.saveProgramadjust(map);
        }
        return new HashMap<>();
    }

    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> delWFAction(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String delwfstatus = (String) params.get("delwfstatus");
        String remark = (String) params.get("remark");
        String tablecode = "v_perf_t_adjust";
        for (Map<String, Object> data : datas) {
            data.put("delwfstatus", delwfstatus);
            if ("1".equals(delwfstatus)) {
                data.put("delopinion", remark);
            } else {
                if (StringUtil.isEmpty(delwfstatus)) {
                    data.put("delopinion", remark);
                } else if ("2".equals(delwfstatus)) {
                    data.put("wfstatus", "011");
                }
                data.put("delauditopinion", remark);
            }
        }
        List<String> cols = new ArrayList<>();
        cols.add("delwfstatus");
        if ("1".equals(delwfstatus)) {
            cols.add("delopinion");
        } else {
            if (StringUtil.isEmpty(delwfstatus)) {
                cols.add("delopinion");
            } else if ("2".equals(delwfstatus)) {
                cols.add("wfstatus");
            }
            cols.add("delauditopinion");

        }
        adjustReportDAO.updateAllByPK(cols, datas, "guid", tablecode);
        return this.auditdefine(datas, null, "perf", null);
    }

//    public Map<String, Object> checkFileData(HashMap<String, Object> params) throws AppException {
//        List<Map<String, Object>> datas = (List) params.get("datas"); //送审数据
//        Map<String, Object> returnMap = new HashMap<>();
//        List<String> warnList = new ArrayList<>();
//        List<String> guids = new ArrayList<>();
//        for (Map<String, Object> proMap : datas) {
//            guids.add((String) proMap.get("guid"));
//        }
//        //查询项目是否填报了调整原因
//        String tablecode = "(select t1.guid,t1.name,t2.ADJREASON from v_PERF_T_ADJUST t1 left join V_PERF_T_ADJUSTGOAL t2 on t1.guid = t2.mainguid)";
//        String sql = adjustReportDAO.createInSql("guid", guids);
//        List<Map<String, Object>> datas1 = adjustReportDAO.getDatas(tablecode, sql, "");
//        //查询项目是否上传了附件
//        String sql1 = adjustReportDAO.createInSql("billguid", guids);
//        List<Map<String, Object>> datas2 = adjustReportDAO.getDatas("v_perf_file", sql1.toString(), "");
//        for (Map<String, Object> data1 : datas1) {
//            String guid = (String) data1.get("guid");
//            String name = (String) data1.get("name");
//            String adjreason = (String) data1.get("adjreason");
//            boolean existsInDatas2 = false;
//            if(adjreason != null &&!adjreason.isEmpty()){
//                for (Map<String, Object> data2 : datas2) {
//                    String billguid = (String) data2.get("billguid");
//                    if (guid.equals(billguid)) {
//                        existsInDatas2 = true;
//                        break;
//                    }
//                }
//                if (!existsInDatas2) {
//                    String warnStr = "项目:【" + name + "】请上传附件";
//                    warnList.add(warnStr);
//                }
//            }
//        }
//        returnMap.put("esg", warnList);
//        return returnMap;
//    }

}
