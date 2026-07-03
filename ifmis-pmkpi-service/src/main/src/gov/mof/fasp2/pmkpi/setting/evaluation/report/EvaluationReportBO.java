package gov.mof.fasp2.pmkpi.setting.evaluation.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EvaluationReportBO extends PmkpiBO {
    private EvaluationReportDAO evaluationReportDAO;

    public void setEvaluationReportDAO(EvaluationReportDAO evaluationReportDAO) {
        this.evaluationReportDAO = evaluationReportDAO;
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
        //过滤掉事前绩效评估表已有的项目
        returnsql.append("select t.* from ").append(tablecode).append(" t where ");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1"); //数据权限
        returnsql.append(datarule);
        if (wheresql != null && !wheresql.isEmpty()){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, evaluationReportDAO.PMKPI_TABLE_T_AGENCY));
        return returnsql.toString();
    }

    /**
     * 查询左侧树。
     * */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = "V_PERF_T_EVALUATION";
        //String lefttabtype = (String) params.get("lefttabtype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        //datarule += " and bustype='" + lefttabtype + "' ";
        return evaluationReportDAO.getLeftTree(tablecode, datarule);
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
        String tablecode = "V_PERF_T_EVALUATION";
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
        String tablecode = (String) parms.get("tablecode");
        List<Map<String,Object>> dellist =  (List<Map<String,Object>>)parms.get("datas");
        try {
            //删除修订表的数据
            evaluationReportDAO.saveAll(dellist,evaluationReportDAO.PMKPI_TABLE_TMP_GUIDS);
            String delsql = " exists(select 1 from " + evaluationReportDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid) ";
            evaluationReportDAO.delDatas(tablecode, delsql);
            backMap.put("flg","1");
        }catch (AppException e){
            logger.error("删除事前绩效评估数据时："+e.getMessage());
            backMap.put("flg","2");
        }
        return backMap;
    }

    public List getData(Map sqlmap) throws AppException {
        String sql = this.getVodSql(sqlmap);
        List list = evaluationReportDAO.queryForList(sql);
        return list;
    }
}
