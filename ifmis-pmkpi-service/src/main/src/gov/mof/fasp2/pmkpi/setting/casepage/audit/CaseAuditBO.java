package gov.mof.fasp2.pmkpi.setting.casepage.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.setting.casepage.report.CaseReportDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CaseAuditBO extends PmkpiBO {
    private CaseAuditDAO caseAuditDAO;

    public void setCaseAuditDAO(CaseAuditDAO caseAuditDAO) {
        this.caseAuditDAO = caseAuditDAO;
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
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String isCasetype = (String) sqlmap.get("isCasetype");
        String leftsource = (String) sqlmap.get("leftsource");
        StringBuffer returnsql = new StringBuffer("select * from ").append(tablecode).append(" t ");
        returnsql.append(" where bustype='").append(lefttabtype).append("'");
        if (StringUtil.isEmpty(isCasetype)) {
            String columncode = "agencyguid";
            returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, nodeguid, caseAuditDAO.PMKPI_TABLE_T_AGENCY));
        } else {
            if ("treeroot".equals(nodeguid)) {
                returnsql.append(" and exists(select 1 from v_perf_enum en where en.guid=t.casetype and en.elementcode='" + leftsource + "')");
            } else if ("1".equals(isleaf)) {
                returnsql.append(" and casetype='").append(nodeguid).append("'");
            } else if (!"treeroot".equals(nodeguid) && "0".equals(isleaf)) {
                List<Map<String,Object>> list = caseAuditDAO.getCaseType(nodeguid, leftsource);
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
        if (wheresql != null && ! wheresql.isEmpty()){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && ! tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && ! tabfilter.isEmpty()){
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && ! wfsql.isEmpty()) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }
        returnsql.append(datarule);
        return returnsql.toString();
    }

    public Map<String, Object> getTreeData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        String leftmenuid = (String) params.get("leftmenuid");
        String leftsource = (String) params.get("leftsource");
        String tablecode = (String) params.get("tablecode");
        String lefttabtype = (String) params.get("lefttabtype");
        String datarule = "";
        List treeDatas = null;
        if (CaseReportDAO.CASETYEP_SOURCE.equals(leftsource)) {
            String wheresql = "(select en.*,'' as agencyguid from v_perf_enum en where en.elementcode='" + leftsource + "' order by en.ordernum)";
            treeDatas = caseAuditDAO.getLeftTree(tablecode, datarule, wheresql, "casetype");
            backMap.put("isCasetype", "true");
        } else {
            datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
            datarule += " and bustype='" + lefttabtype + "' ";
            //根据权限查询单位
            treeDatas = caseAuditDAO.getLeftTree(tablecode, datarule);
        }
        backMap.put("treeDatas", treeDatas);
        return backMap;
    }


    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String bustype = (String) params.get("bustype");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String busguid = (String) params.get("busguid");
        String tablecode = CaseReportDAO.TABLECODE_T_CASE;
        //取消审核
        if ("cancelaudit".equals(actioncode)) {
            this.adjustBeforeDatas(datas, "cancel");
        }
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        //审核
        if ("audit".equals(actioncode) || "auditbatch".equals(actioncode)) {
            this.basIndexData(datas, bustype);
            this.adjustBeforeDatas(datas, null);
        }
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 处理调整前数据
     * @param datas
     */
    public void adjustBeforeDatas(List<Map<String, Object>> datas, String type) {
        StringBuffer beforeAdjustGuids = new StringBuffer();//调整前guid
        for (Map<String, Object> data : datas) {
            String wfstatus = (String) data.get("wfstatus");
            String adjustguid = (String) data.get("adjustguid");
            //判断数据是否已终审
            if ("011".equals(wfstatus)) {
                //是否是选择的案例
                if (!StringUtil.isEmpty(adjustguid)){
                    beforeAdjustGuids.append("'").append(adjustguid).append("',");
                }
            }
        }
        //是否存在选择的案例，且是已终审
        if (beforeAdjustGuids.length() > 0) {
            //取消终审，把调整前数据还原
            int is_deleted = 1; //默认状态，终审删除
            if ("cancel".equals(type)) {
                is_deleted = 2;
            }
            String time = PerfUtil.getServerTimeStamp();
            beforeAdjustGuids.deleteCharAt(beforeAdjustGuids.length() - 1);
            //处理选择前案例，取消终审进行数据状态恢复/终审进行数据删除
            String wheresql = " set is_deleted = " + is_deleted + ", updatetime='" + time + "' where guid in(" + beforeAdjustGuids.toString() + ") ";
            caseAuditDAO.updateDatas(CaseReportDAO.TABLECODE_CASE, wheresql);
            wheresql = " set is_deleted = " + is_deleted + ", updatetime='" + time + "' where mainguid in(" + beforeAdjustGuids.toString() + ") ";
            caseAuditDAO.updateDatas(CaseReportDAO.TABLECODE_CASEMODELGOAL, wheresql);
            caseAuditDAO.updateDatas(CaseReportDAO.TABLECODE_CASEMODELINDEX, wheresql);
        }
    }

    /**
     * 终审--处理案例指标入部门指标库
     * @param datas
     */
    public void basIndexData(List<Map<String, Object>> datas, String bustype) throws AppException {
        StringBuffer beforeAdjustGuids = new StringBuffer();//调整前guid
        StringBuffer addCaseGuids = new StringBuffer();//新增案例guid
        StringBuffer adjustGuids = new StringBuffer();//调整案例guid
        List<Map<String, Object>> basIndexList = new ArrayList<>();//入部门指标库数据
        List<Map<String, Object>> addIndexList = new ArrayList<>();//新增案例指标，入部门指标库数据
        List<Map<String, Object>> adjustIndexList = new ArrayList<>();//调整指标，入部门指标库数据
        String tablecode = CaseReportDAO.TABLECODE_T_CASEMODELINDEX;
        String basTablecode = caseAuditDAO.PMKPI_TABLE_BAS_PERF_INDICATOR;
        for (Map<String, Object> data : datas) {
            String wfstatus = (String) data.get("wfstatus");
            String adjustguid = (String) data.get("adjustguid");
            String caseguid = (String) data.get("guid");
            String status = data.get("status") + "";
            //判断数据是否已终审
            if ("011".equals(wfstatus)) {
                //是否是选择的案例
                if (!StringUtil.isEmpty(adjustguid)){
                    beforeAdjustGuids.append("'").append(adjustguid).append("',");
                }
                //是新增案例
                if ("1".equals(status)) {
                    addCaseGuids.append("'").append(caseguid).append("',");
                }
                //选择案例，修改状态
                if ("2".equals(status)) {
                    adjustGuids.append("'").append(caseguid).append("',");
                }
            }
        }
        String wheresql = "";
        String caseguids = "";
        if (addCaseGuids.length() > 0) {
            addCaseGuids.deleteCharAt(addCaseGuids.length() - 1);
            wheresql = " mainguid in(" + addCaseGuids.toString() + ") ";
            addIndexList = caseAuditDAO.getDatas(tablecode, wheresql, null);
            caseguids += addCaseGuids;
        }
        if (adjustGuids.length() > 0) {
            adjustGuids.deleteCharAt(adjustGuids.length() - 1);
            wheresql = " mainguid in(" + adjustGuids.toString() + ") and status in(1, 2)";
            adjustIndexList = caseAuditDAO.getDatas(tablecode, wheresql, null);
            if (!caseguids.isEmpty()) {
                caseguids += ",";
            }
            caseguids += adjustGuids;
        }
        if (addIndexList.size() > 0) {
            basIndexList.addAll(addIndexList);
        }
        if (adjustIndexList.size() > 0) {
            basIndexList.addAll(adjustIndexList);
        }
        if (basIndexList.size() > 0) {
            //删除调整前数据，不包含调整删除部分
            //根据调整guid查询案例指标，根据调整前案例指标guid关联出指标库指标（包含status 2修改，1新增，以及status为空的数据）
            wheresql = "exists (select 1 from " + CaseReportDAO.TABLECODE_CASEMODELINDEX + " a where exists( select 1 from " + CaseReportDAO.TABLECODE_CASE + " b where a.mainguid=b.guid and b.guid in(" + caseguids + ")) and (a.guid=t.tindex or a.adjustindexguid=t.tindex) and a.status in(1,2))";
            caseAuditDAO.updateIsDeleteDatas(basTablecode, wheresql);
            for (Map<String, Object> basIndexMap : basIndexList) {
                basIndexMap.put("tindex", basIndexMap.get("guid"));
                basIndexMap.put("guid", this.getCreateguid());
                basIndexMap.put("status", 1);
                basIndexMap.put("is_common_ind", 2);
                basIndexMap.put("apply_status", 1);
                basIndexMap.put("agency_code", basIndexMap.get("agencyguid"));
                basIndexMap.put("ind_id", basIndexMap.get("guid"));
                basIndexMap.put("perf_ind_name", basIndexMap.get("name"));
                basIndexMap.put("perf_ind_code", basIndexMap.get("code"));
                basIndexMap.put("kpi_val", basIndexMap.get("indexvalue"));
                basIndexMap.put("parent_id", basIndexMap.get("sindex"));
                basIndexMap.put("level_no", 3);
                basIndexMap.put("is_leaf", 1);
                basIndexMap.put("wfstatus", "011");
                basIndexMap.put("framesystem", bustype);
                basIndexMap.put("wfid", "2F62B0E1A972408B8330D3653F836522");
                if(StringUtil.isNullOrEmpty((String) basIndexMap.get("value_desc"))){
                    basIndexMap.put("value_desc", basIndexMap.get("perf_ind_name"));
                }
                if ("DEPT".equals(bustype)) {
                    basIndexMap.put("is_pm_perf_ind", 2);
                } else {
                    basIndexMap.put("is_pm_perf_ind", 1);
                }
                basIndexMap.put("is_last_inst", 1);
                this.getBasMap(basIndexMap, "add");
            }
            //新增指标入库
            caseAuditDAO.saveAll(basIndexList, basTablecode);
        }
    }

}
