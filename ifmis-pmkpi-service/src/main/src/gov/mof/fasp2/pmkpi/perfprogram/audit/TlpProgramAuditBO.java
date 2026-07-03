package gov.mof.fasp2.pmkpi.perfprogram.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TlpProgramAuditBO extends PmkpiBO {
	
	private TlpProgramAuditDAO tlpProgramAuditDAO;

	public void setTlpProgramAuditDAO(TlpProgramAuditDAO tlpProgramAuditDAO) {
		this.tlpProgramAuditDAO = tlpProgramAuditDAO;
	}

    /**
    * 列表查询
    * @param sqlmap
    * @return
    * @throws AppException
    */
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf");
        String agency = (String)sqlmap.get("agency");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String workflow = (String) sqlmap.get("workflow");
        String tablesql = (String) sqlmap.get("tablesql");//查询条件
        String tabcode = (String) sqlmap.get("tabcode");
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1"); //数据权限
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where ");
        StringBuffer wsql = new StringBuffer();
        if (wheresql != null && !wheresql.isEmpty()){
            wsql.append(" and (").append(wheresql).append(")");
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            wsql.append(" and ").append(tabfilter);
        }
        if (tablesql != null && !tablesql.isEmpty()){
            wsql.append(" and ").append(tablesql);
        }
        String wfsql = getWfSql(tabcode, workflow);
        if (wfsql != null && !"".equals(wfsql)) {
            wsql.append(" and ").append(wfsql);
        }
        sql.append(datarule);
        if (wsql.length() > 0) {
            sql.append(wsql);
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, tlpProgramAuditDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
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
        String sysvalue = PerfUtil.getSystemSet("tlprogram_lefttree_" + prolev);
        if (StringUtil.isEmpty(sysvalue)){
            sysvalue  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        }
        leftconfig.put("datas", this.getLeftTree(menuId,sysvalue));
        return leftconfig;
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid, actioncode, null);
    }

}
