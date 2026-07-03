package gov.mof.fasp2.pmkpi.perfprogram.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TlpProgramQueryBO extends PmkpiBO {
    private TlpProgramQueryDAO tlpProgramQueryDAO;

    public void setTlpProgramQueryDAO(TlpProgramQueryDAO tlpProgramQueryDAO) {
        this.tlpProgramQueryDAO = tlpProgramQueryDAO;
    }

    public Map<String, Object> getTreeData(String menuId, String prolev) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", Integer.valueOf(2));
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        List treelist = new ArrayList();
        Map<String, Object> map = new HashMap<>();
        map.put("guid","0");
        map.put("code","00");
        map.put("superid","0");
        map.put("levelno","1");
        map.put("isleaf","0");
        treelist.add(map);
        leftconfig.put("datas", treelist);
        return leftconfig;
    }

    /**
     * 查询左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        String leftmenuid = (String) params.get("menuid");
        String tablesql = (String) params.get("tablesql");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        if (!StringUtil.isNullOrEmpty(tablesql)) {
            datarule += " and " + tablesql;
        }
        return tlpProgramQueryDAO.getLeftTree(tablecode, datarule);
    }

    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String)sqlmap.get("querySql");
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf");
        String agency = (String)sqlmap.get("agency");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String)sqlmap.get("tabfilter");
        String tablesql = (String)sqlmap.get("tablesql");
        String type = (String)sqlmap.get("type");
        String datarule = getDataRuleByMenuguidNull(menuid, "t", "1=1");
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where ");
        StringBuffer wsql = new StringBuffer();
        if ((type != null) && ("1".equals(type))) {
            wsql.append(" and v_col12 = '1' ");
        }
        if ((wheresql != null) && (!wheresql.isEmpty())) {
            wsql.append(" and (").append(wheresql).append(") ");
        }
        if ((tablesql != null) && (!tablesql.isEmpty())) {
            wsql.append(" and ").append(tablesql);
        }
        if ((tabfilter != null) && (!tabfilter.isEmpty())) {
            wsql.append(" and ").append(tabfilter);
        }
        sql.append(datarule);
        if (wsql.length() > 0) {
            sql.append(wsql);
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, tlpProgramQueryDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }
}