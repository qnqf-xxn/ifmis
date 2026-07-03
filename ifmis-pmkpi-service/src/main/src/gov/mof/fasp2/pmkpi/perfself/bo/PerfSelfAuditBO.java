package gov.mof.fasp2.pmkpi.perfself.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfApplyDAO;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfTaskManageDAO;
import gov.mof.fasp2.pmkpi.perfself.pushdatacommun.PushDataCommunBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfSelfAuditBO extends PmkpiBO {
    private PerfSelfApplyDAO perfSelfApplyDAO;

    public void setPerfSelfApplyDAO(PerfSelfApplyDAO perfSelfApplyDAO) {
        this.perfSelfApplyDAO = perfSelfApplyDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        //页面类型
        List queryConfig = (List) sqlmap.get("queryConfig");
        Map<String, String> queryParam = new HashMap<String, String>();
        if (queryConfig != null && queryConfig.size() > 0) {
            queryParam = (Map<String, String>) queryConfig.get(0);
        }
        String wheresql = (String) sqlmap.get("querySql");
        String isleaf = (String) sqlmap.get("isleaf");
        String agency = (String) sqlmap.get("agency");
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String workflow = (String) sqlmap.get("workflow");
        String tabcode = (String) sqlmap.get("tabcode");
        String MINAMOUNT = queryParam.get("c1");
        String MAXAMOUNT = queryParam.get("c2");
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String orderby = (String) sqlmap.get("orderby");
        //资金条件  ((C2 like '%20%'))
        if (wheresql != null && !wheresql.isEmpty() && wheresql.contains("((C2")) {
            String cutsql = wheresql.substring(wheresql.indexOf("((C2"), wheresql.lastIndexOf("%'))") + 4);
            wheresql = wheresql.replace(cutsql, "BUDGETAMOUNT <=" + MAXAMOUNT + " ");
        }
        //资金条件  ((C1 like '%20%'))
        if (wheresql != null && !wheresql.isEmpty() && wheresql.contains("((C1")) {
            String cutsql = wheresql.substring(wheresql.indexOf("((C1"), wheresql.lastIndexOf("%'))") + 4);
            wheresql = wheresql.replace(cutsql, "BUDGETAMOUNT >=" + MINAMOUNT + " ");
        }
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        StringBuffer sql = new StringBuffer("select * from ");
        if (PerfUtil.getIsHbei()) {
            //河北环境不用code    yearflag  1-总体   0-年度
            tablecode += "_HB";
        }
        sql.append(tablecode).append(" t ");
        sql.append(" where t.bustype='").append(lefttabtype).append("'");
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            sql.append(" and (").append(tablesql).append(")");
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            sql.append(" and (").append(tabfilter).append(")");
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            sql.append(" and (").append(wfsql).append(")");
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, perfSelfApplyDAO.PMKPI_TABLE_T_AGENCY));
        sql.append(datarule);
        if ("alreadyaudit".equals(tabcode) && StringUtil.isEmpty(orderby)) {
            sql.append(" order by t.lastupdatetime desc");
        }
        return sql.toString();
    }

    /**
     * 获取审核数据.
     *
     * @param nodeguid --节点guid
     * @return --
     * @throws AppException
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    public Map<String, Object> getTableData(String busguid, String audittype, String agencyguid, String nodeguid)
            throws AppException {
        Map<String, Object> rt = new HashMap<String, Object>();
        List<Map<String, Object>> auditlist = perfSelfApplyDAO.getAuditData(busguid, audittype, nodeguid);
        String mainguid = "";
        Map<String, Object> editmap = new HashMap<String, Object>();
        if (auditlist != null && auditlist.size() > 0) {
            editmap = auditlist.get(0);
            mainguid = String.valueOf(editmap.get("guid"));
        }
        Map<String, Object> dataMap = new HashMap<String, Object>();
        List<Map<String, Object>> subdatas = perfSelfApplyDAO.getData(mainguid);
        for (Map<String, Object> data : subdatas) {
            data.put("tempguid", data.get("guid"));
        }
        dataMap.put("datas", subdatas);
        rt.putAll(dataMap);
        rt.put("editmap", editmap);
        return rt;
    }

    @SuppressWarnings("unchecked")
    public Map<String, Object> save(HashMap<String, Object> param) throws AppException {
        Map<String, Object> resMap = new HashMap<String, Object>();
        Map<String, Object> mainMap = (Map<String, Object>) param.get("maindata");
        String mainguid = String.valueOf(param.get("mainguid"));
        String nodeguid = String.valueOf(param.get("nodeguid"));
        String audittype = String.valueOf(param.get("audittype"));
        String agencyguid = String.valueOf(param.get("agency"));
        mainMap.put("mainguid", mainguid);
        mainMap.put("nodeguid", nodeguid);
        mainMap.put("agencyguid", agencyguid);
        mainMap.put("createtime", StringUtil.getSysDBDate());
        mainMap.put("updatetime", StringUtil.getSysDBDate());
        mainMap.put("province", SecureUtil.getUserSelectProvince());
        mainMap.put("type", audittype);
        mainMap.put("year", CommonUtil.getYear());
        if (mainMap.get("guid") == null || "".equals(mainMap.get("guid"))) {
            mainMap.put("guid", this.getCreateguid());
            mainMap.put("userguid", SecureUtil.getCurrentUser().getGuid());
        }
        String guid = mainMap.get("guid").toString();
        if (param.get("datas") != null) {
            List<Map<String, Object>> datas = (List<Map<String, Object>>) param.get("datas");
            for (Map<String, Object> map : datas) {
                map.put("guid", this.getCreateguid());
                map.put("mainguid", mainguid);
                map.put("auditguid", guid);
            }
            perfSelfApplyDAO.deleteByMainguid(perfSelfApplyDAO.AUDITSUB_TABLE, "auditguid", guid, null);
            perfSelfApplyDAO.saveAll(datas, perfSelfApplyDAO.AUDITSUB_TABLE);

        }
        String wheresql = " nodeguid='" + nodeguid + "' and userguid='" + SecureUtil.getCurrentUserID() + "' and type='" + audittype + "'";
        perfSelfApplyDAO.deleteByMainguid(perfSelfApplyDAO.AUDITMAIN_TABLE, "mainguid", mainguid, wheresql);
        perfSelfApplyDAO.save(mainMap, perfSelfApplyDAO.AUDITMAIN_TABLE);
        return resMap;
    }

    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws Exception {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String bustype = (String) params.get("bustype");
        String tablecode = PerfSelfTaskManageDAO.PERF_TABLE_SELFEVALTASK;
        String busguid = (String) params.get("busguid");
        // 自评终审同步债券数据开关
        String isGD_PMKPI = PerfUtil.getSystemSet("isGD_PMKPI");
        if (datas != null && !datas.isEmpty()) {
            String wfstatus = "";
            wfstatus = (String) datas.get(0).get("wfstatus");
            this.workflow(actioncode, workflow, remark, tablecode, datas);
            if (actioncode != null && "cancelaudit".equals(actioncode)) {
                perfSelfApplyDAO.saveAll(datas, perfSelfApplyDAO.PMKPI_TABLE_TMP_GUIDS);
                String wheresql = " set t.evalstatus =1 where exists(select 1 from " + perfSelfApplyDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
                perfSelfApplyDAO.updateDatas(tablecode, wheresql);
                //取消终审，山西要删掉数据中心附件
                if (PerfUtil.getIsSx() && ("program").equals(bustype) &&  "011".equals(wfstatus)) {
                    PushDataCommunBO pushDataCommunBO = (PushDataCommunBO) PerfServiceFactory.getBean("pmkpi.perfself.PushDataCommunBOTX");
                    pushDataCommunBO.delSXDataCommunicationFile(datas);
                }
            } else {
                wfstatus = (String) datas.get(0).get("wfstatus");
                boolean isNINGXIA = PerfUtil.getIsNINGXIA();
                String perfselfrandomwfstatus = PerfUtil.getSystemSet("perfselfrandomwfstatus");//宁夏项目支出非抽评项目终审节点
                if ((wfstatus != null && !wfstatus.isEmpty() && "011".equals(wfstatus))) {
                    perfSelfApplyDAO.saveAll(datas, perfSelfApplyDAO.PMKPI_TABLE_TMP_GUIDS);
                    String wheresql = " set t.evalstatus =2 where exists(select 1 from " + perfSelfApplyDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
                    perfSelfApplyDAO.updateDatas(tablecode, wheresql);
                    //自评终审-同步债券绩效自评数据
                    logger.info("---债券绩效-参数 isGD_isGD_PMKPI : "+isGD_PMKPI+"");
                    if("1".equals(isGD_PMKPI)){
                        logger.info("---债券绩效自评-同步开始 ");
                        List<Map<String, Object>> reList = new ArrayList<>();
                        List<Map<String, Object>> resList = new ArrayList<>();
                        StringBuffer sql = new StringBuffer("");
                        String flag = "2";
                        for (Map<String, Object> reMap : datas) {
                            Map<String, Object> impopMap = new HashMap<>(); // 主表信息
                            Map<String, Object>  propMap = perfSelfApplyDAO.queryForMap("select * from v_perf_project_info where pro_code = '"+reMap.get("pro_code")+"' ");
                            if(!"1".equals(propMap.get("gd_bond"))){
                                //continue;
                            }
                            flag = "1";
                            if(sql.length() > 0){
                                sql.append(",'"+reMap.get("pro_code")+"'");
                            } else {
                                sql.append("'"+reMap.get("pro_code")+"'");
                            }
                            Map<String, Object>  agenMap = perfSelfApplyDAO.queryForMap("select * from fasp_T_pubagency where code = '"+reMap.get("agencyguid")+"' ");
                            Map<String, Object>  descMap = perfSelfApplyDAO.queryForMap("select * from V_PERF_SELFPERFDESC  where mainguid = '"+reMap.get("guid")+"' ");
                            String eval_id = this.getCreateguid();
                            impopMap.put("eval_id", eval_id);
                            impopMap.put("guid", eval_id);
                            impopMap.put("fiscal_year", CommonUtil.getYear());
                            impopMap.put("mof_div_code",SecureUtil.getUserSelectProvince());
                            impopMap.put("mof_div_name", CommonUtil.getProvinceNameByCode((String) impopMap.get("mof_div_code")));
                            impopMap.put("agency_code",reMap.get("agencyguid"));
                            impopMap.put("agency_name",agenMap.get("name"));
                            impopMap.put("pro_code",reMap.get("pro_code"));
                            impopMap.put("pro_name",propMap.get("pro_name"));
                            impopMap.put("total_eval_value",reMap.get("score"));
                            impopMap.put("goal_comp",descMap.get("allyeargoal"));
                            impopMap.put("is_last_inst",2);
                            impopMap.put("is_deleted", 2);
                            impopMap.put("create_time",PerfUtil.getServerTimeStamp());
                            impopMap.put("update_time",PerfUtil.getServerTimeStamp());
                            impopMap.put("year", CommonUtil.getYear());
                            impopMap.put("province", SecureUtil.getUserSelectProvince());
                            impopMap.put("createtime", PerfUtil.getServerTimeStamp());
                            impopMap.put("updatetime", PerfUtil.getServerTimeStamp());
                            impopMap.put("creater", SecureUtil.getCurrentUserID());
                            impopMap.put("wfid", null);
                            impopMap.put("wfstatus", null);
                            impopMap.put("auditor", null);
                            impopMap.put("lastupdatetime", null);
                            reList.add(impopMap);
                            List<Map<String, Object>> indexList = perfSelfApplyDAO.queryForList("select * from perf_t_selfperfindex where pro_code = '" + reMap.get("pro_code") + "' and mainguid = '" + reMap.get("guid") + "' and is_deleted = 2 ");
                            for (Map<String, Object> indexMap : indexList) {
                                Map<String, Object> impopsMap = new HashMap<>(); // 附表信息
                                String eval_dtl_id = this.getCreateguid();
                                impopsMap.put("eval_dtl_id", eval_dtl_id);
                                impopsMap.put("guid", eval_dtl_id);
                                impopsMap.put("eval_id", eval_id);
                                impopsMap.put("kpi_id", indexMap.get("guid"));
                                impopsMap.put("pro_code",reMap.get("pro_code"));
                                impopsMap.put("fiscal_year", CommonUtil.getYear());
                                impopsMap.put("mof_div_code",SecureUtil.getUserSelectProvince());
                                impopsMap.put("mof_div_name","本级");
                                impopsMap.put("ind_weight", indexMap.get("weight"));
                                impopsMap.put("eval_value", indexMap.get("score"));
                                impopsMap.put("goal_comp", indexMap.get("actualvalue"));
                                String kpi_remark = (String) indexMap.get("kpi_remark");
                                if(kpi_remark == null || "".equals(kpi_remark)){
                                    impopsMap.put("devi_analy", "无");
                                } else {
                                    impopsMap.put("devi_analy", indexMap.get("kpi_remark"));
                                }
                                impopsMap.put("is_last_inst", 2);
                                impopsMap.put("is_deleted", 2);
                                impopsMap.put("create_time",PerfUtil.getServerTimeStamp());
                                impopsMap.put("update_time",PerfUtil.getServerTimeStamp());
                                impopsMap.put("year", CommonUtil.getYear());
                                impopsMap.put("province", SecureUtil.getUserSelectProvince());
                                impopsMap.put("createtime", PerfUtil.getServerTimeStamp());
                                impopsMap.put("updatetime", PerfUtil.getServerTimeStamp());
                                impopsMap.put("creater", SecureUtil.getCurrentUserID());
                                impopsMap.put("wfid", null);
                                impopsMap.put("wfstatus", null);
                                impopsMap.put("auditor", null);
                                impopsMap.put("lastupdatetime", null);
                                resList.add(impopsMap);
                            }
                        }
                        if("1".equals(flag)){
                            logger.info("---债券绩效自评-同步项目PRO_CODE : "+sql+"");
                            logger.info("---债券绩效自评-同步主表数据量 : "+reList.size()+"");
                            logger.info("---债券绩效自评-同步附表数据量 : "+resList.size()+"");
                            String wheresql1 = " set t.is_deleted = 1 where t.pro_code in ("+sql+")";
                            perfSelfApplyDAO.updateDatas("V_GD_PERF_SELF_EVAL", wheresql1);
                            perfSelfApplyDAO.updateDatas("V_GD_PERF_SELF_EVAL_DTL", wheresql1);
                            if (reList.size() > 0) {
                                perfSelfApplyDAO.saveAll(reList, "V_GD_PERF_SELF_EVAL");
                            }
                            if (resList.size() > 0) {
                                perfSelfApplyDAO.saveAll(resList, "V_GD_PERF_SELF_EVAL_DTL");
                            }
                            logger.info("---债券绩效自评-同步结束 ");
                        }
                    }
                    // 宁夏项目支出非抽评项目 审核节点和配置节点相同，视为终审节点
                } else if(isNINGXIA && ("program").equals(bustype) && wfstatus.equals(perfselfrandomwfstatus)){
                    List<Map<String, Object>> arrayList = new ArrayList<>(); // 非抽评项目
                    for (Map<String, Object> map : datas){
                        String isExtract = (String) map.get("is_extract");
                        if("2".equals(isExtract)){
                            arrayList.add(map);
                        }
                    }
                    if(arrayList.size() > 0){
                        perfSelfApplyDAO.saveAll(arrayList, perfSelfApplyDAO.PMKPI_TABLE_TMP_GUIDS);
                        String wheresql = " set t.evalstatus =2 where exists(select 1 from " + perfSelfApplyDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
                        perfSelfApplyDAO.updateDatas(tablecode, wheresql);
                    }
                }
            }
            //处理规范表数据
            this.updateTabelDatas(datas, actioncode, bustype);
        }
        return this.auditdefine(datas, busguid, actioncode, null);
    }


    /**
     * 处理规范表数据
     * @param datas
     * @param actioncode
     * @param bustype
     * @throws AppException
     */
    public void updateTabelDatas (List<Map<String, Object>> datas, String actioncode, String bustype) throws AppException {
        perfSelfApplyDAO.updateTabelDatas(datas, actioncode, bustype);
    }

    /**
     * <p>左侧树-整合菜单首次进入页面</p >
     *
     * @param
     * @author hw
     * @date 2021/7/17 16:06
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String lefttabtype = (String) params.get("lefttabtype");
        String tablecode = (String) params.get("tablecode");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        datarule += " and bustype='" + lefttabtype + "'";
        return perfSelfApplyDAO.getLeftTree(tablecode, datarule);
    }

    //判断发起整改的数据表中是否存在
    public Integer getDataByGuid(HashMap<String, Object> params){
        String lefttabtype = (String) params.get("lefttabtype");
        String projguid = (String) params.get("projguid");
        String rectype = (String) params.get("rectype");
        String pro_code = (String) params.get("pro_code");
        StringBuffer sql = new StringBuffer();
        sql.append(" rectype = '"+rectype+"' and wfstatus <> '011'");
        if ("program".equals(lefttabtype) || "transprogram".equals(lefttabtype) || "parentprogram".equals(lefttabtype)) { //项目支出
            sql.append(" and pro_code = '"+pro_code+"'");
        } else if ("dept".equals(lefttabtype)) { //部门整体
            sql.append(" and proguid = '"+projguid+"'");
        }
        return perfSelfApplyDAO.getDataCount("V_PERF_T_RECTIFY", sql.toString());
    }

    /**
     * 导入评审意见
     * @param impDatas
     * @param impCols
     * @param tablecode
     * @param resultList
     * @param busParams
     * @throws AppException
     */
    public void importOpinionData(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        if (impDatas != null && impDatas.size() > 0) {
            String bustype = (String) busParams.get("bustype");
            PerfSelfAuditBO perfSelfAuditBO = (PerfSelfAuditBO) PerfServiceFactory.getBean("pmkpi.perfSelf.PerfSelfAuditBOTX");
            perfSelfAuditBO.impOpinionData(impDatas, bustype);
        }
    }

    public void impOpinionData(ArrayList impDatas, String bustype) throws AppException {
        String wheresql = "";
        List<Map<String, Object>> prolist = new ArrayList<>();
        Map<String, Object> proMap = null;
        Map<String, Object> opinionMap = new HashMap<>();
        List<Map<String, Object>> opinionList = new ArrayList<>();//子单审核意见
        PerfSelfApplyDAO perfSelfApplyDAO = (PerfSelfApplyDAO) PerfServiceFactory.getBean("pmkpi.perfSelf.PerfSelfApplyDAO");
        for (Object obj : impDatas) {
            proMap = new HashMap<>();
            Map<String, Object> map = (Map<String, Object>) obj;
            String str = "";
            if ("dept".equals(bustype)) {
                str = (String) map.get("agency_code");
                proMap.put("guid", str);
            } else {
                str = (String) map.get("pro_code");
                proMap.put("guid", str);
            }
            opinionMap.put(str, map);
            prolist.add(proMap);
        }
        if ("dept".equals(bustype)) {
            wheresql = " exists(select 1 from v_perf_t_deptperfdeclare a where a.guid=t.projguid ) and exists(select 1 from " + perfSelfApplyDAO.PMKPI_TABLE_TMP_GUIDS + " b where b.guid=t.agencyguid) ";
        } else {
            wheresql = " exists(select 1 from " + perfSelfApplyDAO.PMKPI_TABLE_PROJECT_INFO + " a where a.pro_code=t.pro_code ) and exists(select 1 from " + perfSelfApplyDAO.PMKPI_TABLE_TMP_GUIDS + " b where b.guid=t.pro_code) ";
        }
        wheresql += " and t.bustype='" + bustype + "' ";
        //保存所有项目
        perfSelfApplyDAO.saveAll(prolist, perfSelfApplyDAO.PMKPI_TABLE_TMP_GUIDS);
        //根据项目查询绩效目标评审在途数据，不包含已确认数据,并删除审核已经
        List<Map<String, Object>> reList = perfSelfApplyDAO.getSelfMainData(wheresql);
        StringBuffer delsql = new StringBuffer(" delete from v_perf_t_selfperfopinion where mainguid in(");
        for (Map<String, Object> reMap : reList) {
            String mainguid = (String) reMap.get("guid");
            String agencyguid = (String) reMap.get("agencyguid");
            String procode = (String) reMap.get("pro_code");
            Map<String, Object> impopMap = null;
            if ("dept".equals(bustype)) {
                impopMap = (Map<String, Object>) opinionMap.get(agencyguid);
            } else {
                impopMap = (Map<String, Object>) opinionMap.get(procode);
            }
            String year = CommonUtil.getYear();
            String province = SecureUtil.getUserSelectProvince();
            String tiem = PerfUtil.getServerTimeStamp();
            if (!impopMap.isEmpty()) {
                impopMap.put("guid", this.getCreateguid());
                impopMap.put("mainguid", mainguid);
                impopMap.put("year", year);
                impopMap.put("province", province);
                impopMap.put("create_time", tiem);
                impopMap.put("update_time", tiem);
                impopMap.put("is_deleted", 2);
                impopMap.put("creater", SecureUtil.getCurrentUserID());
                opinionList.add(impopMap);
            }
            delsql.append("'").append(mainguid).append("',");
        }
        if (reList.size() > 0) {
            delsql.deleteCharAt(delsql.length() - 1);
        } else {
            delsql.append("''");
        }
        delsql.append(")");
        if (opinionList.size() > 0) {
            perfSelfApplyDAO.execute(delsql.toString());
            perfSelfApplyDAO.saveAll(opinionList, "v_perf_t_selfperfopinion");
        }
    }

}
