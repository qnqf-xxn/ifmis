package gov.mof.fasp2.pmkpi.perfselfreview.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfSelfReviewQueryBO extends PmkpiBO {

    public PerfSelfReviewQueryDAO perfSelfReviewQueryDAO;

    public void setPerfSelfReviewQueryDAO(PerfSelfReviewQueryDAO perfSelfReviewQueryDAO) {
        this.perfSelfReviewQueryDAO = perfSelfReviewQueryDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
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
        String workflow = (String) sqlmap.get("workflow");
        String tabcode = (String) sqlmap.get("tabcode");
        String MINAMOUNT = queryParam.get("c1");
        String MAXAMOUNT = queryParam.get("c2");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
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
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where ");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1"); //数据权限
        sql.append(datarule);
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            sql.append(" and (").append(tabfilter).append(")");
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            sql.append(" and (").append(wfsql).append(")");
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, perfSelfReviewQueryDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }

    /**
     * <p>左侧树-整合菜单首次进入页面</p >
     * @param
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        return perfSelfReviewQueryDAO.getLeftTree(tablecode, datarule);
    }
}
