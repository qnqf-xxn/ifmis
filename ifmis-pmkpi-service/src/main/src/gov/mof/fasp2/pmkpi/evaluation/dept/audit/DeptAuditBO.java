package gov.mof.fasp2.pmkpi.evaluation.dept.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptAuditBO extends PmkpiBO {
    private DeptAuditDAO deptAuditDAO;

    public void setDeptAuditDAO(DeptAuditDAO deptAuditDAO) {
        this.deptAuditDAO = deptAuditDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String type = (String) sqlmap.get("type"); //项目调整选择项目
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String columncode = "agencyguid";
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select t.* from ").append(DeptAuditDAO.PERF_TABLE_DEPTEVAL).append(" t where t.bustype='").append(lefttabtype).append("' ");
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
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, deptAuditDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        return returnsql.toString();
    }

    public List getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode="v_perf_t_deptevaluation";
        String bustype = (String) params.get("bustype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype='" + bustype + "' ";
        return deptAuditDAO.getLeftTree(tablecode, datarule);
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
        this.workflow(actioncode, workflow, remark, DeptAuditDAO.PERF_TABLE_DEPTEVAL, datas);
        if (actioncode != null && "cancelaudit".equals(actioncode)) {
            deptAuditDAO.saveAll(datas, deptAuditDAO.PMKPI_TABLE_TMP_GUIDS);
            String wheresql = " exists (select 1 from " + deptAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.mainguid) ";
            deptAuditDAO.delDatas("v_perf_expertreview", wheresql);
            wheresql = " exists (select 1 from " + deptAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.review) ";
            deptAuditDAO.delDatas("perf_reviewintermediary", wheresql);
        }
        //处理规范表数据
        DeptAuditBO deptAuditBO = (DeptAuditBO) ServiceFactory.getBean("pmkpi.evaluation.dept.audit.DeptAuditBOTX");
        deptAuditBO.updateDeptEvalTabelDatas(datas, actioncode);
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
        return deptAuditDAO.getDataMap("v_perf_t_evaluateaudit", sql);
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
        if (audittype != null && "feedback".equals(audittype)) {
            //查询主单数据
            Map<String, Object> finMap = deptAuditDAO.getDataMap(DeptAuditDAO.PERF_TABLE_DEPTEVAL, " guid='"+mainguid+"' ");
            finMap.put("opinion", remark);
            deptAuditDAO.update(finMap, DeptAuditDAO.PERF_TABLE_DEPTEVAL);
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
            deptAuditDAO.delDatas("V_PERF_T_EVALUATEAUDIT",wheresql);
            deptAuditDAO.save(editinfo, "V_PERF_T_EVALUATEAUDIT");
            datas = this.getDatas(DeptAuditDAO.PERF_TABLE_DEPTEVAL, " guid='" + mainguid + "' ", "");
        }
        Map<String, Object> auditdata = this.workflow(ordinarytype, workflow, remark, DeptAuditDAO.PERF_TABLE_DEPTEVAL, datas);
        //处理规范表数据
        this.updateDeptEvalTabelDatas(datas, actioncode);
        return auditdata;    }

    /**
     * 获取审核类型数据源
     * @param wheresql --
     * @return
     */
    public List<Map<String, Object>> getAudittypeDatas(String wheresql){
        return deptAuditDAO.getAudittypeDatas(wheresql);
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
        deptAuditDAO.saveAll(datas, deptAuditDAO.PMKPI_TABLE_TMP_GUIDS);
        wheresql += " where exists(select 1 from " + deptAuditDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
        deptAuditDAO.updateDatas(deptAuditDAO.PMKPI_TABLE_TMP_GUIDS, wheresql);
        backMap.put("success", true);
        return backMap;
    }


    //判断发起整改的数据表中是否存在
    public Integer getDataByGuid(HashMap<String, Object> params){
        String lefttabtype = (String) params.get("lefttabtype");
        String projguid = (String) params.get("projguid");
        String rectype = (String) params.get("rectype");
        String pro_code = (String) params.get("pro_code");
        StringBuffer sql = new StringBuffer("select count(*) from V_PERF_T_RECTIFY t where ");
        sql.append(" rectype = '"+rectype+"'  and wfstatus <> '011'");
        if ("program".equals(lefttabtype)) { //项目支出
            sql.append(" and pro_code = '"+pro_code+"'");
        } else if ("dept".equals(lefttabtype)) { //部门整体
            sql.append(" and proguid = '"+projguid+"'");
        }
        int i = deptAuditDAO.queryForInt(sql.toString());
        return i;
    }

    /**
     * 处理规范表数据
     * @param data
     * @param actioncode
     * @throws AppException
     */
    public void updateDeptEvalTabelDatas ( List<Map<String, Object>> data, String actioncode) throws AppException {
        deptAuditDAO.updateDeptEvalTabelDatas(data,actioncode);
    }

}
