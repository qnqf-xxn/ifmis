package gov.mof.fasp2.pmkpi.autoview;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReportBO extends PmkpiBO {

    private ReportDAO reportDAO;

    public void setReportDAO(ReportDAO reportDAO) {
        this.reportDAO = reportDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf");
        String agency = (String)sqlmap.get("agency");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1"); //数据权限
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where ");
        sql.append(datarule).append("");
        if (wheresql != null && !wheresql.isEmpty()){
            sql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !tablesql.isEmpty()){
            sql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            sql.append(" and ").append(tabfilter);
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, reportDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }

    /**
     * 获取左侧树数据.
     * @param menuId -- 菜单
     * @param  viewtable -- 报表视图
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId,String viewtable) throws AppException {
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", this.getLeftTreeData(menuId,viewtable));
        return leftconfig;
    }
    /**
     * 左侧树数据
     * @param menuId --菜单
     * @param viewtable --报表视图
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getLeftTreeData(String menuId,String viewtable)
            throws AppException {
        String sql = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        //根据权限查询
        return reportDAO.getLeftTree(viewtable, sql);
    }
}
