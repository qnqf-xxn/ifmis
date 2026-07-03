package gov.mof.fasp2.pmkpi.perfprogram.approvalquery;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ApprovalQueryBO extends PmkpiBO {

    private ApprovalQueryDAO approvalQueryDAO;

    public void setApprovalQueryDAO(ApprovalQueryDAO approvalQueryDAO) {
        this.approvalQueryDAO = approvalQueryDAO;
    }

    /**
     * 获取左侧树数据.-临时表
     *
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String tablecode = "V_PERF_BGT_PROJECTPF";
        String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        List<Map<String, Object>> treelist = approvalQueryDAO.getLeftTree(tablecode, datarule);
        leftconfig.put("datas", treelist);
        return leftconfig;
    }

    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String menuid = (String) sqlmap.get("menuid");
        String isleaf = (String) sqlmap.get("isleaf");
        String agency = (String) sqlmap.get("agency");
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String type = (String) sqlmap.get("type");
        String prolev = (String) sqlmap.get("prolev");
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null);
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where 1=1 ");
        if (type != null && "1".equals(type)) { // 如果是事前绩效评估查询-V_COL12：1-是；2-否；
            sql.append(" and v_col12 = '1'");
        }
        if (!StringUtils.isEmpty(prolev)) { // 如果级别字段不为空则加入条件查询
            sql.append(" and pro_lev = '" + prolev + "'");
        }
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            sql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            sql.append(" and ").append(tabfilter);
        }
        String columncode = "agencyguid";
        String leftwheresql = "";
        if("1".equals(isleaf)) {
            leftwheresql = " and t." + columncode + " ='" + agency + "' ";
        } else if (!"1".equals(isleaf) && !"treeroot".equals(agency)){
            leftwheresql = " and t." + columncode + " like'" + agency.substring(0,3) + "%' ";  //或者对 or 加括号
        }
        sql.append(leftwheresql).append(datarule);
        return sql.toString();
    }
}
