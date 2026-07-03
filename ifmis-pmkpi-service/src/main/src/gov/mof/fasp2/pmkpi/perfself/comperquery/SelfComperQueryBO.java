package gov.mof.fasp2.pmkpi.perfself.comperquery;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SelfComperQueryBO extends PmkpiBO {

    private SelfComperQueryDAO selfComperQueryDAO;

    public void setSelfComperQueryDAO(SelfComperQueryDAO selfComperQueryDAO) {
        this.selfComperQueryDAO = selfComperQueryDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String isleaf = (String) sqlmap.get("isleaf");
        String agency = (String) sqlmap.get("agency");
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(selfComperQueryDAO.PERF_SELECTCOMPER_QUERY).append(" t ");
        sql.append(" where t.bustype='").append(lefttabtype).append("'");
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, selfComperQueryDAO.PMKPI_TABLE_T_AGENCY));
        sql.append(datarule);
        return sql.toString();
    }

    /**
     * <p>左侧树-整合菜单首次进入页面</p >
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String lefttabtype = (String) params.get("lefttabtype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        datarule += " and bustype='" + lefttabtype + "'";
        return selfComperQueryDAO.getLeftTree(selfComperQueryDAO.PERF_SELECTCOMPER_QUERY, datarule);
    }
}
