package gov.mof.fasp2.pmkpi.evaluation.financial.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm.ProConfirmDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.evaluation.financial.result.ResultBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FinancialAuditBO extends PmkpiBO {
    private FinancialAuditDAO financialAuditDAO;

    public void setFinancialAuditDAO(FinancialAuditDAO financialAuditDAO) {
        this.financialAuditDAO = financialAuditDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        //String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        //String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        //String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String type = (String) sqlmap.get("type"); //项目调整选择项目
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String columncode = "agencyguid";
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select t.* from ").append(ProConfirmDAO.PERF_TABLE_PROCONFIRM).append(" t where t.bustype='").append(lefttabtype).append("' ");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (!StringUtils.isEmpty(wheresql)){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (!StringUtils.isEmpty(tablesql)){
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtils.isEmpty(tabfilter)){
            returnsql.append(" and ").append(tabfilter);
        }
        if (StringUtils.isEmpty(type)) {
            String wfsql = this.getWfSql(tabcode, workflow);
            if (!StringUtils.isEmpty(wfsql)) {
                returnsql.append(" and (").append(wfsql).append(") ");
            }
        }
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, financialAuditDAO.PMKPI_TABLE_T_AGENCY));
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
        return financialAuditDAO.getLeftTree(tablecode, datarule);
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
        this.workflow(actioncode, workflow, remark, ProConfirmDAO.PERF_TABLE_PROCONFIRM, datas);
        if (actioncode != null && "cancelaudit".equals(actioncode)) {
            financialAuditDAO.saveAll(datas, financialAuditDAO.PMKPI_TABLE_TMP_GUIDS);
            String wheresql = " exists (select 1 from " + financialAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.mainguid) ";
            financialAuditDAO.delDatas("v_perf_expertreview", wheresql);
            wheresql = " exists (select 1 from " + financialAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.review) ";
            financialAuditDAO.delDatas("perf_reviewintermediary", wheresql);
        }
        //处理规范表数据
        ResultBO resultBO = (ResultBO) PerfServiceFactory.getBean("pmkpi.evaluation.financial.ResultBOTX");
        resultBO.updateDeptEvalTabelDatas(datas, actioncode);
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 获取数据
     *
     * @param bustype
     * @param mainguid --
     * @return
     */
    public Map<String, Object> getDataById(String mainguid, String bustype) {
        String sql = " proguid='" + mainguid + "' and t.bustype='" + bustype + "'";
        return financialAuditDAO.getDataMap("v_perf_t_evaluateaudit", sql);
    }

    /**
     * 保存审核意见
     * @param params
     * @return
     */
    public Map<String, Object> saveDatas(HashMap<String, Object> params) throws AppException {
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("saveAgency");
        String workflow = (String) params.get("workflow");
        String audittype = (String) params.get("audittype");
        String actioncode = (String) params.get("actioncode");
        Map<String, Object> editinfo = (Map<String, Object>) params.get("editinfo");
        String remark = (String) editinfo.get("opinion");
        String ordinarytype = (String) editinfo.get("ordinarytype");
        List<Map<String, Object>> datas = new ArrayList<>();
        // 自评终审同步债券数据开关
        String isGD_PMKPI = PerfUtil.getSystemSet("isGD_PMKPI");
        if (audittype != null && "feedback".equals(audittype)) {
            //查询主单数据
            Map<String, Object> finMap = financialAuditDAO.getDataMap(ProConfirmDAO.PERF_TABLE_PROCONFIRM, " guid='"+mainguid+"' ");
            finMap.put("opinion", remark);
            financialAuditDAO.update(finMap, ProConfirmDAO.PERF_TABLE_PROCONFIRM);
            ordinarytype = "audit";
            datas.add(finMap);
        } else {
            editinfo.put("guid", this.getCreateguid());
            editinfo.put("createtime", PerfUtil.getServerTimeStamp());
            editinfo.put("updatetime", PerfUtil.getServerTimeStamp());
            editinfo.put("creater", SecureUtil.getCurrentUserID());
            editinfo.put("province", SecureUtil.getUserSelectProvince());
            editinfo.put("year", SecureUtil.getUserSelectYear());
            editinfo.put("status", "1");
            editinfo.put("oldopinion", "");
            editinfo.put("proguid", mainguid);
            editinfo.put("agencyguid", saveAgency);
            editinfo.put("bustype", audittype);
            String wheresql = " t.proguid = '"+mainguid+"'";
            financialAuditDAO.delDatas("V_PERF_T_EVALUATEAUDIT",wheresql);
            financialAuditDAO.save(editinfo, "V_PERF_T_EVALUATEAUDIT");
            datas = this.getDatas(ProConfirmDAO.PERF_TABLE_PROCONFIRM, " guid='" + mainguid + "' ", "");
            //更改主表的审核方式
            StringBuffer updatesql = new StringBuffer();
            updatesql.append(" update ").append(ProConfirmDAO.PERF_TABLE_PROCONFIRM).append(" t set t.audittype = '").append(ordinarytype).append("' where t.guid = '").append(mainguid).append("'");
            financialAuditDAO.execute(updatesql.toString());
            for (Map map:datas) {
                map.put("audittype",ordinarytype);
            }
        }
        Map<String, Object> workflowdata = this.workflow(ordinarytype, workflow, remark, ProConfirmDAO.PERF_TABLE_PROCONFIRM, datas);
        //处理规范表数据
        ResultBO resultBO = (ResultBO) ServiceFactory.getBean("pmkpi.evaluation.financial.ResultBOTX");
        resultBO.updateDeptEvalTabelDatas(datas, actioncode);
        // 处理债卷绩效
        if (datas != null && datas.size() > 0) {
            if (ordinarytype != null && "audit".equals(ordinarytype)) {
                String wfstatus = (String) datas.get(0).get("wfstatus");
                String pro_code = (String) datas.get(0).get("pro_code");
                if (wfstatus != null && !wfstatus.isEmpty() && "011".equals(wfstatus)
                        && pro_code != null && !pro_code.isEmpty()) {
                    //自评终审-同步终审债券绩效重点评价数据
                    logger.info("---债券绩效-参数 isGD_PMKPI : "+isGD_PMKPI+"");
                    if("1".equals(isGD_PMKPI)){
                        logger.info("---债券绩效重点-同步开始 ");
                        StringBuffer updatesql = new StringBuffer();
                        updatesql.append(" update ").append("V_GD_PERF_EVAL").append(" t set t.is_last_inst = 2").append(" where t.pro_code = '").append(pro_code).append("'");
                        financialAuditDAO.execute(updatesql.toString());
                        StringBuffer updatesql1 = new StringBuffer();
                        updatesql1.append(" update ").append("V_GD_PERF_EVAL_DTL").append(" t set t.is_last_inst = 2").append(" where t.pro_code = '").append(pro_code).append("'");
                        financialAuditDAO.execute(updatesql1.toString());
                    }

                }
            }
        }
        return workflowdata;
    }

    /**
     * 获取审核类型数据源
     * @param wheresql --
     * @return
     */
    public List<Map<String, Object>> getAudittypeDatas(String wheresql){
        return financialAuditDAO.getAudittypeDatas(wheresql);
    }

    /**
     * 下达评价通知
     * @param params --
     * @return --
     */
    public Map<String, Object> giveNotice(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas"); //选中数据
        String type = (String) params.get("type"); //按钮类型 取消2，下达1
        String wheresql = "";
        if (type != null && "givenotice".equals(type)) { //下达
            wheresql = " set t.isrelease = 1 ";
        } else if (type != null && "ungivenotice".equals(type)) { //取消下达
            wheresql = " set t.isrelease = 2";
        }
        financialAuditDAO.saveAll(datas, financialAuditDAO.PMKPI_TABLE_TMP_GUIDS);
        wheresql += " where exists(select 1 from " + financialAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
        financialAuditDAO.updateDatas(ProConfirmDAO.PERF_TABLE_PROCONFIRM, wheresql);
        backMap.put("success", true);
        return backMap;
    }

    //判断发起整改的数据表中是否存在
    public Integer getDataByGuid(HashMap<String, Object> params){
        String lefttabtype = (String) params.get("lefttabtype");
        String projguid = (String) params.get("projguid");
        String rectype = (String) params.get("rectype");
        String pro_code = (String) params.get("pro_code");
        StringBuffer sql = new StringBuffer("select count(*) from V_PERF_T_RECTIFY t where 1=1 ");
        if ("program".equals(lefttabtype)) { //项目支出
            sql.append(" and pro_code = '"+pro_code+"'");
        } else if ("dept".equals(lefttabtype)) { //部门整体
            sql.append(" and proguid = '"+projguid+"'");
        }
        sql.append(" and rectype = '"+rectype+"'  and wfstatus <> '011'");
        int i = financialAuditDAO.queryForInt(sql.toString());
        return i;
    }

}
