package gov.mof.fasp2.pmkpi.prorevision.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProrevisionReportBO extends PmkpiBO {
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
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select t.* from ");
        returnsql.append(tablecode);
        returnsql.append(" t where ");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1"); //数据权限
        returnsql.append(datarule);
        if (wheresql != null && !wheresql.isEmpty()){
            returnsql.append(" and (").append(wheresql).append(") ");
        }
        if (tablesql != null && !tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            returnsql.append(" and (").append(wfsql).append(")");
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, revisionReportDAO.PMKPI_TABLE_T_AGENCY));
        return returnsql.toString();
    }

    /**
     * 查询左侧树。
     * */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = revisionReportDAO.PERF_TABLE_PROVISIONDECLARE;
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        return revisionReportDAO.getLeftTree(tablecode, datarule);
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
        String tablecode = revisionReportDAO.PERF_TABLE_PROVISIONDECLARE;
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid, "perf", null);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> delrevision(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode = revisionReportDAO.PERF_TABLE_PROVISIONDECLARE;
        String goaltablecode = revisionReportDAO.PERF_T_TABLE_REVISIONGOAL;
        String indextablecode = revisionReportDAO.PERF_TABLE_PROVISIONDINDEX;
        List<Map<String,Object>> dellist =  (List<Map<String,Object>>)parms.get("datas");
        try {
            //删除修订表的数据
            revisionReportDAO.saveAll(dellist,revisionReportDAO.PMKPI_TABLE_TMP_GUIDS);
            String delsql = " exists(select 1 from " + revisionReportDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid) ";
            revisionReportDAO.delDatas(tablecode, delsql);
            //删除修订目标表的数据
            String maindelsql = " exists(select 1 from " + revisionReportDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.mainguid) ";
            revisionReportDAO.delDatas(goaltablecode, maindelsql);
            //删除修订目标表的数据
            revisionReportDAO.delDatas(indextablecode, maindelsql);
            backMap.put("flg","1");
        }catch (AppException e){
            logger.error("删除调整项目时："+e.getMessage());
            backMap.put("flg","2");
        }
        return backMap;
    }

}
