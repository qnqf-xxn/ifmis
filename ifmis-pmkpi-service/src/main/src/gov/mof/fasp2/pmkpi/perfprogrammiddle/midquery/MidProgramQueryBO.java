package gov.mof.fasp2.pmkpi.perfprogrammiddle.midquery;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MidProgramQueryBO extends PmkpiBO {
	
	private MidProgramQueryDAO midProgramQueryDAO;

	public void setMidProgramQueryDAO(MidProgramQueryDAO midProgramQueryDAO) {
		this.midProgramQueryDAO = midProgramQueryDAO;
	}
    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId, String prolev) throws AppException {
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String sysvalue = PerfUtil.getSystemSet("midprogram_lefttree_" + prolev);
        if (StringUtil.isEmpty(sysvalue)){
            sysvalue  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        }
        leftconfig.put("datas", this.getLeftTreeData(menuId,sysvalue));
        return leftconfig;
    }

    /**
     * 左侧树数据
     * @param menuId
     * @param sysvalue
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getLeftTreeData(String menuId,String sysvalue)
            throws AppException {
        String tablecode = "V_PERF_T_DEPTPERFMIDDECLARE";
        String sql = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        //根据权限查询
        return midProgramQueryDAO.getLeftTree(tablecode, sql);
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
        StringBuffer wsql = new StringBuffer();
        if (wheresql != null && !wheresql.isEmpty()){
            wsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()){
            wsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            wsql.append(" and ").append(tabfilter);
        }
        sql.append(datarule);
        if (wsql.length() > 0) {
            sql.append(wsql);
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, midProgramQueryDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }
}
