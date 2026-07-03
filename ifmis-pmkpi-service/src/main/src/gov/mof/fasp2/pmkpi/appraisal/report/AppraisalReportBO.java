package gov.mof.fasp2.pmkpi.appraisal.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AppraisalReportBO extends PmkpiBO {
    private AppraisalReportDAO appraisalReportDAO;

    public void setAppraisalReportDAO(AppraisalReportDAO appraisalReportDAO) {
        this.appraisalReportDAO = appraisalReportDAO;
    }

    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算部门");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String treesource = PerfUtil.getSystemSet("dept_letftree");
        if (!StringUtils.isEmpty(treesource)) {
            // 数据权限
            String sql = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
            leftconfig.put("datas", PerfUtil.getSourceData(treesource, sql));
        }
        return leftconfig;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String querysql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String) sqlmap.get("menuid");
        String tablecode = (String) sqlmap.get("tablecode");
        String wheresql = (String) sqlmap.get("tablesql");
        String workflow = (String) sqlmap.get("workflow");
        String tabcode = (String) sqlmap.get("tabcode");
        String agencyguid = (String) sqlmap.get("agencyguid");
        String isleaf = sqlmap.get("isleaf") + "";
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where ");
        String datarulesql = this.getDataRuleByMenuguidNull(menuid, "t", "1=1");
        sql.append(datarulesql);
        if (querysql != null && ! querysql.isEmpty()){
            sql.append(" and (").append(querysql).append(")");
        }
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            sql.append(" and ( ").append(wfsql);
            if (tabcode != null && !tabcode.isEmpty() && "waitaudit".equals(tabcode)){
                sql.append(" or wfstatus is null ");
            }
            sql.append(" )");
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agencyguid, appraisalReportDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }

    public void save(Map<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String tablecode = (String) params.get("tablecode");
        String workflow = (String) params.get("workflow");
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("createtime", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", SecureUtil.getUserSelectYear());
                map.put("creater", SecureUtil.getCurrentUserID());
                addlist.add(map);
            } else {
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            this.workflow("create", workflow, null, tablecode, addlist);
        }
        if (uplist.size() > 0) {
            appraisalReportDAO.updateAllByPK(uplist, "guid", tablecode);
        }
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode = (String) parms.get("tablecode");
        List<String> delguids =  (List<String>)parms.get("delguids");
        if (delguids.size() > 0) {
            String delsql = appraisalReportDAO.createInSql("guid", delguids);
            appraisalReportDAO.delDatas(tablecode, delsql);
        }
        backMap.put("flg","1");
        return backMap;
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> seldatas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, seldatas);
        return this.auditdefine(seldatas, busguid, actioncode, null);
    }

    /**
     * 根据单位编码，查询数据
     * @param params
     * @return
     */
    public Map<String, Object> getDataByAgencyCode(HashMap<String, Object> params) {
        String agencyguid = (String) params.get("agencyguid");
        String tablecode = (String) params.get("tablecode");
        return appraisalReportDAO.getDataMap(tablecode, "agencyguid=?", new String[]{agencyguid});
    }
}
